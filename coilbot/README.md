# maggen:coilbot - magnetic coil winding robot

The goal is to have a stepper motor wind our magnetic coils for us, by counting the turns, smoothly accelerating / decelerating.  Our customizations to Marlin accomplishes this by making Axis E controlable with `G0 E<rev>` gcode, where `rev` is number of revolutions to rotate.


[Read about the maggen Designer for axial flux generator cells](https://github.com/subatomicglue/maggen/tree/master/)

## CAD Files:
 - 1x [Lasercut Box](coilbotBox-3.15mm-sheet.svg) for 3.15mm sheet (wood or acrylic)
 - 1x [shaft coupler](shaft-coupler-squareToD.scad)  (unfinished - in progress)
 - 6x 8mm [standoff](3mm-standoff-8mm-2.7ID.stl)
 - 4x 5mm [spacer](3mm-standoff-5mm-3.1ID.stl)

## Hardware List:
 - 1x  ABEC skatebearing
 - 10x M3 sockethead screws (10mm long) - for stepper & boxtop
 - 4x  M3 sockethead screws (18mm long) - for display
 - 6x  M3 standoffs (8mm tall) - for arduino mount
 - 4x  M3 spacers   (5mm tall) - for display screws
 - 12x20in  1/8in (3.15mm) [acrylic sheet (Glowforge)](https://shop.glowforge.com/products/medium-orange-acrylic-cast-opaque-glossy?taxon_id=13)

## Electronics:
 - [OSOYOO 3D Printer Kit](https://www.amazon.com/gp/product/B0111ZSS2O/ref=oh_aui_detailpage_o01_s00?ie=UTF8&psc=1)
   - 1x RAMPS 1.4 Controller
   - 1x Arduino Mega 2560 board
   - 1x A4988 Stepper Motor Drivers
   - 1x LCD 12864 (RepRapDiscount Full Graphic Smart Controller Display)
 - [1x NEMA17 stepper motor (Bipolar 40mm 64oz.in(45Ncm) 2A 4 Lead)](https://www.amazon.com/gp/product/B00PNEQI7W/ref=oh_aui_search_detailpage?ie=UTF8&psc=1)
 - 1x black rocker panelmount powerswitch (8 x 12.8mm hole)
 - 1x [5.7mm outer 2.5mm inner panelmount "barrel shaped" DC power-inlet](https://www.mouser.com/ProductDetail/CUI/PJ-005B?qs=sGAEpiMZZMtnOp%252bbbqA009lE0K0K%252bPZGHDa8R3T3fghCv9kHIJIT1g%3d%3d)
 - USB cable
 - 12V power supply with barrel connector (2.5mm inner, 5.7mm outer)

## Firmware:

[Read about the maggen:coilbot customizations to Marlin](https://github.com/subatomicglue/maggen/tree/master/coilbot_MarlinDriver/customizations)

