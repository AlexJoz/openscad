module tX(x) translate([x,0,0]) children();
module tY(y) translate([0,y,0]) children();
module tZ(z) translate([0,0,z]) children();
module mX(x=1) mirror([x,0,0]) children();
module mY(y=1) mirror([0,y,0]) children();
module mZ(z=1) mirror([0,0,z]) children();
module rX(deg) rotate([deg,0,0]) children();
module rY(deg) rotate([0,deg,0]) children();
module rZ(deg) rotate([0,0,deg]) children();
function op(coordinate)= -coordinate;

module scaleAll(amount) scale([amount,amount,amount]) children();

//testcube

//scaleAll(10)cube([50,100,200]);
    
