///getSpriteColors(sprite_index, image_index)

/*COLONEL'S NOTE: GameMaker Studio has 2 methods that I know of to get the color data of
a graphical asset.

METHOD A: Draw the asset to a surface and use surface_getpixel
METHOD B: Draw the asset to a surface, put the surface into a buffer, and use bitwise
manipulation to get the RGBA values

Method A is far easier, but also incredibly slow (which isn't great if you need to call
this function every 60 frames !!)

Method B is harder to set up but WAY faster. 
UNFORTUNATELY.


I dont know how to do method b lol

Luckily there was a reddit post explaining how to do so:
https://www.reddit.com/r/gamemaker/comments/60qj6u/extracting_color_values_from_images/

A problem with using this method is that not every target/device uses the BGRA function,
but in this case it's fine because the program only checks to see if the color is white.
(IE R=255, G=255, B=255)

Would've made more sense to check if the Alpha isn't 0 but shut up*/


//Initialize variables
var sp = argument0;
var ii = argument1;
var c;

//Do some surface thingy
var sw = sprite_get_width(sp);
var sh = sprite_get_height(sp);

//Create surface
surf = surface_create(sw, sh);

//Initialize surface
surface_set_target(surf);
draw_clear_alpha(c_red, 1);
draw_sprite(sp, ii, 0, 0);
surface_reset_target();

//Put that bad boy into a buffer
buff = buffer_create(4*sw*sh, buffer_grow, 1);
buffer_get_surface(buff, surf, 0, 0, 0);
//We don't need the surface anymore
surface_free(surf);
//Make sure we're starting at the... start.
buffer_seek(buff, buffer_seek_start, 0);

//Row and column vars
var xx = 0;
var yy = 0;

//Go thru buffer and find color values
for(var i = 0; i < sw*sh; i++){
    pixel = buffer_read(buff, buffer_u32);  //Pixel in ARGB format
    
    var a = (pixel >> 24) & $ff;
    var r = (pixel >> 16) & $ff;
    var g = (pixel >> 8) & $ff;
    var b = (pixel) & $ff;
    //Store color value
    c[xx, yy] = make_colour_rgb(r, g, b);
    //Increase column
    xx++;
    //Increase row
    if(xx >= sw){
        xx = 0;
        yy++;
    }
}

buffer_delete(buff);

return c;
