///////////////////////////////////////////////////////////
// o_ring_gasket_thingiverse.scad
// Author: Enoch Lindeman (updated for Thingiverse by ChatGPT)
// Parametric tool for creating O-rings and gaskets.
//
// Usage:
// Modify the global variables below using the Thingiverse Customizer.
// Set $mode to choose between an O-ring and a gasket, and customize
// dimensions using the associated parameters.
//
///////////////////////////////////////////////////////////

////////////////////
// User Parameters
////////////////////

// Mode: Select the shape type (0 = O-ring, 1 = Gasket)
$mode = 0;  // 0 for O-ring, 1 for Gasket

// Outer Diameter: Sets the outer diameter of the O-ring or gasket
$outerDiameter = 40;  // Units in mm

// Cross-Section Diameter: Thickness of the O-ring (only used in $mode = 0)
$crossSectionDiameter = 4;  // Units in mm

// Inner Diameter: Sets the inner diameter of the gasket (only used in $mode = 1)
$innerDiameter = 30;  // Units in mm

// Thickness: Sets the thickness of the gasket (only used in $mode = 1)
$thickness = 3;  // Units in mm

// Smoothness: Controls the smoothness of curves for all shapes
$smoothness = 64;  // Higher values give smoother curves

////////////////////
// Global Settings
////////////////////
$fn = $smoothness;  // Apply user-defined smoothness to all curved geometry

////////////////////
// Main Logic
////////////////////
if ($mode == 0) {
  oRing($outerDiameter, $crossSectionDiameter);
} else if ($mode == 1) {
  gasket($outerDiameter, $innerDiameter, $thickness);
} else {
  echo("Invalid mode: Use $mode = 0 for O-ring or $mode = 1 for Gasket.");
}

///////////////////////////////////////////////////////////
// MODULE: oRing
// Creates a torus (3D O-ring) with specified outer diameter and
// cross-sectional diameter.
///////////////////////////////////////////////////////////
module oRing(outerDiameter, crossSectionDiameter) {
  majorR = (outerDiameter - crossSectionDiameter) / 2;
  minorR = crossSectionDiameter / 2;
  torusApprox(majorR, minorR, $fn, $fn);
}

///////////////////////////////////////////////////////////
// MODULE: gasket
// Creates a flat washer-like gasket with specified outer and
// inner diameters and thickness.
///////////////////////////////////////////////////////////
module gasket(outerDiameter, innerDiameter, thickness) {
  difference() {
    // Outer ring
    cylinder(d = outerDiameter, h = thickness, center = true);
    // Centered hole
    cylinder(d = innerDiameter, h = thickness + 0.1, center = true);
  }
}

///////////////////////////////////////////////////////////
// Helper MODULE: torusApprox
// Creates a torus by rotating a circle around a specified radius.
///////////////////////////////////////////////////////////
module torusApprox(majorR, minorR, majorSegments, minorSegments) {
  rotate_extrude($fn = majorSegments) {
    translate([majorR, 0])
      circle(r = minorR, $fn = minorSegments);
  }
}
