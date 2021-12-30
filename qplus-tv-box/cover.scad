length=118;
width=90;
thickness=2;
fansize=25;
fanxpos=45;
fanypos=32;
screwint=4;
delta=5;

module uppercase(length,width,thickness){
    cube([length+2*thickness,width+2*thickness,thickness]);
}

module squarefan(size,xpos,ypos,delta){
    flowlength=size-screwint-2*thickness;
    flowwidth=size-screwint-2*thickness;
    translate([xpos+screwint+thickness,ypos+screwint+thickness,-delta]) cube([flowlength,flowwidth,thickness+2*delta]);
    coverscrew(xpos,ypos,screwint,delta);
    coverscrew(xpos+size,ypos,screwint,delta);
    coverscrew(xpos,ypos+size,screwint,delta);
    coverscrew(xpos+size,ypos+size,screwint,delta);
}

module roundfan(size,xpos,ypos,delta){
    flowlength=size-screwint-2*thickness;
    flowwidth=size-screwint-2*thickness;
    translate([xpos+size/2+thickness,ypos+size/2+thickness,-delta]) cylinder(h=2*delta,d=size);
    coverscrew(xpos,ypos,screwint,delta);
    coverscrew(xpos+size,ypos,screwint,delta);
    coverscrew(xpos,ypos+size,screwint,delta);
    coverscrew(xpos+size,ypos+size,screwint,delta);
}

module coverscrew(xpos,ypos,diameter,delta){
    translate([xpos+thickness,ypos+thickness,-delta]) cylinder(h=thickness+2*delta,d=diameter);
}

difference(){
    uppercase(length,width,thickness);
    coverscrew(screwint-2,screwint-2,screwint,delta);
    coverscrew(length-screwint+2,screwint-2,screwint,delta);
    coverscrew(screwint-2,width-screwint+2,screwint,delta);
    coverscrew(length-screwint+2,width-screwint+2,screwint,delta);
    roundfan(fansize,fanxpos,fanypos,delta);
}
translate([(length+2*thickness)/2-delta,thickness,thickness]) cube([2*delta,delta,delta]);
translate([(length+2*thickness)/2-delta,width+thickness-delta,thickness]) cube([2*delta,delta,delta]);
translate([thickness,(width+2*thickness)/2-delta,thickness]) cube([delta,2*delta,delta]);
translate([length+thickness-delta,(width+2*thickness)/2-delta,thickness]) cube([delta,2*delta,delta]);