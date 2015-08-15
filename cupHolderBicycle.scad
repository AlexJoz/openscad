$fn=100;
module stl () {
    import ("C:\\Users\\Skazzi\\Desktop\\Joz\\Mount_fixed.stl", convexity = 10);
}
module bar(){
difference(){
    scale ([0.94,0.94,0.94])stl();
    cupholder();
    translate([0,-6.7,0])cylinder(d=73, h=80, center = true);
    cut();
    translate([0,35.3,0])rotate([90,0,0])bolt();
}
}

//%translate([0,58,0])cylinder (d=31.8, h =100);

module cut(){
for (i =[-1,1]){
    
translate([19.4*i,0,0])rotate([90,0,0])cylinder(d= 3.4, h=300, center = true, $fn = 100);
}
}

module bolt(){
    cylinder (h=8, d=3.4, center=true); // rezbaonly
    translate([0,0,8/2+2.6/2])cylinder (h=2.6, d=6.4, $fn=6, center=true); //guika
    translate([0,0,-8/2-2.6/2])cylinder (h=2.6, d=6.4, $fn=100, center=true); // golovka
}

module cupholder(){
    for(i=[1,1]){
rotate([0,90*i,0])
translate([0,-5,0])
difference(){
cylinder(d=73, h=20, center = true);
    cylinder(d=65,h=80, center=true);
}
}
}
module holder1(){
difference(){
cupholder();
    translate([0,34,0])rotate([90,0,0])bolt();
}
}

holder1();
//bar();