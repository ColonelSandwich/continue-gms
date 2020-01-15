///drawCircle3D(x, y, z, scaleFactor)

/*COLONEL'S NOTE: 3D Projection works as such:
You have World Coordinates and Screen Coordinates.
World Coords are basically where the objects exist in the game, and
Screen Coords are where they should end up being rendered.

Basically, to get the Screen X you multiply 1/z by the World X minus the Camera X
plus half the distance of the screen/window.
(In this case I've also multiplied 1/z*(WorldX-CameraX) by view_wview/2, which just makes the
Screen X values more extreme)

Do the same for Screen Y but substitute Y in for X,
Except in this case Z is the up vector so it's World Z minus Camera Z lmao
(I multiplied 1/z*(WorldZ-CameraZ) by view_hview/2 instead)

To get the scale we just do 1/z multiplied by an arbitrary scale value
You don't even have to multiply 1/z by anything, but if you don't you won't really be able to see
the sprites now will you

Finally, the depth is just the World Y minus the Camera Y

I'm not good at explaining things so here's an actually good explanation of what's going on:
https://codeincomplete.com/posts/javascript-racer-v1-straight/
*/

var _scl = 1/argument1;
var _sx = view_wview/2+(argument0*_scl*view_wview/2);
var _sy = view_hview/2+(argument2*_scl*view_hview/2);
var _w = _scl*argument3;

//Clip
if(argument1 > 0){
    //Big circle
    draw_set_colour(obj_continue.col1);
    draw_circle(_sx, _sy, _w, false);
    
    //Shine
    draw_set_colour(obj_continue.col2);
    draw_circle(_sx-_w*0.35, _sy-_w*0.35, _w*0.45, false);
    
    depth = argument1;
}
