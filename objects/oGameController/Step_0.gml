//PAUSING
if (keyboard_check_pressed(vk_escape)) global.paused = !global.paused;
if (room == room_main_menu) in_menu_room = true;
else in_menu_room = false;

//DEBUG
if keyboard_check_pressed(vk_f3) global.debug = !global.debug;

//CREATE MENU OBJECT
if (in_menu_room)        //If in menu room, game is never paused, menu is always viewable
{ 
	if (!instance_exists(oMenu)) instance_create_layer(0,0,"Instances",oMenu); 
	global.paused = true;
}
else					 //When not in menu room, you can pause and unpause to view menu
{
	if (global.paused) 
	{
		destroy_menu = false;
		if (!instance_exists(oMenu)) instance_create_layer(0,0,"Instances",oMenu);
	}
	else if (!global.paused) 
	{
		destroy_menu = true;
	}
}

if (global.sound_buffer > 0) global.sound_buffer--;
else global.sound_buffer = 0;


