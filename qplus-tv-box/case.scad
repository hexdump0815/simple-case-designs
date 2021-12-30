length=118;
width=90;
height=30;
thickness=2;
airflowcount=0;
screwint=3;
screwext=2*thickness+screwint;
delta=5;

module lowercase(length,width,height,thickness){
    cube([length+2*thickness,width+2*thickness,thickness]);
    cube([thickness,width+2*thickness,height+thickness]);
    translate([length+thickness,0,0]) cube([thickness,width+2*thickness,height+thickness]);
    cube([length+2*thickness,thickness,height+thickness]);
    translate([0,width+thickness,0]) cube([length+2*thickness,thickness,height+thickness]);
}

module airflow(xsize,ysize,xpos,ypos,thickness,count,delta){
    flowwidth=xsize/(2*count-1);
    for(i=[0:1:count-1]){
        translate([xpos+2*i*        flowwidth,ypos,-delta]) cube([flowwidth,ysize,thickness+2*delta]);
    }
}

module xcutout(xpos,zpos,xsize, zsize,ypos,width,delta){
    translate([xpos+thickness,ypos+thickness-delta,zpos+thickness]) cube([xsize,width+thickness+2*delta,zsize]);
}

module ycutout(ypos,zpos,ysize, zsize,xpos,width,delta){
    translate([xpos+thickness-delta,ypos+thickness,zpos+thickness]) cube([width+thickness+2*delta,ysize,zsize]);
}

module screw(xpos,ypos,height,ediameter,idiameter,delta){
    difference(){
        translate([xpos+thickness,ypos+thickness,thickness]) cylinder(h=height,d=ediameter);
        translate([xpos+thickness,ypos+thickness,height+thickness-delta]) cylinder(h=2*delta,d=idiameter);
    }
}

difference(){
    lowercase(length,width,height,thickness);
    if (airflowcount!=0){
        airflow(40,30,50,20,        thickness,airflowcount,delta);
    }
    xcutout(6,0,106,20,0,thickness,delta);
    ycutout(22,3,30,8,length,thickness,delta);
    ycutout(15,height-3,3,3,length,thickness,delta);
}
screw(screwint-1,screwint-1,height,screwext,screwint,delta);
screw(length-screwint+1,screwint-1,height,screwext,screwint,delta);
screw(screwint-1,width-screwint+1,height,screwext,screwint,delta);
screw(length-screwint+1,width-screwint+1,height,screwext,screwint,delta);
screw(7,22,3,screwext,screwint,delta);
screw(7,79,3,screwext,screwint,delta);
screw(114,19,3,screwext,screwint,delta);
screw(105,79,3,screwext,screwint,delta);

