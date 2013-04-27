// building Lego bricks
// measurements taken from: http://www.robertcailliau.eu/Lego/Dimensions/zMeasurements-en.xhtml
// all copyrights and designs are property of their respective owners.

h_pitch = 8.0;
v_pitch = 9.6;
tol = 0.1;       // "play" in x and y directions
k_dia = 4.8;     // knob diameter
k_height = 1.8;  // knob height
wall = 1.2;      // wall thickness

brick_cyl_ex = 8*sqrt(2)-2*2.4;
brick_cyl_in = 4.8;
beam_cyl = 3.0;

module knob() {
  cylinder(h = k_height, r = k_dia/2);
}

module brick_cylinder() {
  difference() {
    cylinder(h=v_pitch, r=brick_cyl_ex/2);
    cylinder(h=v_pitch, r=brick_cyl_in/2);
  }
}

module beam_cylinder() {
  cylinder(h=v_pitch, r=beam_cyl/2);
}

module walls(w, d) {
  cube([wall, d, v_pitch]);    // left
  cube([w, wall, v_pitch]);    // front
  translate([w - wall, 0, 0])  // right
  cube([wall, d, v_pitch]);
  translate([0, d - wall, 0])  // rear
  cube([w, wall, v_pitch]);
  translate([0, 0, v_pitch - wall])  // top
  cube([w, d, wall]);
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

module beam(k) {
  width = k*h_pitch - 2*tol;
  depth = h_pitch - 2*tol;

  translate([tol, tol, 0])
  walls(width, depth);

  for (i = [1:k]) {
    translate([tol+((2*i-1)*h_pitch/2), tol+(h_pitch/2), v_pitch])
    knob();
  }

  if (k > 1) {
    for (i = [1:k-1]) {
      translate([tol+h_pitch*i, tol+depth/2, 0])
      beam_cylinder();
    }
  }
}

brick(2);

translate([0, 0, -20])
beam(5);