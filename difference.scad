module base_cylinder() {
  cylinder(50, 10, 10);
}

difference() {
  translate([0, -25, -25])
  base_cylinder();

  rotate([90, 0, 0])
  cylinder(50, 8, 10);
}