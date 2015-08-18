module funduct(){
    translate([0.9,0,0])
    for(i=[-1,1]){
        translate([0,14.07*i,0])
            tie();
    }
    difference(){
       cube([31,31,25], center=true);
       scale([0.8, 0.8, 0.8]) rotate([0,90,0]) e3d();
       e3d();
       translate([20,0,0])cube([40,40,40],center=true);
    }
}

funduct();

module e3d(){
 cylinder(d=25.4, h=40, center=true);   
    
}

//e3d();

module tie(){
    rotate([90,90,0])
    difference(){
        cube([10,4.5,2.85], center=true);
        cube([3.4, 1.8, 100], center=true);
    }
    
}
//tie();