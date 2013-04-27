// user-defined specifications:
slots = 7;
slot_width = 5;
tong_width = 10;
base_depth = 40;
back_height = 25;
thickness = 2.5;
num_holes = 3;
hole_radius = 1;

// calculated specs:
width = (slots * slot_width) + ((slots + 1) * tong_width);
hole_offset = tong_width + (slot_width / 2);
hole_space = (width - 2 * hole_offset) / (num_holes - 1);

// build part
union() {
  // place tongs
  for (i = [0:slots]) {
    translate([i * (tong_width + slot_width), 0, 0])
    cube([tong_width, base_depth, thickness]);
  }

  // tong, back panel intersection
  translate([0, 0.8 * base_depth, 0])
  cube([width, 0.2 * base_depth, thickness]);

  // place back panel with holes
  difference() {
    translate([0, base_depth - thickness, 0])
    cube([width, thickness, back_height + thickness]);
  
    for (i = [1:num_holes]) {
      translate([((i - 1) * hole_space) + hole_offset, base_depth - thickness / 2, (back_height / 2) + thickness])
      rotate([90, 0, 0])
      cylinder(h = thickness * 4, r = hole_radius, center = true);
    }
  }
}