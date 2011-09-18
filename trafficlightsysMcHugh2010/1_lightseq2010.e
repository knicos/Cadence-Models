%eden

## this overcomes a problem in the EDEN input window whereby "_" symbols are invisible.
 
tcl("font configure edencode -size 15");


/*	EDEN DEFINITIONS FOR TRAFFIC LIGHT OPERATION	*/
/*##################################################################################*/
/*##################################################################################*/
/*##################################################################################*/
/*##################################################################################*/

/* Traffic Simulation -- Intermediate traffic light system . Light periods set by
		 pre-determined/estimated values*/
		 
TRUE=1; FALSE=0;

state1=4;state2=4;state3=4; /* all three lights start red */
p1=3;p2=3;p3=3; /* the previous state of each traffic light */
gticks1=0;gticks2=0;gticks3=0;    /* green tick counter */
oticks1=0;oticks2=0;oticks3=0;    /* orange tick counter */
gtime1=160;gtime2=160;gtime3=120;    /* ms to stay green */
otime1=30;otime2=30;otime3=30;	/*ms to stay orange */

iclock=0; /* clock ticks */
turn = 0; /* which light is next to go green */

start = 0; /* Start/Stop watch variable, later linked to DOSTE interface in DOSTE section of code */

/* procedure starts a resumes the traffic light sequence by starting or pausing the associated eden clock */
proc pauseResume:start {
	if (start == 1) {
##		execute("%dasm\n?@display carleft1 x;");
		writeln("Resuming Traffic Light Sequence");
		setedenclock(&iclock,100);
	} else {
		writeln("Pausing Traffic Light Sequence");
		setedenclock(&iclock,@);
	}
}

/*Traffic light code:

If all lights are red and its my turn to go, then turn orange
Else if orange and time is up
	if was red, then go green, else go red
Else if green and time is up go orange

*/

/*For light 1, top left*/
proc Tlight1:iclock {
   if (state1==4){
      if (state2==4 && state3==4 && turn==0){
         writeln("Light 1 turning orange from red");
         state1=3;
         p1=4;
      }
   } else if (state1 == 3) {
   	oticks1++;
   	if (oticks1 > otime1) {
	   	if (p1 == 2) {
	   		writeln("Light 1 turning red from orange");
	   		state1 = 4;
	   		turn=1;
	   	} else {
	   		writeln("Light 1 turning green from orange");
	   		state1 = 2;
	   	}
	   	oticks1 = 0;
   	}
   } else{
      gticks1++;
      /*writeln(gticks1,"  ",gtime1);*/
      if (gticks1>gtime1){
      	writeln("Light 1 turning orange from green");
         state1=3;
         p1 = 2;
         gticks1 = 0;
      }
   }
}

/*For light 2, top right*/
proc Tlight2:iclock {
   if (state2==4){
      if (state1==4 && state3==4 && turn==1){
      	writeln("Light 2 turning orange from red");
         state2=3;
         p2 = 4;
      }
   } else if (state2 == 3) {
   	oticks2++;
   	if (oticks2 > otime2) {
   		gticks2=0;
	   	if (p2 == 2) {
	   		writeln("Light 2 turning red from orange");
	   		state2 = 4;
	   		turn=2;
	   	} else {
	   		writeln("Light 2 turning green from orange");
	   		state2 = 2;
	   	}
         	oticks2=0;
   	}
   } else {
      gticks2++;
      if (gticks2>gtime2){
      	writeln("Light 2 turning orange from green");
         state2=3;
         p2 = 2;
         gticks2 = 0;
      }
   }
}

/*For light 3, bottom left*/
proc Tlight3:iclock {
   if (state3==4){
      if (state1==4 && state2==4 && turn==2){
      writeln("Light 3 turning orange from red");
         state3=3;
         p3 = 4;
      }
   } else if (state3 == 3) {
   	oticks3++;
   	if (oticks3 > otime3) {
   		gticks3 = 0;
	   	if (p3 == 2) {
	   		writeln("Light 3 turning red from orange");
	   		state3 = 4;
	   		turn=0;
	   	} else {
	   		writeln("Light 3 turning green from orange");
	   		state3 = 2;
	   	}
	   	oticks3=0;
   	}
   } else{
      gticks3++;
      if (gticks3>gtime3){
      	writeln("Light 3 turning orange from green");
         state3=3;
         p3 = 2;
         gticks3 = 0;
      }
   }
}

