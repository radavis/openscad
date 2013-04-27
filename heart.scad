module flat_heart() {
  square(20);

  translate([10, 20, 0])
  circle(10);

  translate([20, 10, 0])
  circle(10);
}

linear_extrude(height = 13) 
flat_heart();