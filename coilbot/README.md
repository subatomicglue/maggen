# maggen:coilbot - magnetic coil winding robot

<img alt='coilbot' title='coilbot' src="pics/coilbot8.jpg" width='200px'>

The goal is to have a stepper motor wind our magnetic coils for us, by counting the turns, smoothly accelerating / decelerating.  Gaurentee consistent number of turns in our magnetic coils.  Avoid tedium.


[Read about the maggen Designer for axial flux generator cells](https://github.com/subatomicglue/maggen/tree/master/)

## CAD Files:
 - 1x Lasercut [Box](coilbotBox-3.15mm-sheet.svg) for 3.15mm sheet (wood or acrylic)
 - 1x 3D Printed [shaft coupler](shaft-coupler-squareToD.scad)  (unfinished - in progress)
 - 6x 3D Printed [M3 standoffs (8mm tall)](3mm-standoff-8mm-2.7ID.stl)
 - 4x 3D Printed [M3 spacers (5mm tall)](3mm-standoff-5mm-3.1ID.stl)

## Hardware List:
 - 1x  ABEC skatebearing <img alt='coilbot' title='coilbot' src="pics/bearingABEC.jpg" width='60px'>
 - 10x M3 sockethead screws (10mm long) - for stepper mount & boxtop <img alt='coilbot' title='coilbot' src="pics/M3sockethead.png" width='60px'>
 - 4x  M3 sockethead screws (18mm long) - for display mount <img alt='coilbot' title='coilbot' src="pics/M3sockethead.png" width='60px'>
 - 12x M3 flathead screws (10mm long) - for arduino mount <img alt='coilbot' title='coilbot' src="pics/M3flathead.png" width='60px'>
 - 6x  M3 standoffs (8mm tall) - for arduino mount <img alt='coilbot' title='coilbot' src="pics/M3standoff8mm.jpg" width='60px'>
 - 4x  M3 spacers   (5mm tall) - for display mount <img alt='coilbot' title='coilbot' src="pics/M3spacer5mm.jpg" width='60px'>
 - 12x20in  1/8in (3.15mm) [acrylic sheet (Glowforge)](https://shop.glowforge.com/products/medium-orange-acrylic-cast-opaque-glossy?taxon_id=13) <img alt='coilbot' title='coilbot' src="pics/OrangeAcrylic.jpg" width='60px'>
 - 1/4" (6.3mm) square rod (10" long) - spinning axle for coil winding <img alt='coilbot' title='coilbot' src="pics/squareRod.jpg" width='60px'>

## Electronics:
 - [OSOYOO 3D Printer Kit](https://www.amazon.com/gp/product/B0111ZSS2O/ref=oh_aui_detailpage_o01_s00?ie=UTF8&psc=1)
   - 1x RAMPS 1.4 Controller
   - 1x Arduino Mega 2560 board
   - 1x A4988 Stepper Motor Drivers
   - 1x LCD 12864 (RepRapDiscount Full Graphic Smart Controller Display)
 - [1x NEMA17 stepper motor (Bipolar 40mm 64oz.in(45Ncm) 2A 4 Lead)](https://www.amazon.com/gp/product/B00PNEQI7W/ref=oh_aui_search_detailpage?ie=UTF8&psc=1)
 - 1x [black rocker panelmount powerswitch KCD1-11 (8 x 12.8mm hole)](https://www.aliexpress.com/item/10pcs-G130-10-15mm-SPST-2PIN-ON-OFF-Boat-Rocker-Switch-3A-250V-Car-Dash-Dashboard/32739231057.html?spm=a2g0s.9042311.0.0.27424c4d8Zu7Se) <img alt='coilbot' title='coilbot' src="pics/switch-kcd1-11.jpg" width='60px'>
 - 1x [5.7mm outer 2.5mm inner panelmount "barrel shaped" DC power-inlet](https://www.mouser.com/ProductDetail/CUI/PJ-005B?qs=sGAEpiMZZMtnOp%252bbbqA009lE0K0K%252bPZGHDa8R3T3fghCv9kHIJIT1g%3d%3d) (7.8mm hole) <img alt='coilbot' title='coilbot' src="pics/powerinlet.jpg" width='60px'>
 - USB cable (type B to type A)
 - 12V DC power supply with barrel connector (2.5mm inner, 5.7mm outer)

## Firmware:

[Read about the maggen:coilbot customizations to Marlin](https://github.com/subatomicglue/maggen/tree/master/coilbot_MarlinDriver/customizations)

# Build!

Lasercut out of 20x12" acrylic

<img alt='coilbot' title='coilbot' src="pics/coilbot1.jpg" width='200px'>

Loose pieces

<img alt='coilbot' title='coilbot' src="pics/coilbot2.jpg" width='200px'>

Display

<img alt='coilbot' title='coilbot' src="pics/coilbot3.jpg" width='200px'>

Glueing (welding) with Acetone/Acrylic solution

<img alt='coilbot' title='coilbot' src="pics/coilbot4.jpg" width='200px'><img alt='coilbot' title='coilbot' src="pics/coilbot5.jpg" width='200px'>

Standoffs and Spacers printed

<img alt='coilbot' title='coilbot' src="pics/coilbot60.jpg" width='200px'>

Arduino / RAMPS / LCD boards mounted, power wired

<img alt='coilbot' title='coilbot' src="pics/coilbot6.jpg" width='200px'><img alt='coilbot' title='coilbot' src="pics/coilbot7.jpg" width='200px'>

Power on / Test fire

<img alt='coilbot' title='coilbot' src="pics/coilbot8.jpg" width='200px'><img alt='coilbot' title='coilbot' src="pics/coilbot9.jpg" width='200px'><img alt='coilbot' title='coilbot' src="pics/coilbot10.jpg" width='200px'>

