
// derived from https://reprap.org/wiki/File:RAMPS1.4_TestCode.pde
// before compiling, please install U8g2 by oliver from the arduino library manager

#include <Arduino.h>
#include <SPI.h>
//#include <U8glib.h> // older deprecated glib
#include <U8g2lib.h> // https://github.com/olikraus/u8g2

// This optional setting causes Encoder to use more optimized code,
// It must be defined before Encoder.h is included.
#define ENCODER_OPTIMIZE_INTERRUPTS
#include <Encoder.h> // https://github.com/PaulStoffregen/Encoder
// alternate AdaEncoder: https://playground.arduino.cc/Main/RotaryEncoders

#include <PinChangeInterrupt.h>
/* 
 Arduino Uno/Nano/Mini: All pins are usable  
 Arduino Mega: 10, 11, 12, 13, 50, 51, 52, 53, A8 (62), A9 (63), A10 (64),
               A11 (65), A12 (66), A13 (67), A14 (68), A15 (69)
 Arduino Leonardo/Micro: 8, 9, 10, 11, 14 (MISO), 15 (SCK), 16 (MOSI)
 HoodLoader2: All (broken out 1-7) pins are usable
 Attiny 24/44/84: All pins are usable
 Attiny 25/45/85: All pins are usable
 Attiny 13: All pins are usable
 Attiny 441/841: All pins are usable
 ATmega644P/ATmega1284P: All pins are usable
*/

#define X_STEP_PIN         54
#define X_DIR_PIN          55
#define X_ENABLE_PIN       38
#define X_MIN_PIN           3
#define X_MAX_PIN           2

#define Y_STEP_PIN         60
#define Y_DIR_PIN          61
#define Y_ENABLE_PIN       56
#define Y_MIN_PIN          14
#define Y_MAX_PIN          15

#define Z_STEP_PIN         46
#define Z_DIR_PIN          48
#define Z_ENABLE_PIN       62
#define Z_MIN_PIN          18
#define Z_MAX_PIN          19

#define E_STEP_PIN         26
#define E_DIR_PIN          28
#define E_ENABLE_PIN       24

#define Q_STEP_PIN         36
#define Q_DIR_PIN          34
#define Q_ENABLE_PIN       30

#define SDPOWER            -1
#define SDSS               53
#define LED_PIN            13

#define FAN_PIN            9

#define PS_ON_PIN          12
#define KILL_PIN           -1

#define HEATER_0_PIN       10
#define HEATER_1_PIN       8
#define TEMP_0_PIN          13   // ANALOG NUMBERING
#define TEMP_1_PIN          14   // ANALOG NUMBERING

// https://reprap.org/wiki/RepRapDiscount_Smart_Controller

//encoder pins  
#define BTN_EN1 31 //[RAMPS14-SMART-ADAPTER]  
#define BTN_EN2 33 //[RAMPS14-SMART-ADAPTER]  
#define BTN_ENC 35 //[RAMPS14-SMART-ADAPTER]  
Encoder myEnc(BTN_EN1, BTN_EN2);

//#define BTN_EN1          11
//    #define BTN_EN2          10
//    #define BTN_ENC          16

//#define BTN_EN2           75   // J4, UP
//  #define BTN_EN1           73   // J3, DOWN
//#define BTN_CENTER        15   // J0
//  #define BTN_ENC           BTN_CENTER

 //beeper  
#define BEEPER 37 //[RAMPS14-SMART-ADAPTER] / 37 = enabled; -1 = dissabled / (if you don't like the beep sound ;-)

 //SD card detect pin  
#define SDCARDDETECT 49 //[RAMPS14-SMART-ADAPTER]

//U8GLIB_ST7920_128X64_1X u8g(23, 17, 16);  // SPI Com: SCK = en = 23, MOSI = rw = 17, CS = di = 16
U8G2_ST7920_128X64_1_SW_SPI u8g2(U8G2_R0, 23, 17, 16);

void drawText( char* buf ) {
  u8g2.firstPage();
  do {
    u8g2.setFont(u8g2_font_ncenB14_tr);
    u8g2.drawStr( 0, 20, buf);
  } while ( u8g2.nextPage() );
}

int e1 = 0;
int e2 = 0;
void enc1() {
  e1 += 1;
}
void enc2() {
  e2 += 1;
}
 
void setup() {
  u8g2.begin();
  pinMode(FAN_PIN , OUTPUT);
  pinMode(HEATER_0_PIN , OUTPUT);
  pinMode(HEATER_1_PIN , OUTPUT);
  pinMode(LED_PIN  , OUTPUT);
  
  pinMode(X_STEP_PIN  , OUTPUT);
  pinMode(X_DIR_PIN    , OUTPUT);
  pinMode(X_ENABLE_PIN    , OUTPUT);
  
  pinMode(Y_STEP_PIN  , OUTPUT);
  pinMode(Y_DIR_PIN    , OUTPUT);
  pinMode(Y_ENABLE_PIN    , OUTPUT);
  
  pinMode(Z_STEP_PIN  , OUTPUT);
  pinMode(Z_DIR_PIN    , OUTPUT);
  pinMode(Z_ENABLE_PIN    , OUTPUT);
  
  pinMode(E_STEP_PIN  , OUTPUT);
  pinMode(E_DIR_PIN    , OUTPUT);
  pinMode(E_ENABLE_PIN    , OUTPUT);
  
  pinMode(Q_STEP_PIN  , OUTPUT);
  pinMode(Q_DIR_PIN    , OUTPUT);
  pinMode(Q_ENABLE_PIN    , OUTPUT);

  pinMode(BTN_EN1    , INPUT_PULLUP);
  pinMode(BTN_EN2    , INPUT_PULLUP);
  pinMode(BTN_ENC    , INPUT_PULLUP);

  digitalWrite(BEEPER,LOW);

  digitalWrite(X_ENABLE_PIN    , HIGH);
  digitalWrite(Y_ENABLE_PIN    , HIGH);
  digitalWrite(Z_ENABLE_PIN    , HIGH);
  digitalWrite(E_ENABLE_PIN    , LOW); // HIGH disable, LOW enable
  digitalWrite(Q_ENABLE_PIN    , HIGH);

  //attachPCINT( digitalPinToPCINT( BTN_EN1 ), enc1, CHANGE ); 
  //attachPCINT( digitalPinToPCINT( BTN_EN2 ), enc2, CHANGE ); 

  drawText( "Coilbot" );
}

int x = 0;
void loop () {  
  /* 
  u8g.firstPage();
  do {
    // graphic commands to redraw the complete screen should be placed here  
    u8g.setFont(u8g_font_unifont);
    u8g.drawStr( 0, 20, "Hello World!");
  } while( u8g.nextPage() );
  */
    
  //while(1) {
    int encoderbutton = digitalRead(BTN_ENC) == LOW;
    int enc = myEnc.read();
    //myEnc.write( enc % 10 ); // change/correct the value
    if ((x%5000) == 0) {
      char buf[256];
      sprintf( buf, "Press: %d %d", (x%1000), -enc );
      drawText( buf );
    }
    ++x;
  //}
  
  //delay(1);
  /*
  int encoderbutton = digitalRead(BTN_ENC) == LOW;
  if (encoderbutton) {
    int speed = 4;
    bool fwd = (millis() % (10000/speed) < (5000/speed));
    if (fwd)
      digitalWrite(E_DIR_PIN    , HIGH);
    else 
      digitalWrite(E_DIR_PIN    , LOW);
    digitalWrite(E_STEP_PIN    , HIGH);
    delayMicroseconds(40);
    digitalWrite(E_STEP_PIN    , LOW);
  }
  */
  

  // examples
  /*
  if (millis() %1000 <500) 
    digitalWrite(LED_PIN, HIGH);
  else
   digitalWrite(LED_PIN, LOW);
  
  if (millis() %1000 <300) {
    digitalWrite(HEATER_0_PIN, HIGH);
    digitalWrite(HEATER_1_PIN, LOW);
    digitalWrite(FAN_PIN, LOW);
  } else if (millis() %1000 <600) {
    digitalWrite(HEATER_0_PIN, LOW);
    digitalWrite(HEATER_1_PIN, HIGH);
    digitalWrite(FAN_PIN, LOW);
  } else  {
    digitalWrite(HEATER_0_PIN, LOW);
    digitalWrite(HEATER_1_PIN, LOW);
    digitalWrite(FAN_PIN, HIGH);
  }
  
  if (millis() %10000 <5000) {
    digitalWrite(X_DIR_PIN    , HIGH);
    digitalWrite(Y_DIR_PIN    , HIGH);
    digitalWrite(Z_DIR_PIN    , HIGH);
    digitalWrite(E_DIR_PIN    , HIGH);
    digitalWrite(Q_DIR_PIN    , HIGH);
  }
  else {
    digitalWrite(X_DIR_PIN    , LOW);
    digitalWrite(Y_DIR_PIN    , LOW);
    digitalWrite(Z_DIR_PIN    , LOW);
    digitalWrite(E_DIR_PIN    , LOW);
    digitalWrite(Q_DIR_PIN    , LOW);
  }
  
  
    digitalWrite(X_STEP_PIN    , HIGH);
    digitalWrite(Y_STEP_PIN    , HIGH);
    digitalWrite(Z_STEP_PIN    , HIGH);
    digitalWrite(E_STEP_PIN    , HIGH);
    digitalWrite(Q_STEP_PIN    , HIGH); 
  delay(1);
    
    digitalWrite(X_STEP_PIN    , LOW);
    digitalWrite(Y_STEP_PIN    , LOW);
    digitalWrite(Z_STEP_PIN    , LOW);
    digitalWrite(E_STEP_PIN    , LOW);
    digitalWrite(Q_STEP_PIN    , LOW); 
  */
}
