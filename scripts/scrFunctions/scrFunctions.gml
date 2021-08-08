function PlaySound(soundid,priority,lowpitch,highpitch,loops)
{
	//SOUND BUFFER MAKES SURE TWO SOUNDS DON'T PLAY AT THE EXACT SAME TIME IN THE MENU, WHICH INCREASE VOLUME
	if (global.sound_buffer == 0)
	{
		var _pitch = random_range(lowpitch,highpitch);
		audio_sound_pitch(soundid,_pitch);
		audio_play_sound(soundid,priority,loops);
		global.sound_buffer = 1;
	}		
}

function Loop(value_to_loop,min_value,max_value){
	
	if (value_to_loop > max_value) value_to_loop = min_value;
	if (value_to_loop < min_value) value_to_loop = max_value;
	return value_to_loop;
}

function DrawSet(font,h_align,v_align){
	draw_set_font(font);
	draw_set_halign(h_align);
	draw_set_valign(v_align);
}

function CreateButton(_text,_mouse_x,_mouse_y,_x_place,_y_place,_size) constructor {
	text = _text;
	x_place = _x_place;
	y_place = _y_place;
	cx1 = x_place - _size
	cy1 = y_place - _size;
	cx2 = x_place + _size
	cy2 = y_place + _size
	mouse_hovering = point_in_rectangle(_mouse_x,_mouse_y,cx1,cy1,cx2,cy2);
	
	color = c_gray;
	x_scale = 1;
	y_scale = 1;
	
	if (mouse_hovering)
	{		
		x_scale = 1.2;
		y_scale = 1.2;
		color = c_white;
	} 
	else 
	{
		x_scale = 1;
		y_scale = 1;
		color = c_gray;
	}
}

function CollisionBox(_font,_text,_xplace,_yplace,_halign,_valign,_element) constructor {
	//MOUSE COLLISION
	draw_set_font(_font);
	var _width  = string_width(_text) * _element.x_scale;
	var _height = string_height(_text) * _element.y_scale;;
	var _horizontal_multiplier, _vertical_multiplier;
	
	#region HORIZONTAL MULTIPLER
	switch (_halign) 
	{
	    case fa_left:
	        _horizontal_multiplier = 0;
	        break;
		
	    case fa_center:
	        _horizontal_multiplier = -0.5;
	        break;
		
	    case fa_right:
	        _horizontal_multiplier = -1;
	        break;
	}
	#endregion
	
	#region VERTICAL MULTIPLIER
	switch (_valign) 
	{
	    case fa_top:
	        _vertical_multiplier = 0;
	        break;
		
	    case fa_center:
	        _vertical_multiplier = -0.5;
	        break;
		
	    case fa_bottom:
	        _vertical_multiplier = -1;
	        break;
	}
	#endregion
	
	cx1 = _xplace + (_width  * (_horizontal_multiplier));
	cy1 = _yplace + (_height * (_vertical_multiplier));
	cx2 = _xplace + (_width  * (1 + _horizontal_multiplier));
	cy2 = _yplace + (_height * (1 + _vertical_multiplier));
	mouse_hovering = point_in_rectangle(other._mouse_x,other._mouse_y,cx1,cy1,cx2,cy2);
}