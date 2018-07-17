# maggen - build notes

Use [maggen](..) to design your own axial flux generator.

## Parts list
The parts to a maggen generator are as follows:

### Simplest Cell Structure
The simplest cell you can create is a rotor spinning against a stator:

- *Rotor* (spinning disc with magnets)
- *Stator* (stationary disc with wire coils)

This has some issues with curved fields that make this configuration not optimal.

### More Efficient Cell Structure:
So to do it efficiently & maximize output, we need to straighten out the magnetic fields (flux) across the stator coils.  Normally flux curves around a magnet "in the shape of an apple".  We can ensure the flux runs straight (uncurved) through the stator by putting magnetically mating (attracting N to S) rotors on both sides of the stator:

- Rotor #1 (spinning disc with magnets)
- Stator   (stationary disc with wire coils)
- Rotor #2 (spinning disc with magnets)

There is still an issue with curved fields on the backs of the rotors. That same apple-shaped flux is looping there too.

### More Efficient Rotors With Terminators:
So we can route away this wild curvy flux on the rotor back, which keeps it from disturbing the productive (straight) end of the rotor's flux field.  This furthers maximizes power output.  We can conduct the flux simply to the neighbor magnet (since we alternate NSNSNS magnets around the disc).  Iron conducts flux well, if thick enough.  Giving us a cell design that looks like this:

- Rotor #1 w/ terminator (spinning disc with magnets w/ IronDisc backing)
- Stator (stationary disc with magnets)
- Rotor #2 w/ terminator (spinning disc with magnets w/ IronDisc backing)

We'll call this Iron a "terminator", since it sort of "ends" the unconnected flux eminating from the rotor backs.

### Scaling it up
Of course, we can then mass produce these amazing cells, and stack them together to get even more power output:

- Rotor Terminator
- Stator
- Rotor
- Stator
- Rotor
- Stator
- Rotor Terminator

As you can see, we only need the expensive iron for the ends, to 'terminate them'.  You can also choose to skip terminators, if you can't find or afford the Iron.

### A Note about Magnetic Cores
*TLDR;* you shouldn't need to add cores to an Axial Flux Generator if you use mating rotors as shown above.

The use of a [magnetic core](https://en.wikipedia.org/wiki/Magnetic_core) can increase the strength of magnetic field in an electromagnetic coil by a factor of several hundred times what it would be without the core. However, magnetic cores have side effects which must be taken into account. In alternating current (AC) devices they cause energy losses, called [core losses](https://en.wikipedia.org/wiki/Magnetic_core#Core_loss), due to hysteresis and eddy currents in applications such as transformers and inductors.

The high permeability of a core, relative to the surrounding air, causes the magnetic field lines to be concentrated in the core material.

A good material for cores is [Grain Oriented Electrical Steel (GOES)](https://en.wikipedia.org/wiki/Electrical_steel) which has very low [core loss](https://en.wikipedia.org/wiki/Magnetic_core#Core_loss), which minimizes Hysteresis/Eddy/Anomalous losses and has high permeability.

The cores increase the flux because with no core, very few of the apple-shaped field lines cut through the conductors, since the strongest field lines loop around the magnet itself. the cores guide the field lines so that more of them can affect the conductors.

In an axial flux generator with mating rotors (magnetic N/S poles on either side of coil), a core is not needed, since the flux is already guided / concentrated exactly between the two magnets.


### Complete Generator Structure

- Cells (a Stack of Rotors & Stators) [..](use maggen designer)
- Axle
- Axle Bearings
- Disk Shaft Mounting Collars (mount Rotor to Axle)
- Case  (to hold the stators, protect fingers / hair, etc...)


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
