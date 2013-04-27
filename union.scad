module base_cylinder() {
  cylinder(50, 10, 10);
}

union() {
  translate([0, -25, -25])
  base_cylinder();

  rotate([90, 0, 0])
  cylinder(50, 10, 10);

  translate([-25, -25, 0])
  rotate([0, 90, 0])
  cylinder(50, 10, 10);
}