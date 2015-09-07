module body (){
    difference(){
        cube (size =[15,15,15], center=true);
        translate([15/2,15/2,0])rotate([0,0,45]) cube (size =[30,30,30], center=true);
    }
}

module dirka(size=3){
    cylinder(d=size+0.4, center=true, h=55, $fn=100);
    translate([72,0,0])cylinder(d=size+0.4, center=true, h=55, $fn=100);
    
}

module coolerHoles(diam=4){
                translate([-72/2,0,0])
            for(i=[1,-1]){
                 translate([0,i*72/2,0])
                for(i=[0:1]){
                    translate([i*72,0,0])cylinder(d=diam+0.4, center=true, h=55, $fn=100);
                }
            }
}

module cooler(size=80){
        difference(){
            union(){
                cube (size=[80,80,25], center=true);
                cylinder(d=81, h=16, center=true);
            }
            coolerHoles();
            cylinder (d=75, center=true, h=50);
            rotate([0,0,45])cube(size=[90,90,16], center=true);
            
        }
        
    }
    

    //whole render detail
    difference(){
        union(){
            difference(){
                cube([89,89,24], center=true);
                cube([80,80,25], center=true);
            }
            cooler();
        }
        for(i=[1,-1]){
            translate([0,0,i*25/2])cube([90,90,25/2],center=true);
        }
        //make 1 side
        translate([-95/4,0,0])cube(size=[95,95,30], center=true);
        //holes for wood
        for(i=[-1,1]){
            translate([0,20*i,0])rotate([0,90,0])cylinder (d=3+0.4, h=150, center=true, $fn=100);
        }
    }
    