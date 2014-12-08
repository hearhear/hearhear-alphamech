/* Box for Hear Hear TRANSMITTER
	by Liam Marshall for Capacitor.IO/HearHear
	for G. Carle
	Thanks to John Whittington (tuna-f1sh) and teppic.
	ALL DIMENSIONS IN MILLIMETERS UNLESS OTHERWISE SPECIFIED.
*/

/* ////////// */
/* Parameters */
/* ////////// */

/* PCB size */
pcb_length = 48.9037; /* ENTER THIS */
pcb_width = 38.4048; /* ENTER THIS */
pcb_thickness = 1.6;

/* Clearances */
pcb_assembly_bottom_clearance = 2.5; /* ENTER THIS */

/* Port locations */
audio_jack_plug_center_height = 0; /* ENTER THIS */ /* Measured from bottom of board */
audio_jack_plug_center_dist = 0; /* ENTER THIS */
audio_jack_vmidpoint = 0; /* ENTER THIS */ /* Measured from lower edge of board */

USB_jack_dimensions = [12.34, 10.94]; /* [width, height] */
USB_jack_bottom_height = pcb_thickness + 0.25; /* Measured from bottom of board */ /* Thickness + solderblobbing */
USB_jack_clearance = 1; /* on all sides */

/* Fine-tuning of look and assembly */
baseTabs = 10;
sideTabs = 7;

/* Material and Cutter Parameters */
materialThickness = 3.175; /* 1/8 in acrylic */
laserBeamKerf = 0.2; /* ENTER THIS */ /* Need to find this out */
dxfSpacing = 2; /* Distance between parts */

/* Export settings */
export = false; /* Make this true to create DXFs */


/* //////////// */
/* Calculations */
/* //////////// */
epsilon = 0.001; /* This is for preventing Z-fighting */

height = pcb_thickness + pcb_assembly_bottom_clearance + (USB_jack_dimensions[1] + USB_jack_clearance) + (2*materialThickness) + (2*2);
length = pcb_length + (2*materialThickness) + (2*2); 
width = pcb_width + (2*materialThickness) + (2*2);

tabLength = (length / baseTabs);
tabSpacing = tabLength;

/* ///////// */
/* Do stuff! */
/* ///////// */

if (export) {
	echo("Not implemented yet");
} else {
	base();
}

module base() {
	difference() {
		cube([length, width, materialThickness]);
		for (x = [tabLength:tabSpacing+tabLength:length-tabSpacing]) {
			translate([x, materialThickness/2-laserBeamKerf/2,materialThickness/2]) tabSlot(1); /* One row of slots the long way */
			translate([x, width - materialThickness/2+laserBeamKerf/2,materialThickness/2]) tabSlot(1); /* Second row of slots the long way */
		}
	}
}

module tabSlot(direction) {
	if (direction == 1) {
		cube([tabLength - laserBeamKerf, materialThickness - laserBeamKerf/2, materialThickness*2], center=true);
	}
}
