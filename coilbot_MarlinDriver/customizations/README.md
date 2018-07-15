
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
```
#define DEFAULT_AXIS_STEPS_PER_UNIT   { 3200/360, 3200/360, 3200/360, 3200/360 }
// coilbot: This is in steps/degree
// NEMA 17 has 200 steps in a revolution (360deg / Step Angle: 1.8 deg)
// 200 with 1/16 microstepping == 200 * 16 = 3200 steps per revolution

#define DEFAULT_MAX_FEEDRATE          { 360.0*16.0, 360.0*16.0, 360.0*16.0, 360.0*16.0 } // coilbot 16 rotations per sec
#define DEFAULT_MAX_ACCELERATION      { 10000, 10000, 10000, 10000 }
#define DEFAULT_ACCELERATION          400    // X, Y, Z and E acceleration for printing moves
#define DEFAULT_RETRACT_ACCELERATION  400    // E acceleration for retracts
#define DEFAULT_TRAVEL_ACCELERATION   400    // X, Y, Z acceleration for travel (non printing) moves
```

# Useful Gcode for using coilbot
For now, you use coilbot by connecting [Pronterface](http://www.pronterface.com/) and issuing Gcode Commands.
Relevant commands for spinning coils are listed here:

[Marlin GCode Reference](http://marlinfw.org/docs/gcode/G010.html)
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
- `G0` Move
   - `G0 E360 F21600`     (  1 turn  at 1 rev/sec ==   1 * 360, 1 * 21600)
   - `G0 E7200 F172800`   ( 20 turns at 8 rev/sec ==  20 * 360, 8 * 21600)
   - `G0 E180000 F172800` (500 turns at 8 rev/sec == 500 * 360, 8 * 21600)
   - feedrate is in deg/min: 360deg/min == 21600deg/sec.  Acceleration set by `M204 RXXX`
- `M31` Print time
- `M117` Set LCD Message (`M117` done)
- `M300` Play a Tone  (`M300 S220 P200`)

Setup:
```
G91
G21
M92 E8.88889
M201 E10000
M203 E2800
M204 P400 R400 T400
```

Spin me round!
```
G0 E360 F21600
```

Spin me round like a record baby round round right round!
```
G0 E7200 F172800
```

Play a tune:
```
M300 S440 P200
M300 S220 P200
M300 S880 P200
M300 S110 P200
```

