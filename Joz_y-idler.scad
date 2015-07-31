include <jozlib.scad>
use <Joz_remake_bearing_holder.scad>

print = true;
$fn=100;

module yBeltHolder(){
    
    difference(){
        union(){
            tX(-3)rZ(90)rX(-90)tX(-154)
            import ("D:\\Joz\\prusa\\Scad\\y-belt-holder\\2_fixed.stl", convexity=10);
            tZ(12)cube(size=[15,65,20], center = true);
        }
        rods(1);
    }
}

module prusaFrame(){
    tZ(120)rX(90)
    difference(){
        cube(size=[390,370,5],center=true);
        cube(size=[230,370-100,6], center=true);
    }
}
module bed(x,y,z) {
	color("white",0.3)	
    tZ(35.5)cube(size=[x,y,z], center=true);
}
module rods(p=2){
    //Y-axis
    if(p==2){
        for(n=[0,1]) mX(n) {
            color("Black",0.2)tX(170/2)rX(90)cylinder(h=380, d = 8, center=true);
        }
    }
    //idler
    color("Black",0.2) 
    for(n=[0,1]) mY (n){
    tY(25)tZ(16.5)rY(90)cylinder(h=220, d=5.4, center=true);
        //nutholes
        for(k=[0,1]) mX(k){
            tX(220/2)tY(25)tZ(16.5)rY(90)cube([18,18,18],center=true);
        }
    }
}

module nut(i,o,h) {
	color([0,1,0]) {
		difference() {
			cylinder(r=o,h=h,$fn=6);
			cylinder(r=i,h=h,$fn=12);
		}
	}
}

module bearingHolders(otv=0){
    tX(170/2)
        for(n=[0,1]) mY(n) {
            if(otv == 0){
            tY(100/2)rX(90)ybe(0);
            }else if (otv == 1){
                tY(100/2)rX(90)jMnt();
            }
            
        }
        if(otv == 0){
    tX(-170/2)rX(90)ybe(0);
        }else if (otv == 1){
          tX(-170/2)rX(90)jMnt();
        }  
}

//right screw hole for clip
module hol(withFaska=1){
            tX(-17/2+4)tZ(9.5/2-3)union(){
                cylinder(d = 3.4, h=100, $fn=30, center=true);
                if(withFaska==1){
                        cylinder(d=5.4, h=20, $fn=6);
                }
            }
}

module clip(align="right"){
tZ(10)
   difference(){
   color ("Green") cube(size=[17,20,4.6+3+3], center=true);
        if(align == "right"){
            tX(10)cube(size=[20,25,4.6],center=true);
            //screw hole
            hol();
            
        }else if (align == "left"){
            tX(-10)cube(size=[20,25,3.5],center=true);
            //screw hole
            mX() hol();
        }
    }    
}

module clips(){
    difference(){
        tZ(25.5){
            tX(210/2)
                for(n=[0,1]) mY(n) {
                    tY(100/2){
                        clip("left");
                        tZ(-9.1)mX()clipMount();
                    }
                }
            tX(-210/2){
                clip("right");
                tZ(-9.1)clipMount();
            }
        }
        rods(1);
        bearingHolders(1);
    }
    
}

module clipMount(){
    difference(){
        tX(12)cube(size=[41,65,10], center=true);
        hol(0);
    }
}


//yBeltHolder();
//prusaFrame();
//bed(210,210,3);
//clips();
//rods();
//bearingHolders();

if(print==true){
   clip();
    //rY(90)yBeltHolder();
    
    //difference(){
    //    clips();
    //    tX(150)cube([300,200,200],center=true);
   //     tZ(180)cube([300,300,300],center=true);
   // }
    
    //ybe(0);
}