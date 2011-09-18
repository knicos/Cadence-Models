
The model in this directory was originally developed by James McHugh in January 2010 for WEB-EM-6.
Some small modifications have had to be made to enable the model to run on the current version of Cadence.

--------------------
How to run the model
--------------------

To run the model, you should first invoke the most up-to-date version of Cadence via

~empublic/bin/cadence

in the directory which contains this README file.

The model makes use of both the Warwick Games Library and the EDEN module: these must first be loaded via the Cadence IDE

%dasm

%include "wgd/wgd.dasm";
%include "eden/eden.dasm";

Note that the first of these inclusions refers to the local instance of wgd.dasm (i.e. the file within the wgd subdirectory in the directory that contains this README). For this wgd.dasm instance, the dimensions of the display window are width 1024, height 768. These dimensions must be pre-determined and cannot be subsequently modified on-the-fly. 

The files that need to be included for the traffic simulation, as revised, are

1_lightseq2010.e
2_displaycompts.dasm 
3_lightinstances.dasm
4_linkedendasm.e 
5_carspec.dasm

Can make these inclusions by cutting-and-pasting the following code segments into the interface as specified here.

1. Cut-and-paste the following two lines into the EDEN interface:

%eden
include("1_lightseq2010.e");

2. Cut-and-paste the following as DASM input into the Cadence-IDE:

%include "2_displaycompts.dasm";
%include "3_lightinstances.dasm";

3. Cut-and-paste the following two lines into the EDEN interface:

%eden
include("4_linkedendasm.e");

4. Cut-and-paste the following as DASM input into the Cadence-IDE:

%include "5_carspec.dasm";

------------------------------
Some key features of the model
------------------------------

The model will repay study as a guide as to how Cadence can be used to create animations. The following points may be of particular interest.

- The model of the lights sequence is in EDEN rather than Cadence. It makes use of "edenclocks" to determine the timing of the lights. Note how an EDEN oracle is used to commmunicate between the button in Cadence that starts and stops the lights. The EDEN and Cadence observables involved in this communication are 'start' and '@loptions btnStartStop toggle' respectively. EDEN handle observables are used to communicate the current states of the three lights, as determined by the observables state1, state2 and state3. (Note that the traffic lights use the "red & orange" sprite as intermediate between "green and "red" in turning from red to green and vice versa, which is not of course quite correct.)

- The button mechanism in Cadence that is used to start and stop the lights by setting the toggle observable makes interesting and effective use of 'is' and 'willbe' definitions of click and mousedown respectively that are inherited from the WGD library. (NB: These were not at first correctly defined when the WGD library was revised to accommodate 'is' as well as 'willbe' definitions.)

- The model illustrates effective use of the sprite concept in the WGD library, together with suitable .png images, for 2-d visualisation.

- There are a number of "Edit Box" panels in the model interface. These were intended to be used to set parameters (e.g.) to determine the length of time for which the individual lights are set to green and orange, but were not implemented as edit boxes have yet to be be prototyped in WGD. (As a result, the Cadence-IDE registers errors when the file "2_displaycompts.dasm" is included, but these can be safely ignored.) The "simple agent" action recently introduced into Cadence should simplify the implementation of such boxes considerably.

- The way in which the lights and the cars are modelled in Cadence illustrates effective use of cloning. Notice how a generic car provides the template for three different varieties of car which approach the road intersection from three directions: left, right and bottom. Several instances of cars of these three kinds are then specified.

- The model illustrates the rather eccentric syntax for arithmetic expressions and if-statements in DASM in the Cadence research prototype. Note carefully the way in which brackets are used in expressions (e.g. where they must be included - and omitted!), and remember to leave white space around all operators.

- Note that the speed at which the simulation runs is influenced by how many observables are being displayed in the Cadence-IDE browser. This is because of the overhead in keeping the browser up-to-date when many observables are displayed.

-----------------------
Significant observables
-----------------------

In the absence of Edit Boxes, you can use the Cadence-IDE browser to change observables in the model.

Traffic Light Properties are eden variables and can be accessed directly:
        gtimeX - Is the time to stay green in ms for traffic light 'X',
                 replace 'X' with the traffic light number (1-3), i.e. gtime1
        otimeX - same as above, but for orange duration

Car Properties are DOSTE definitions:
        @display car(direction)(X) - used to access car number "X" starting on the "direction" side.
                  i.e. carleft1 selects the first car coming from the left hand side of screen.
                mspeed is {}; - changes the maximum speed of a car (default is 0.15)
                acceleration is {}; - changes the acceleration of a car to a static value
                        (i.e. will no longer react to objects such as car ahead and traffic light state)
                ha is {}; - change the value used for a car when it is accelerating hard (default is 0.0002)
                la is {}; - change the value used for a car when it is accelerating lightly (default is 0.00006)
                hb is {}; - change the value used for a car when it is breaking hard (default is -0.0005)
                lb is {}; - change the value used for a car when it is breaking lightly (default is -0.0001)
                choice is {} - give a number between 0-1, will define direction car takes once arrives at junction

These are the main options to change, there are a lot more that can be altered: please refer to the code to locate these.

------------
Known issues
------------

Cars which turn at the intersection are not at first displayed on a restart: they appear only at the point on the intersection at which they turn. The process of restarting would be better handled by an agent, either using the simple agent mechanism recently introduced into Cadence, or using an EDEN action.

--------------------------------
More information about the model
--------------------------------

See James McHugh's WEB-EM-6 paper, bearing in mind that his account refers to model-building that was carried out using an earlier prototype for the Cadence environment in which 'is' was what is now 'willbe' and there was no counterpart of the current 'is'.






