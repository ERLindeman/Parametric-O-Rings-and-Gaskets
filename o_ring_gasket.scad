///////////////////////////////////////////////////////////
// o_ring_gasket.scad
// Author: Enoch Lindeman
// Provides parametric O-rings and gaskets.
//
// Usage Calls: 
// Uncomment one of the following lines to generate geometry
// Ctrl+D to comment; Ctrl+Shift+D to uncomment.
 oRing(outerDiameter=40, crossSectionDiameter=4);
// gasket(outerDiameter=80, innerDiameter=60, thickness=3);

////////////////////
// Global Settings
////////////////////
$fn = 64;  // Controls smoothness (segment count) for all curved geometry

///////////////////////////////////////////////////////////
// MODULE: oRing
// Creates a torus (3D ring) using two parameters:
//   - outerDiameter: approximate outer diameter of the O-ring
//   - crossSectionDiameter: thickness (cross-sectional diameter)
///////////////////////////////////////////////////////////
module oRing(
  outerDiameter        = 40,
  crossSectionDiameter = 3
) {
  majorR = (outerDiameter - crossSectionDiameter) / 2;
  minorR = crossSectionDiameter / 2;
  torusApprox(majorR, minorR, $fn, $fn);
}

///////////////////////////////////////////////////////////
// MODULE: gasket
// Creates a flat washer-like gasket with a centered hole.
// Parameters:
//   - outerDiameter, innerDiameter, thickness
///////////////////////////////////////////////////////////
module gasket(
  outerDiameter = 100,
  innerDiameter = 80,
  thickness     = 2
) {
  difference() {
    // Outer ring
    cylinder(d = outerDiameter, h = thickness, center = true);
    // Inner opening and centered hole
    cylinder(d = innerDiameter, h = thickness + 0.1, center = true);
  }
}

///////////////////////////////////////////////////////////
// Helper MODULE: torusApprox
// Creates a torus by rotating a circle around a specified radius.
// Parameters:
//   - majorR: distance from the center of the torus to the center of the tube
//   - minorR: radius of the tube itself
//   - majorSegments: segments around the torus
//   - minorSegments: segments for the tube cross-section
///////////////////////////////////////////////////////////
module torusApprox(majorR, minorR, majorSegments=64, minorSegments=32) {
  rotate_extrude($fn = majorSegments, angle = 360) {
    translate([majorR, 0])
      circle(r = minorR, $fn = minorSegments);
  }
}
