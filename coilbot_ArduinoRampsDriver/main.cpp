#include <stdio.h>
#include <stdint.h>
#include <assert.h>
#include "MotorAnimator.h"


void testInterp() {
  printf( "------25.0f, 75.0f------\n" );
  for (float i = -1.0f; i <= 1.5; i += 0.5) {
    printf( "i:%f => %f\n", i, interp( i, 25.0f, 75.0f ) );
  }
  printf( "------75.0f, 25.0f------\n" );
  for (float i = -1.0f; i <= 1.5; i += 0.5) {
    printf( "i:%f => %f\n", i, interp( i, 75.0f, 25.0f ) );
  }
  printf( "------ -75.0f, -25.0f-------\n" );
  for (float i = -1.0f; i <= 1.5; i += 0.5) {
    printf( "i:%f => %f\n", i, interp( i, -75.0f, -25.0f ) );
  }
  printf( "------ -25.0f, -75.0f-------\n" );
  for (float i = -1.0f; i <= 1.5; i += 0.5) {
    printf( "i:%f => %f\n", i, interp( i, -25.0f, -75.0f ) );
  }
  printf( "------1.0f, -1.0f-------\n" );
  for (float i = -1.0f; i <= 1.5; i += 0.5) {
    printf( "i:%f => %f\n", i, interp( i, 1.0f, -1.0f ) );
  }
  printf( "-----0, -25.0f-------\n" );
  for (float i = -1.0f; i <= 1.5; i += 0.5) {
    printf( "i:%f => %f\n", i, interp( i, 0, -25.0f ) );
  }
  printf( "---- 0, 0--------\n" );
  for (float i = -1.0f; i <= 1.5; i += 0.5) {
    printf( "i:%f => %f\n", i, interp( i, 0, 0 ) );
  }

  printf( "---- -1.0f, 1.5f, 25, 75 --------\n" );
  for (float i = -1.0f; i <= 1.5; i += 0.5) {
    printf( "i:%f => %f\n", i, interp( i, -1.0f, 1.5f, 25, 75 ) );
  }
  printf( "---- -40, 400, 25, -75 --------\n" );
  for (float i = -40.0f; i <= 400.0f; i += 440/5) {
    printf( "i:%f => %f\n", i, interp( i, -40, 400, 25, -75 ) );
  }
}

/*
void testMotorSituation() {
  const uint32_t STEPS_PER_REV = 200;
  const uint32_t MICROSTEPPING = 16;
  const uint32_t HI_SPEED = 40;
  const uint32_t LO_SPEED = 800;
  const uint32_t ACCEL_TIME = 4000000;

  uint32_t turns = 20;
  uint32_t steps_needed = turns * STEPS_PER_REV * MICROSTEPPING;

  // linearly ramp velocity (accelerate from s0-s1, then decelerate from s2-s3)
  // interpolate from lo to hi speed as a function of time
  //   ______________
  //  /              \
  //s0 s1          s2 s3
  uint32_t t0 = 0;
  uint32_t t1 = ACCEL_TIME;
  uint32_t s0 = 0;
  uint32_t s1 = calcS1( t0, t1, LO_SPEED, HI_SPEED );
  uint32_t s2 = steps_needed - s1;
  uint32_t s3 = steps_needed;
  uint32_t t2 = t1 + (s2-s1) * HI_SPEED;
  uint32_t t3 = t2 + t1;

  // if we dont have enough runway to get up to speed, the step stages will be off.
  // correct s1 & s2 for this now, and then later (on the fly) we'll correct t1 & t2 & t3 at the midpoint of steps elapsed
  bool needs_adjusting_midflight = false;
  if (s3 < s1 || s2 < s1 || s3 < s2) {
    s1 = s2 = s3/2;
    needs_adjusting_midflight = true;
  }

  uint32_t steps = 0;
  float time_elapsed = 0;
  float speed = LO_SPEED;
  uint32_t lo = LO_SPEED;
  uint32_t hi = HI_SPEED;

  for (steps = 0; steps <= steps_needed; ++steps) {
    if (t0 <= time_elapsed && time_elapsed < t1)
      speed = interp( time_elapsed, t0, t1, lo, hi );
    else if (t1 <= time_elapsed && time_elapsed < t2)
      speed = interp( time_elapsed, t1, t2, hi, hi );
    else if (t2 <= time_elapsed && time_elapsed < t3)
      speed = interp( time_elapsed, t2, t3, hi, lo );

    // step the stepper here...

    // debug:
    if (steps % 100 == 0)
      printf( "%d, %f, %f\n", steps, time_elapsed, speed );

    // if the span was too small (s1 == s2), and we had to adjust
    // end it early when we pass step s1
    if (needs_adjusting_midflight && s1 < steps) {
      t1 = t2 = time_elapsed;
      t3 = time_elapsed * 2.0f;
      hi = speed;
      needs_adjusting_midflight = false;
    }

    time_elapsed += speed;
  }

  printf( "STEPS_PER_REV:%d\n", STEPS_PER_REV );
  printf( "MICROSTEPPING:%d\n", MICROSTEPPING );
  printf( "HI_SPEED:%d\n", HI_SPEED );
  printf( "LO_SPEED:%d\n", LO_SPEED );
  printf( "ACCEL_TIME:%d\n", ACCEL_TIME );
  printf( "turns:%d\n", turns );
  printf( "steps_needed:%d\n", steps_needed );
  printf( "s0:%d s1:%d s2:%d s3:%d\n", s0, s1, s2, s3 );
  printf( "t0:%d t1:%d t2:%d t3:%d\n", t0, t1, t2, t3 );
}
*/

void testMotorClass() {
  const uint32_t STEPS_PER_REV = 200;
  const uint32_t MICROSTEPPING = 16;
  const uint32_t HI_DELAY = 40;
  const uint32_t LO_DELAY = 800;
  const uint32_t ACCEL_TIME = 4000000;

  MotorAnimator ma;
  ma.init( STEPS_PER_REV, MICROSTEPPING, HI_DELAY, LO_DELAY, ACCEL_TIME );
  ma.start( 20 );
  while (ma.isRunning()) {
    // debug:
    if (ma.steps % 100 == 0)
      printf( "delay( %d )\n", ma.getDelay() );
    //printf( "%d, %f, %f\n", ma.steps, ma.getDelay(), ma.time_elapsed );

    ma.next();
  }
}

void testClamp() {
  float bok = clamp( 9297875.000000f, 5298720.000000, 9298720.000000 );
  printf( "%f\n", bok );
}

void testRound() {
  float bok = round( 799.99912f );
  printf( "%f\n", bok );
}

int main() {
  //testInterp();
  //testClamp();
  //testRound();

  testMotorClass();
}

