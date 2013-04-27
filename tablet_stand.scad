base = 50;
height = 50;
t = 4;  // thickness

linear_extrude(height = 2)
difference() {
  polygon([[0, 0], [base, 0], [0, height]], [[0, 1, 2]]);
  polygon([[t, t], [base-(2.707*t), t], [t, height-(2.707*t)]], [[0, 1, 2]]);
}