module detal(){
difference(){
    translate([0,20,0])
    cube(size=[150,40,30], center=true);
}
}
module bolt(){
    //bolt
    cylinder(r=4.4, h=150, center=true); 
    //faska
    translate([0,0,-40])cylinder(r=6.4, h=20, center=true);   
}

module wall(){
color("LightYellow")
    translate([0,-5,0])
        cube(size=[1000,10,1000], center=true);
}
module papka (){
    rotate([45,0,0])cube (size=[240,310,30],center=false);
}
wall();


module bolty(){
for (i=[-1,1]){
    rotate([90,0,0])
        translate([35*i,-5,0])
            bolt();
}
}

difference(){
    detal();
        translate([-120,23,0])papka();
    bolty();
    
}
