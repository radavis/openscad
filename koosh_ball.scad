c_h = 100;
c_r1 = 2;
c_r2 = 2;

module base_cylinder() {
  cylinder(c_h, c_r1, c_r2, center=true);
}

union() {
  for(i = [-90:30:90]) {
    for(j = [-90:30:90]) {
      for(k = [-90:30:90]) {
        rotate([i, j, k])
        base_cylinder();
      }
    }
  }
}