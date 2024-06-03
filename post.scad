include <BOSL2/std.scad>

$fn = 64;



crossDiameter = 16;
crossThickness = 3;
crossHeight = 17.5;
crossSupportDiameter = crossDiameter / 2;

baseDiameter = crossDiameter * 2;
baseHeight = 4;

coneHeight = 3;


mountingHoleDiameter = 7;
mountingHoleAngle = 25;
mountingFlapDiameter = mountingHoleDiameter * 2.5;
mountingFlapHeight = baseHeight;




// base
cyl(d = baseDiameter, h = baseHeight, center = false);

// cone
up(baseHeight)
    cyl(d1 = baseDiameter, d2 = crossSupportDiameter, h = coneHeight, center = false);


// cross
zrot_copies([0, 90])
    translate([-crossDiameter / 2, -crossThickness / 2, 0])
        cube([crossDiameter, crossThickness, baseHeight + coneHeight + crossHeight]);

// cross support
cyl(d = crossSupportDiameter, h = baseHeight + coneHeight + crossHeight, center = false);


// monting flap
xflip_copy()
    difference()
    {
        union()
        {
            fwd(mountingFlapDiameter / 2)
                cube([baseDiameter / 2 + mountingFlapDiameter / 2, mountingFlapDiameter, mountingFlapHeight]);

            right(baseDiameter / 2 + mountingFlapDiameter / 2)
                cyl(d = mountingFlapDiameter, h = mountingFlapHeight, center = false);
        }
    
        up(mountingFlapHeight / 2)
            xrot(mountingHoleAngle)
                right(baseDiameter / 2 + mountingFlapDiameter / 2)
                    cyl(d = mountingHoleDiameter, h = mountingFlapHeight * 4);


        
        translate([baseDiameter / 2 + 1.5, -2.5, mountingFlapHeight - 0.33])
        {
            cube([2, 4, 1]);

            translate([1, 5, 0])
                rot(-135)
                linear_extrude(1)   
                    right_triangle([3, 3]);
        }
    }