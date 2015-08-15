include <Renderer.scad>

//how to render boat, whole or parts(1, 2, 3) for print 
print = false;
part=1;


goldenratio = 2;
jozratio = 2.22;

	width = 250;
	midwidth = width/2;
	depth = 230;
	height = 150;
    
    toph=height/3;
    lowh=height/1.5;
    h=0;

bcolors = [[1,1,0],[1,1,0],[1,1,0],[1,1,0]];

//bow(4,2);
//midships(5,2);
//stern(4,2);

module headCap(engineRadius){
    scale([1/5,1/5,1/5])
    difference(){
        import("elfhead.stl", convexity=3);
        translate([0,0,-84]) cube(size=[50,50,50], center=true);  
        rotate([-90+75,0,0])rotate([90,0,0])translate([0,-15,-50])cylinder(h=100, r=engineRadius, center=true, $fn=100);
        
    }
}


module support(){
    for (i = [0:24]){
            rotate([0,0,360*i/25]) 
    cube(size=[0.2,30,2],center=true);
    }
}

module propeller(engineRadius=10, engineHeight=550){
    //d= 30, h=10;
    //%cylinder(d=30, h=10, $fn=100);
    //engine connector

        //propeller
    difference(){
       union(){ 
       cylinder(h=engineHeight, r2=engineRadius+2, r1=3.2, center=true, $fn=100);
    difference(){
        cylinder(d=30, h=10, $fn=100, center=true);
        cylinder(d=28.4, h=15, $fn=100, center=true);
    }
    union(){
        for (i = [0:4]){
            rotate([0,0,360*i/5]) 
            union(){
                rotate([90,0,90]) 
                linear_extrude(height=14.3, center=false, convexity=10, twist=60, slices=15)
                scale([1/5,1,1]) circle(r = 5);
            }
        }
    }
}

   //global propeller cut 
   //cylinder outside
   difference(){
        cylinder(d=32, h=10, $fn=100, center=true);
        cylinder(d=30, h=15, $fn=100, center=true);
    }
    //and up and down
    translate([0,0,17.7])cube(size=[30,30,30],center=true);
    translate([0,0,-20])cube(size=[30,30,30],center=true);
    // engine connect
    translate([0,0,6])cylinder(h=engineHeight+2, r=engineRadius+0.4, center=true, $fn=20);
    
    // for rubber
    cylinder(r=0.4+7/2-2, h=50, center=true, $fn=100);
} 

    
}



module toy(){
	difference(){
		boat(8,4);
		engine(10,550,"position") engine(10,550, "place");
	}
	
	//engine(10,550,"position") engine(10,550, "make");
}

//print
//translate([0,0,5])rotate([0,180,0]) union(){
//propeller(0.4+7/2,10);    }
// translate([30,0,0]) engine(0.4+7/2,170,"make");

if(print == true){
    
}else if (print == false){
    
  scale([1/5,1/5,1/5])boat(10,4);  
}






//lodka v razreze
//difference(){
//rotate([0,180,0])
//toy();
//engine(0.4+7/2,170,"position")engine(0.4+7/2,170,"make");
//engine(0.4+7/2,170,"position") propeller(0.4+7/2,10);
//#translate([0,160,40])engine(0.4+7/2,170,"position")rotate([90+25,180,0])headCap(10);
//#translate([0,0,-500])cube([1000,1000,1000]);
//}



module frontdeck(steps=8, thickness=2,){
    h=0;
	rcp4 = [[0,depth,midwidth],
 	[1/3*h,depth,midwidth-8*2/3*goldenratio],
 	[2/3*h,depth,midwidth*1/3/goldenratio],
    [h,depth,0]]; 
    
	rcp3 = [[0,depth*2/3,midwidth],
 	[1/3*h,depth*2/3,midwidth*2/3],
 	[2/3*h,depth*2/3,midwidth*1/3/goldenratio/goldenratio],
    [h,depth*2/3,0]]; 
    
	rcp2 = [[0,depth*1/3,midwidth],
 	[1/3*-h,depth*1/3,midwidth*2/3],
 	[2/3*-h,depth*1/3,midwidth*1/3/goldenratio/goldenratio/goldenratio], 
    [-h,depth*1/3,0]]; 
    
	rcp1 = [[-toph,0,0],
    [-1/3*toph,0,0],
    [-2/3*toph,0,0], 
    [-toph,0,0]]; 


	lcp4 = [[0,depth,midwidth],
 	[-1/3*h,depth,midwidth-8*2/3*goldenratio],
 	[-2/3*h,depth,midwidth*1/3/goldenratio],
    [h,depth,0]]; 
    
	lcp3 = [[0,depth*2/3,midwidth],
 	[-1/3*h,depth*2/3,midwidth*2/3],
 	[-2/3*h,depth*2/3,midwidth*1/3/goldenratio/goldenratio],
    [-h,depth*2/3,0]];
    
	lcp2 = [[0,depth*1/3,midwidth],
 	[1/3*h,depth*1/3,midwidth*2/3],
 	[2/3*h,depth*1/3,midwidth*1/3/goldenratio/goldenratio/goldenratio],
    [-h,depth*1/3,0]]; 
    
	lcp1 = [[toph,0,0],
    [1/3*toph,0,0],
    [2/3*toph,0,0],
    [toph,0,0]]; 


	union()
	{
			//DisplayBezControlFrame([rcp1,rcp2,rcp3,rcp4], radius = 0.5);
			DisplayBezSurface([rcp1,rcp2,rcp3,rcp4], 
				colors=bcolors,
				steps=steps, thickness=thickness);

			rotate([0, -180, 0])
			{
				//DisplayBezControlFrame([lcp1,lcp2,lcp3,lcp4], radius = 0.5);
				DisplayBezSurface([lcp1,lcp2,lcp3,lcp4], 
					colors=bcolors,
					steps=steps, thickness=thickness);
			}
	}    
}

module engine(engineRadius=10, engineHeight=550, act){

	if (act == "position"){
		color("Red",0.5) rotate([-75,00,0]) translate([0,height/3.5,height/13/3.5]) children();
		} else if (act == "make"){
			difference(){
				cylinder(h=engineHeight, r=engineRadius, center=false, $fn=100);
				cylinder(h=engineHeight+2, r=engineRadius-2, center=false, $fn=100);
				translate([0,0,engineHeight]) cube(size = [2*engineRadius,2,5], center=true);
			}
		} else if (act == "place"){
				cylinder(h=engineHeight, r=engineRadius, center=false, $fn=200);
		} 


}



//tail1();
//tail11();

module tail1(steps=8, thickness=2, right=true)
{
    //z, y, x

	rcp4 = [[0,depth,0],
 	[1/3*height,depth,0*goldenratio],
 	[2/3*height,depth,0/goldenratio],
    [height,depth,0]]; 
    
	rcp3 = [[0,depth*2/3,midwidth],
 	[0,0,0],
 	[0,0,0],
    [height,depth*2/3,0]];  
    
	rcp2 = [[0,depth*1/3,midwidth],
 	[0,0,0],
 	[0,0,0],
    [height,depth*1/3,90]];  
    
	rcp1 = [[0,0,90],
    [20,-20,90],
    [40,-40,90],
    [60,-100,90]]; 


	lcp4 = [[0,depth,0],
 	[-1/3*height,depth,0*goldenratio],
 	[-2/3*height,depth,0/goldenratio],
    [-height,depth,0]]; 
    
	lcp3 = [[0,depth*2/3,midwidth],
 	[0,0,0],
 	[0,0,0],
    [-height,depth*2/3,0]];  
    
	lcp2 = [[0,depth*1/3,midwidth],
 	[0,0,0],
 	[0,0,0],
    [-height,depth*1/3,90]]; 

	lcp1 = [[0,0,90],
    [-20,-20,90],
    [-40,-40,90],
    [-60,-100,90]];  


	union()
	{
			//DisplayBezControlFrame([rcp1,rcp2,rcp3,rcp4], radius = 0.5);
			DisplayBezSurface([rcp1,rcp2,rcp3,rcp4], 
				colors=bcolors,
				steps=steps, thickness=thickness);

			rotate([0, -180, 0])
			{
				//DisplayBezControlFrame([lcp1,lcp2,lcp3,lcp4], radius = 0.5);
				DisplayBezSurface([lcp1,lcp2,lcp3,lcp4], 
					colors=bcolors,
					steps=steps, thickness=thickness);
			}
	}
}


module tail11(steps=8, thickness=2, right=true)
{
    
	rcp4 = [[0,depth,midwidth],
 	[1/3*h,depth,midwidth*2/3*goldenratio],
 	[2/3*h,depth,midwidth*1/3/goldenratio],
    [h,depth,0]]; 
    
	rcp3 = [[0,depth*2/3,midwidth],
 	[1/3*h,depth*2/3,midwidth*2/3],
 	[2/3*h,depth*2/3,midwidth*1/3/goldenratio],
    [h,depth*2/3,0]]; 
    
	rcp2 = [[0,depth*1/3,midwidth],
 	[0,depth*1/3,midwidth*2/3],
 	[0,depth*1/3,midwidth*1/3/goldenratio/goldenratio], 
    [0,depth*1/3,90]]; 
    
	rcp1 = [[0,0,90],
    [0,-20,90],
    [0,40,90],
    [0,100,90]];  


	lcp4 = [[0,depth,midwidth],
 	[-1/3*height,depth,midwidth*2/3*goldenratio],
 	[-2/3*height,depth,midwidth*1/3/goldenratio],
    [-height,depth,0]]; 
    
	lcp3 = [[0,depth*2/3,midwidth],
 	[-1/3*height,depth*2/3,midwidth],
 	[-2/3*height,depth*2/3,midwidth/goldenratio],
    [-height,depth*2/3,0]];
    
	lcp2 = [[0,depth*1/3,midwidth],
 	[-1/3*height,depth*1/3,midwidth*2/3],
 	[-2/3*height,depth*1/3,midwidth*1/3/goldenratio/goldenratio],
    [-height,depth*1/3,90]]; 
    
	lcp1 = [[0,0,90],
    [h,-20,90],
    [-40,-40,90],
    [-60,-100,90]]; 


	union()
	{
			//DisplayBezControlFrame([rcp1,rcp2,rcp3,rcp4], radius = 0.5);
			DisplayBezSurface([rcp1,rcp2,rcp3,rcp4], 
				colors=bcolors,
				steps=steps, thickness=thickness);

			rotate([0, -180, 0])
			{
				//DisplayBezControlFrame([lcp1,lcp2,lcp3,lcp4], radius = 0.5);
				DisplayBezSurface([lcp1,lcp2,lcp3,lcp4], 
					colors=bcolors,
					steps=steps, thickness=thickness);
			}
	}
}

module bow(steps=8, thickness=2, right=true)
{
    
	rcp4 = [[0,depth,midwidth],       //upper, inner
 	[1/3*height,depth,midwidth*2/3*goldenratio],
 	[2/3*height,depth,midwidth*1/3/goldenratio],
    [height,depth,0]];               //down, end
    
	rcp3 = [[0,depth*2/3,midwidth],
 	[1/3*height,depth*2/3,midwidth*2/3],
 	[2/3*height,depth*2/3,midwidth*1/3/goldenratio],
    [height,depth*2/3,0]]; 
    
	rcp2 = [[0,depth*1/3,midwidth],
 	[1/3*lowh,depth*1/3,midwidth*2/3],
 	[2/3*lowh,depth*1/3,midwidth*1/3/goldenratio/goldenratio], 
    [height,depth*1/3,90]]; 
    
	rcp1 = [[0,0,90],
    [20,-20,90],
    [40,-40,90],
    [60,-100,90]];  


	lcp4 = [[0,depth,midwidth],
 	[-1/3*height,depth,midwidth*2/3*goldenratio],
 	[-2/3*height,depth,midwidth*1/3/goldenratio],
    [-height,depth,0]]; 
    
	lcp3 = [[0,depth*2/3,midwidth],
 	[-1/3*height,depth*2/3,midwidth],
 	[-2/3*height,depth*2/3,midwidth/goldenratio],
    [-height,depth*2/3,0]];
    
	lcp2 = [[0,depth*1/3,midwidth],
 	[-1/3*height,depth*1/3,midwidth*2/3],
 	[-2/3*height,depth*1/3,midwidth*1/3/goldenratio/goldenratio],
    [-height,depth*1/3,90]]; 
    
	lcp1 = [[0,0,90],
    [-20,-20,90],
    [-40,-40,90],
    [-60,-100,90]]; 


	union()
	{
			//DisplayBezControlFrame([rcp1,rcp2,rcp3,rcp4], radius = 0.5);
			DisplayBezSurface([rcp1,rcp2,rcp3,rcp4], 
				colors=bcolors,
				steps=steps, thickness=thickness);

			rotate([0, -180, 0])
			{
				//DisplayBezControlFrame([lcp1,lcp2,lcp3,lcp4], radius = 0.5);
				DisplayBezSurface([lcp1,lcp2,lcp3,lcp4], 
					colors=bcolors,
					steps=steps, thickness=thickness);
			}
	}
}

module midships(steps=8, thickness=2)
{

	rcp4 = [[0,depth,midwidth], 	
    [1/3*height,depth,midwidth*2/3*goldenratio], 	
    [2/3*height,depth,midwidth*1/3/goldenratio], 		
    [height,depth,0]]; 
    
	rcp3 = [[0,depth*2/3,midwidth],
 	[1/3*height,depth*2/3,midwidth*2/3*goldenratio],
 	[2/3*height,depth*2/3,midwidth*1/3/goldenratio],
    [height,depth*2/3,0]]; 
    
	rcp2 = [[0,depth*1/3,midwidth],
 	[1/3*height,depth*1/3,midwidth*2/3*goldenratio],
 	[2/3*height,depth*1/3,midwidth*1/3/goldenratio],
    [height,depth*1/3,0]]; 
    
	rcp1 = [[0,0,midwidth],
    [1/3*height,0,midwidth*2/3*goldenratio],
    [2/3*height,0,midwidth*1/3/goldenratio],
    [height,0,0]]; 

	lcp4 = [[0,depth,midwidth],
 	[-1/3*height,depth,midwidth*2/3*goldenratio],
 	[-2/3*height,depth,midwidth*1/3/goldenratio],
    [-height,depth,0]]; 
	lcp3 = [[0,depth*2/3,midwidth],
 	[-1/3*height,depth*2/3,midwidth*2/3*goldenratio],
 	[-2/3*height,depth*2/3,midwidth*1/3/goldenratio],
    [-height,depth*2/3,0]]; 
	lcp2 = [[0,depth*1/3,midwidth],
 	[-1/3*height,depth*1/3,midwidth*2/3*goldenratio],
 	[-2/3*height,depth*1/3,midwidth*1/3/goldenratio],
    [-height,depth*1/3,0]]; 
	lcp1 = [[0,0,midwidth],
    [-1/3*height,0,midwidth*2/3*goldenratio],
    [-2/3*height,0,midwidth*1/3/goldenratio],
    [-height,0,0]]; 


	//DisplayBezControlFrame([rcp1,rcp2,rcp3,rcp4], radius = 0.5);
	DisplayBezSurface([rcp1,rcp2,rcp3,rcp4], 
		colors=bcolors,
		steps=steps, thickness=thickness);

	rotate([0, -180, 0])
	{
		//DisplayBezControlFrame([lcp1,lcp2,lcp3,lcp4], radius = 0.5);
		DisplayBezSurface([lcp1,lcp2,lcp3,lcp4], 
			colors=bcolors,
			steps=steps, thickness=thickness);
	}
}

module stern(steps=8, thickness=2)
{
    midwidth1 = 50;

	rcp4 = [[-toph,depth,0],
 	[1/3*height,depth,0],
 	[2/3*height,depth,0],
    [2/3*height,2/3*depth, 0]];
    
	rcp3 = [[0,depth*2/3,midwidth1],
 	[1/3*height,depth*2/3,midwidth1*2/3*goldenratio],
 	[2/3*height,depth*2/3,midwidth1*1/3/goldenratio],
    [2/3*height,depth*2/3,0]]; 
    
	rcp2 = [[0,depth*1/3,midwidth],
 	[1/3*height,depth*1/3,midwidth*2/3*goldenratio],
 	[2/3*height,depth*1/3,midwidth*1/3/goldenratio],
    [height,depth*1/3,0]]; 
    
	rcp1 = [[0,0,midwidth],
    [1/3*height,0,midwidth*2/3*goldenratio],
    [2/3*height,0,midwidth*1/3/goldenratio],
    [height,0,0]]; 

	lcp4 = [[toph,depth,0],
 	[-1/3*height,depth,0],
 	[-2/3*height,depth,0],
    [-2/3*height,2/3*depth, 0]];
    
	lcp3 = [[0,depth*2/3,midwidth1],
 	[-1/3*height,depth*2/3,midwidth1*2/3*goldenratio],
 	[-2/3*height,depth*2/3,midwidth1*1/3/goldenratio],
    [-2/3*height,depth*2/3,0]]; 
    
	lcp2 = [[0,depth*1/3,midwidth],
 	[-1/3*height,depth*1/3,midwidth*2/3*goldenratio],
 	[-2/3*height,depth*1/3,midwidth*1/3/goldenratio],
    [-height,depth*1/3,0]]; 
    
	lcp1 = [[0,0,midwidth],
    [-1/3*height,0,midwidth*2/3*goldenratio],
    [-2/3*height,0,midwidth*1/3/goldenratio],
    [-height,0,0]]; 


	//DisplayBezControlFrame([rcp1,rcp2,rcp3,rcp4], radius = 0.5);
	DisplayBezSurface([rcp1,rcp2,rcp3,rcp4], 
		colors=bcolors,
		steps=steps, thickness=thickness);

	rotate([0, -180, 0])
	{
		//DisplayBezControlFrame([lcp1,lcp2,lcp3,lcp4], radius = 0.5);
		DisplayBezSurface([lcp1,lcp2,lcp3,lcp4], 
			colors=bcolors,
			steps=steps, thickness=thickness);
	}
}

module boat(steps=8, thickness=2)
{

	
	rotate([0,90,0])
	union()
	{
		bow(steps, thickness);

		tail1(steps, thickness);

		//tail11(steps, thickness);

		translate([0, 1*depth, 0])
		midships(steps,thickness);

		//		translate([0, 2*depth, 0])
		//		midships(steps, thickness);

		translate([0, 2*depth, 0])
		//rotate([0, 0, 180])
		stern(steps, thickness);
	}

	
}