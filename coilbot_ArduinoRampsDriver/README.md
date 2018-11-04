
# maggen::coilbot - Arduino/RAMPS14 driver

Driver for [maggen::coilbot](../coilbot).

(work in progress)

# Uploading to your coilbot:

- Install Arduino software
   - Install [Arduino IDE](https://www.arduino.cc/en/Main/Software)
   - Install these Arduino Libraries (under Arduino / Sketch / IncludeLibrary / ManageLibraries)
      - `u8g2` by oliver v2.24.3
      - `Encoder` by Paul Stroffregen v1.4.1

- Configure Arduino IDE
   - **Choose Board** (under Arduino / Tools / Board / **Arduino Mega 2560**)
   - **Choose Processor** (under Arduino / Tools / Processor / **ATMega2560**)
   - **Choose USBport** (under Arduino / Tools / Port **/dev/usbmodemXXXX**)
   - **Get Board Info** should return some info about your Arduino
      - If still not working, please see [Getting Started](https://www.arduino.cc/en/Guide/HomePage)

- Upload the code to your Arduino
   - **Load** the coilbot sketch (under Arduino / File / Open / `coilbot_ArduinoRampsDriver.ino`)
   - **Verify** (under Arduino / Sketch / Verify/Compile)
   - **Upload** (under Arduino / Sketch / Upload)

