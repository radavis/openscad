module flat_heart(size = 20) {
  square(size);

  translate([size/2, size, 0])
  circle(size/2);

  translate([size, size/2, 0])
  circle(size/2);
}

module gross_heart(size = 20, h = 4) {
  linear_extrude(height=h) flat_heart(size);
}

gross_heart(20);
