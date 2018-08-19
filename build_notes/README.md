# maggen - build notes

Use [maggen](..) to design your own axial flux generator.

## Parts list
The parts to a maggen generator are as follows:

### Simplest Cell Structure
The simplest cell you can create is a rotor spinning against a stator:

- **Rotor** (spinning disc with magnets)
- **Stator** (stationary disc with wire coils)

<img alt="Example of a simple Cell" src="1.png" height="300"><img alt="Example of a simple Cell (3D)" src="1-3d.png" height="300">


This has some issues with curved fields that make this configuration not optimal.  Not all the flux lines eminating from the magnet will pass through the coils.  This can be optimized with cores inside the coils which concentrate the flux lines, or simply using a more efficient cell structure.

### More Efficient Cell Structure:
So to do it efficiently & maximize output, we need to straighten out the magnetic fields (flux) across the stator coils.  Normally flux curves around a magnet "in the shape of an apple".  We can ensure the flux runs straight (uncurved) through the stator by putting magnetically mating (attracting N to S) rotors on both sides of the stator:

- **Rotor #1** (spinning disc with magnets)
- **Stator**   (stationary disc with wire coils)
- **Rotor #2** (spinning disc with magnets)

<img alt="Example of a More Efficiently configured Cell - due to routing flux through Coils" src="2.png" height="300"><img alt="Example of a More Efficiently configured Cell - due to routing flux through Coils (3D)" src="2-3d.png" height="300">

There is still an issue with curved fields on the backs of the rotors. That same apple-shaped flux is looping there too, which still keeps some of the flux lines away from the coils.

### More Efficient Rotors With Terminators:
So we can route away this wild curvy flux on the rotor back, which keeps it from disturbing the productive (straight) end of the rotor's flux field.  This further maximizes power output by maximizing number of field lines passing through the coils.  We can conduct the flux simply to the neighbor magnet (since we alternate NSNSNS magnets around the disc).  Iron conducts flux well, if thick enough.  Giving us a cell design that looks like this:

- **Rotor #1 w/ Terminator** (adds an IronDisc backing)
- **Stator**
- **Rotor #2 w/ Terminator** (adds an IronDisc backing)

<img alt="Example of an Efficiently configured Cell - due to routing of magnetic flux through Iron and Coils" src="3.png" height="250"><img alt="Example of an Efficiently configured Cell - due to routing of magnetic flux through Iron and Coils (3D)" src="3-3d.png" height="250">

We'll call this Iron a "terminator", since it sort of "ends" the unconnected flux eminating from the rotor backs.  Now we have a closed "circuit" of flux: 1. magnet to magnet straight through the coils, 2. magnet to magnet on the terminating ends to the neighbor magnet.  This maximizes the field lines through the coils.

### Scaling it up
Of course, we can then mass produce these amazing cells, and stack them together to get even more power output:

- Rotor + Terminator
- Stator
- Rotor
- Stator
- Rotor
- Stator
- Rotor + Terminator

<img alt="How to scale up power out by Stacking Cells" src="4.png" height="250"><img alt="How to scale up power out by Stacking Cells (3D)" src="4-3d.png" height="250">

As you can see, we only need the expensive iron for the ends, to 'terminate them'.  You can also choose to skip terminators, if you can't find or afford the Iron.

### A Note about Magnetic Cores
*TLDR;* you shouldn't need to add cores to an Axial Flux Generator if you use mating rotors as shown above.

The use of a [magnetic core](https://en.wikipedia.org/wiki/Magnetic_core) can increase the strength of magnetic field in an electromagnetic coil by a factor of several hundred times what it would be without the core. However, magnetic cores have side effects which must be taken into account. In alternating current (AC) devices they cause energy losses, called [core losses](https://en.wikipedia.org/wiki/Magnetic_core#Core_loss), due to hysteresis and eddy currents in applications such as transformers and inductors.

The high permeability of a core, relative to the surrounding air, causes the magnetic field lines to be concentrated in the core material.

A good material for cores is [Grain Oriented Electrical Steel (GOES)](https://en.wikipedia.org/wiki/Electrical_steel) which has very low [core loss](https://en.wikipedia.org/wiki/Magnetic_core#Core_loss), which minimizes Hysteresis/Eddy/Anomalous losses and has high permeability.

The cores increase the flux because with no core, very few of the apple-shaped field lines cut through the conductors, since the strongest field lines loop around the magnet itself. the cores guide the field lines so that more of them can affect the conductors.

In an axial flux generator with mating rotors (magnetic N/S poles on either side of coil), a core is not needed, since the flux is already guided / concentrated exactly between the two magnets.

#### Eddy currents & loss:

The flux is not constant in an axial flux alternator.  When acting as a motor, the coils introduce AC magnetic fields and depend on EMF to move the rotor, when acting as a generator, the current induced in the windings, especially under load, generate back EMF.  Both EM fields interact with the permanent magnets and will cause magnetic fields to move in the iron cores causing eddy currents and losses.

### Complete Generator Structure

- Cells (a Stack of Rotors & Stators) [..](use maggen designer)
- Axle
- Axle Bearings
- Disk Shaft Mounting Collars (mount Rotor to Axle)
- Case  (to hold the stators, protect fingers / hair, etc...)

![3D Printed Shaft Mount Collar - Rotor Mount](rotormount.png)

### Tools

- Coilbot: Coil winding robot (counts # of turns)
  - Bobbins [..](design with maggen)
  - Case (CAD files TBD)
  - Electronics [../coilbot_MarlinDriver](coilbot firmware + Arduino/RAMPS)

- Stator Mold [..](design with maggen)


### notes for individual parts...
todo: organize this...
```
- Rotor (acrylic for interior rotors, acrylic + iron for end terminators)
   Magnet shapes (cut through acrylic for taping or as template for iron disc)
   Hole cut for axle
   Mounting holes for hub part
- Hub shape (3D printed)
   mounting holes
   set screw location, for center axis
   Axle hole
   Compress style with split
- Stator (epoxy mold, wood or acrylic, waxed to prevent sticking)
   - round bottom/top of mold with outer dia circle and coil outlines scored for positioning, and a center hole for bearing or axle passthrough
   - round 'keeper plates' for the bearing (mold with them in)
   - round middle wall plates (outer dia disc cut out of sheets)
   - central Hole mold insert
- Coil bobbin/winder
   Axle hole (square, to mate with square metal bar axle driven by stepper motor)
   Inner hub coil shaper
   Coil keeper plates, 1 attached, 1 removable
   Notches
   - for Wire lead catches
   - tape slots (for taping coil while on bobbin)
- Hub for coil winder
   Mounting holes
   Set screw location, for center axis
   Axle hole
   Compress style, with split
- Axle for winder robot
- Axle for generator
- Coilbot hardware
  See coilbot for designs and parts to order.
  - Arduino
  - ramps 1.4
  - lcd
  - power supply
  - stepper nema17
  - stepper drivers
  - marlin firmware (with coilbot customizations)
  - case/chassis (openscad or svg file)
```


## Design notes & anecdotes

- Magnet Size:  "...round magnets cancel most of the energy generated when sweeping across the shoulders of the coil. If rectangular magnets are used with a width less than the minimum hole width of the coil, the power generation can be optimized."  found in comments section here: https://www.youtube.com/watch?v=flHOGE7EcCU

- Iron Disc for Rotor: “the idea is to complete the magnetic circuit from pole to pole on the rotor, so low carbon steel is the best. With 1/2" thick neo magnets you'll want to use minimum 1/4" steel. With 3/4" neos use 3/8" steel to prevent saturation of the rotor. With all the magnets installed on the rotor a paperclip should not hang on the back side of the rotor. If it does the rotor is saturated and you got too much flux leakage thru the rotor.

- It is normal to get a paperclip to stick on the backside perimeter of an uncaged rotor due to flux leakage around the perimeter. However, when the generator is assembled, this perimeter leakage should be close to zero and the paperclip should not stick there.” from https://forum.solar-electric.com/discussion/18276/material-for-rotor-axial-flux

- Relationship between flux and wire:
   1. Basically you want to pass straight wires through a changing flux field.  We can do that with coils.  But round coils aren't ideal.  Trapezoidal will maximize the amount of straight wire.
   2. You want to make the flux as perpendicular as possible to the copper windings.  Following design choices follow:
   3. maximize radial 'spokes' for wire.  minimize copper length on the inside/outside diameter
   4. magnet on both sides of the coil ensures flux doesnt curve.
   5. what to do with curved flux 'behind' the end magnets? use iron core behind the end magnets to route the curved flux, redirecting to the back of 2 adjacent magnets.  keeps this 'end' curved flux from interfering with the field across the coil.

- serpentine configuration of wire can simplify wiring (less soldering, less errors)

