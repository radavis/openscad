// building Lego bricks
// measurements taken from: 
//   http://www.robertcailliau.eu/Lego/Dimensions/zMeasurements-en.xhtml
// all copyrights and designs are property of their respective owners.

h_pitch = 8.0;
v_pitch = 9.6;
tol = 0.1;       // "play" in x and y directions
k_dia = 4.8;     // knob diameter
k_height = 1.8;  // knob height
wall = 1.2;      // wall thickness

brick_cyl_ex = 8*sqrt(2)-2*2.4;
brick_cyl_in = 4.8;

module knob() {
  cylinder(h = k_height, r = k_dia/2);
}

module brick_cylinder() {
  difference() {
    cylinder(h=v_pitch, r=brick_cyl_ex/2);
    cylinder(h=v_pitch, r=brick_cyl_in/2);
  }
}

module walls(w, d) {
  difference() {
    cube([w, d, v_pitch]);
    translate([wall, wall, 0])
    cube([w-2*wall, d-2*wall, v_pitch-wall]);
  }
}

module brick(k) {
  // builds a Lego brick based on the number of knobs
  width = k*h_pitch - 2*tol;
  depth = 2*h_pitch - 2*tol;
  
  // build walls
  translate([tol, tol, 0])
  walls(width, depth);

  // place knobs
  for (i = [1:2]) {
    for (j = [1:k]) {
      translate([tol+((2*j-1)*h_pitch/2), tol+((2*i-1)*h_pitch/2), v_pitch])
      knob();
    }  
  }

  // internal cylinders
  if (k > 1) {
    for (i = [1:k-1]) {
      translate([tol+h_pitch*i, tol+depth/2, 0])
      brick_cylinder();
    }
  }
}

brick(4);