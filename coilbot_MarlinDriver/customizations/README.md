
# Customizations to Marlin:

## Enable LCD display (RepRapDiscount Full Graphic Smart Controller)
We used this 12864 "RepRapDiscount Full Graphic Smart Controller":

`Configuration.h`
```
#define REPRAP_DISCOUNT_FULL_GRAPHIC_SMART_CONTROLLER
```
Install u8glib into Arduino/Library:
```
$ ./install_u8glib.sh
```
Then Recompile

## Install Custom Bootscreen:
```
#define SHOW_CUSTOM_BOOTSCREEN
/// COILBOT:   128x64 1-bit bmp image.
/// Use LCDAssistant.exe (Horizontal orientation, 128 width, 64 height, Little Endian, 8 px/byte), to convert to _Background.h file.
/// wrap with:
/// #include <avr/pgmspace.h>
///
/// #define CUSTOM_BOOTSCREEN_TIMEOUT   2500
/// #define CUSTOM_BOOTSCREEN_BMPWIDTH  128
/// #define CUSTOM_BOOTSCREEN_BMPHEIGHT 64
///
/// const unsigned char custom_start_bmp[1024] PROGMEM = {
```
```
$ cp _Bootscreen.h ../Marlin
```
Then Recompile

You can find `LCDAssistant.exe` [here](http://en.radzio.dxp.pl/bitmap_converter/)

## Customize the Machine name and UUID:
```
#define CUSTOM_MACHINE_NAME "maggen:coilbot"
```
Set MACHINE_UUID to unique UID from http://www.uuidgenerator.net/version4
```
#define MACHINE_UUID "00000000-0000-0000-0000-000000000000"
```

## disable temperature sensor for E axis
```
#define TEMP_SENSOR_0 998 // we dont need a tempsensor for coilbot`
//#define PREVENT_COLD_EXTRUSION  // not needed for coilbot
//#define PREVENT_LENGTHY_EXTRUDE // not needed for coilbot
```

## enable a better speaker
```
#define SPEAKER           // enable musical tones
```

## steps per unit
Let's define 1unit == 1revolution (full 360deg) of the stepper motor.
This way we can say `G0 E1 F60` to make the stepper rotate once around at a rate of 60/min (1/sec).
```
#define DEFAULT_AXIS_STEPS_PER_UNIT   { 3200, 3200, 3200, 3200 }
// coilbot: This is in steps/revolution
// NEMA 17 has 200 steps in a revolution (360deg / Step Angle: 1.8 deg)
// 200 with 1/16 microstepping == 200 * 16 = 3200 steps per revolution

#define DEFAULT_MAX_FEEDRATE          { 16.0, 16.0, 16.0, 16.0 } // coilbot 16 rotations per sec
#define DEFAULT_MAX_ACCELERATION      { 10000/360, 10000/360, 10000/360, 10000/360 }
#define DEFAULT_ACCELERATION          400/360.0    // X, Y, Z and E acceleration for printing moves
#define DEFAULT_RETRACT_ACCELERATION  400/360.0    // E acceleration for retracts
#define DEFAULT_TRAVEL_ACCELERATION   400/360.0    // X, Y, Z acceleration for travel (non printing) moves
#define DEFAULT_XJERK                 0.0 // always use acceleration
#define DEFAULT_YJERK                 0.0 // always use acceleration
#define DEFAULT_ZJERK                 0.0 // always use acceleration
#define DEFAULT_EJERK                 0.0 // always use acceleration
```

## Enable relative mode by default:
`Marlin_main.cpp`
```
// Relative Mode. Enable with G91, disable with G90.
static bool relative_mode = true; // coilbot: relative mode
```

## Add menu items to the LCD screen (near `lcd_main_menu`)
`ultralcd.cpp`
```
void coilbot_menu() {
   START_MENU();
   MENU_BACK(MSG_MAIN);
   MENU_ITEM(gcode, "Turn 1", PSTR("G0 E1 F60")); // coilbot
   MENU_ITEM(gcode, "Turn 5", PSTR("G0 E5 F120")); // coilbot
   MENU_ITEM(gcode, "Turn 20", PSTR("G0 E20 F480")); // coilbot
   MENU_ITEM(gcode, "Turn 50", PSTR("G0 E50 F600")); // coilbot
   MENU_ITEM(gcode, "Turn 100", PSTR("G0 E100 F6000")); // coilbot
   MENU_ITEM(gcode, "Turn 150", PSTR("G0 E150 F6000")); // coilbot
   MENU_ITEM(gcode, "Turn 200", PSTR("G0 E200 F6000")); // coilbot
   END_MENU();
}

void lcd_main_menu() {
   START_MENU();
   MENU_BACK(MSG_WATCH);

   MENU_ITEM(submenu, "Coilbot", coilbot_menu); // coilbot submenu
```

# Useful Gcode for using coilbot
For now, you use coilbot by connecting [Pronterface](http://www.pronterface.com/) and issuing Gcode Commands.
Relevant commands for spinning coils are listed here:

[Marlin GCode Reference](http://marlinfw.org/docs/gcode/G010.html)

Typical Use:
- `G0` Move
   - `G0 E1 F60`          (  1 turn  at 1 rev/sec  )
   - `G0 E20 F480`        ( 20 turns at 8 rev/sec  )
   - `G0 E500 F480`       (500 turns at 8 rev/sec  )
   - feedrate is in rev/min: 60rev/min == 1rev/sec.  Acceleration set by `M204 RXXX`

Advanced/Setup:
- `G21` MM units   (for coilbot mm = degrees. so 360mm == 360deg == 1rev)
- `G91` Relative Positioning
- `M92` Set Axis Steps-per-unit (`M92 E8.88889`)
   - NEMA17 with 1/16 microstepping:
      - 200step/rev * 16microsteps = 3200steps / 360deg = 8.8889 steps/deg
- `M201` Set Max Acceleration (`M201 E10000`)
- `M203` Set Max Feed Rate    (`M203 E2800`) (feedrate is in deg/sec: 8 * 360deg/sec = 8 rev/sec = 2800)
- `M204` Set Starting Accel   (`M204 P400 R400 T400`)
   - NOTE: 400 seems to be the lowest we can go, or you get weird non-smooth acceleration, abrupt velocity changes, etc.
      - (almost like somewhere in Marlin we're overflowing a 16 bit integer value and it wraps back around to 0)
- `M205` advanced settings `[B<µs>] [E<jerk>] [S<feedrate>] [T<feedrate>] [X<jerk>] [Y<jerk>] [Z<jerk>]`
  (disable with `M205 E0 X0 Y0 Z0`  and `M205 S0 T0`)
- `M31` Print time
- `M117` Set LCD Message (`M117 done`)
- `M300` Play a Tone  (`M300 S220 P200`)

Setup for 1 unit per revolution (optional, these should already be default in Marlin changes above):
```
G91
G21
M92 E3200
M201 E27.77777778
M203 E8
M204 P1.11 R1.11 T1.11
M205 E0 X0 Y0 Z0
M205 S0 T0
```

Spin me round!  (1 rev, at a rate of 60rev/min)
```
G0 E1 F60
```

Spin me round like a record baby round round right round!  (20 rev at a rate of 480rev/min)
```
G0 E20 F480
```


Play a tune:
```
M300 S440 P200
M300 S220 P200
M300 S880 P200
M300 S110 P200
```


## other units setup:

Setup for 360 units per revolution:
```
G91
G21
M92 E8.88889
M201 E10000
M203 E2800
M204 P400 R400 T400
M205 E0 X0 Y0 Z0
M205 S0 T0
```
Spin me round!  (1 rev, at a rate of 21600deg/min)
```
G0 E360 F21600
```

Spin me round like a record baby round round right round!  (20 rev, at a rate of 172800deg/min)
```
G0 E7200 F172800
```

# FUTURE WORK

 - Need to add a menu to Marlin that takes a number of turns, and executes `G0 Exxx` with that number...  That way we can skip pronterface completely, making this solution truely embedded in the hardware.
