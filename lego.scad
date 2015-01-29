// building Lego bricks - rdavis.bacs@gmail.com
// measurements taken from: 
//   http://www.robertcailliau.eu/Lego/Dimensions/zMeasurements-en.xhtml
// all copyrights and designs are property of their respective owners.

h_pitch = 8.0;   // horizontal unit
v_pitch = 9.6;   // vertical unit
tol = 0.1;       // "play" in x and y directions
k_dia = 4.8;     // knob diameter
k_height = 1.8;  // knob height
k_n = 40;         // knob resolution
wall = 1.2;      // wall thickness

brick_cyl_ex = 8*sqrt(2)-2*2.4;
brick_cyl_in = 4.8;
beam_cyl = 3.0;

module knob() {
  cylinder(h = k_height, r = k_dia/2, $fn=k_n);
}

module brick_cylinder(height=v_pitch) {
  difference() {
    cylinder(h=height, r=brick_cyl_ex/2);
    cylinder(h=height, r=brick_cyl_in/2+tol, $fn=k_n);
  }
}

module beam_cylinder(height=v_pitch) {
  cylinder(h=height, r=beam_cyl/2);
}

module walls(w, d, height=v_pitch) {
  difference() {
    cube([w, d, height]);
    translate([wall, wall, 0])
    cube([w-2*wall, d-2*wall, height-wall]);
  }
}

module build_brick(col, row, height) {
  // builds a Lego brick based on the number of knobs
  width = col*h_pitch - 2*tol;
  depth = row*h_pitch - 2*tol;
  
  // build walls
  walls(width, depth, height);

  // place knobs
  for (j = [1:row]) {
    for (i = [1:col]) {
      translate([(2*i-1)*h_pitch/2, (2*j-1)*h_pitch/2, height])
      knob();
    }
  }

  // internal cylinders
  if (row == 1) {
    if (col > 1) {
      for (i = [1:col-1]) {
        translate([h_pitch*i, h_pitch/2, 0])
        beam_cylinder(height);
      }
    }
  } else if (col == 1) {
    for (j = [1:row-1]) {
      translate([h_pitch/2, h_pitch*j, 0])
      beam_cylinder(height);
    }

  } else {
    for (j = [1:row-1]) {
      for (i = [1:col-1]) {
        translate([h_pitch*i, h_pitch*j, 0])
        brick_cylinder(height);
      }
    }
  }
}

module beam(k) {
  build_brick(k, 1, v_pitch);
}

module brick(k) {
  build_brick(k, 2, v_pitch);
}

module plate(col, row) {
  build_brick(col, row, v_pitch/3);
}


// let's build some parts!
brick(2);

translate([-20, 0, 0])
plate(1,1);

translate([-20, 10, 0])
beam(1);

translate([20, 0, 0])
brick(4);

translate([0, 20, 0])
beam(5);

translate([0, 30, 0])
plate(2, 2);

translate([0, -70, 0])
plate(10, 8);

translate([-10, 0, 0])
plate(1, 10);

translate([-40, -40, 0])
plate(3, 5);