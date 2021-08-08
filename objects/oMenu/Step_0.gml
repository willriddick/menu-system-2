//GET PAGE
var _page = main_menu.menu_pages[main_menu.page_index];

//GET INPUTS
var up		    = keyboard_check_pressed(vk_up);
var down	    = keyboard_check_pressed(vk_down);
var left	    = keyboard_check_pressed(vk_left);
var right	    = keyboard_check_pressed(vk_right);
var enter	    = keyboard_check_pressed(vk_enter)
var mouse_enter = mouse_check_button_pressed(mb_left);

//CONTROLLING WITH MOUSE INPUT
var _actual_mouse_x = device_mouse_x_to_gui(0);
var _actual_mouse_y = device_mouse_y_to_gui(0);
	
if ((_actual_mouse_x != _mouse_x) or (_actual_mouse_y != _mouse_y) or (mouse_enter))
{
	_page.mouse_use = true;	
} else _page.mouse_use = false;	
	
_mouse_x = _actual_mouse_x;
_mouse_y = _actual_mouse_y;

//CONTROLLING WITH KEYBOARD INPUT
if (!inputting)
{	
	//VARIABLES FOR SOUND LOOPING
	var prev_index_x = _page.element_index_x;
	var prev_index_y = _page.element_index_y;
	
	
	if (up or down or left or right)
	{	
		_page.mouse_use = false;	
		
		//CHANGE SELECTED
		var _hor = right - left;
		var _ver = down - up;
		var _temp_index_x = _page.element_index_x + _hor;
		var _temp_index_y = _page.element_index_y + _ver;
		_temp_index_x = Loop(_temp_index_x,0,_page.grid_width-1);
		_temp_index_y = Loop(_temp_index_y,0,_page.grid_height-1);
			
		//MAKE SURE THAT THE TILE WITH ELEMENT EXISTS, IF NOT, IT LOOPS WITH THE ELSE
		var _temp_element = _page.element_grid[# _temp_index_x, _temp_index_y];
		if (_temp_element)
		{
			//MAKE SURE THAT THE DESIRED SELECTION IS NOT A BLANK TILE
			if (_temp_element.type != "PageElementBlank")
			{
				_page.element_index_x = _temp_index_x;
				_page.element_index_y = _temp_index_y;
			}
		}
		else
		{
			_page.element_index_x = _temp_index_x;
			_page.element_index_y = _temp_index_y;	
		}
	}	
	
	//MAKES SURE THAT THE SELECTION ACTUALLY CHANGED BEFORE MAKING SOUND
	if (prev_index_x != _page.element_index_x) or (prev_index_y != _page.element_index_y)
	{
		//PLAY AUDIO
		PlaySound(sound_select,5,0.75,1.25,false);
	}
}


//LOOP THROUGH ELEMENTS ON PAGE
for (var w = 0; w < _page.grid_width; w++)
{
	for (var h = 0; h < _page.grid_height; h++)	
	{
		//FIND ELEMENTS
		var _element = _page.element_grid[# w,h];	

		//PREVIOUS INDEX VARIABLE IS USED FOR PLAYING SOUNDS
		var prev_index_x = _page.element_index_x;
		var prev_index_y = _page.element_index_y;

		//CHECK IF  MOUSE HOVERING OVER THE ELEMENT
		if (_element.mouse_hovering) && (_page.mouse_use) && (!inputting)
		{
			_page.element_index_x = w;
			_page.element_index_y = h;
			
			//MAKES SURE THAT THE SELECTION ACTUALLY CHANGED BEFORE MAKING SOUND
			if (prev_index_x != _page.element_index_x) or (prev_index_y != _page.element_index_y)
			{
				//PLAY AUDIO
				PlaySound(sound_select,5,0.75,1.25,false);
			}
		}
	
		//CHECK IF HOVERING OVER THE ELEMENT
		if (w = _page.element_index_x) && (h = _page.element_index_y) _element.hovering = true;
		else _element.hovering = false;

		//SELECTED		
		if (mouse_enter && _element.mouse_hovering) or (enter && _element.hovering)
		{
			//CHANGE SELECTED
			if (!inputting) 
			{
				_page.element_index_x = w;
				_page.element_index_y = h;
				_element.times_selected++;	
				
				//PLAY SOUND
				PlaySound(snSelect,5,1,1.5,false);
			}
			else if (inputting && _element.times_selected > 0)
			{
				_page.element_index_x = w;
				_page.element_index_y = h;
				_element.times_selected++;	
				
				//PLAY SOUND
				PlaySound(snSelect,5,1,1.5,false);
			}
		}
		
		//EDIT THE ELEMENT STRUCTS
		with (_element)
		{
			//CHECK FOR HOVERING
			if (type != "PageElementBlank")
			{	
				//THIS FUNCTION CREATES A COLLISION BOX FOR THE ELEMENT AND CHECKS FOR MOUSE HOVERING
				CollisionBox(font,name,x_place,y_place,h_align,v_align,self);
			}
			
			//SELECTED EFFECTS
			if (hovering) 
			{	
				color = merge_color(color,c_white,0.2);
				alpha = 1;
				x_scale = lerp(x_scale,1.2,0.3);
				y_scale = lerp(y_scale,1.2,0.3);
				angle = 0;

			}
			else 
			{
				color = merge_color(color,c_gray,0.2);
				alpha = 1;
				x_scale = lerp(x_scale,1,0.3);
				y_scale = lerp(y_scale,1,0.3);
				angle = 0;
			}
			
			//SET LOCATION OF ELEMENTS	
			if (_page.grid_width == 1) set_x_place = _page.x_initial + (w * _page.x_offset);
			else set_x_place = (w*_page.x_offset) + ((room_width - (_page.grid_width*_page.x_offset))/2) + ((w*_page.x_offset)/2);
			set_y_place = (h*_page.y_offset) + ((room_height - (_page.grid_height*_page.y_offset))/2) + ((h*_page.y_offset)/2);
			x_place = set_x_place;
			y_place = set_y_place;
			
			//TYPE SPECIFIC
			switch(type)
			{
				case "PageElementSwitch":
					display_text = string(option_array[selected_option]);	

					x_place	       = set_x_place;
					y_place		   = set_y_place;
					option_x_place = set_x_place + option_x_offset;
					option_y_place = set_y_place + option_y_offset;		
					option_color = merge_color(option_color,c_dkgray,0.2);
					
					if (times_selected > 0)
					{	
						other.inputting = true;	
						
						option_color = merge_color(option_color,c_white,0.2);	
						display_text = string(option_array[selected_option]);	
				
						//KEYBOARD INPUT
						if (left) 
						{
							PlaySound(other.sound_select,5,0.75,1.25,false);
							selected_option--;
						}
						if (right) 
						{
							PlaySound(other.sound_select,5,0.75,1.25,false);
							selected_option++;	
						}
						
						//MOUSE INPUT
						var _width = string_width(display_text);
						var _size = 16;
						
						left_button  = new CreateButton("<<",other._mouse_x,other._mouse_y,
							option_x_place-(_width/2 + _size * 2),option_y_place,_size);
						right_button = new CreateButton(">>",other._mouse_x,other._mouse_y,
							option_x_place+(_width/2 + _size * 2),option_y_place,_size);	
											
						if (mouse_enter) && (left_button.mouse_hovering) 
						{
							PlaySound(other.sound_select,5,0.75,1.25,false);
							selected_option--;
						}
						if (mouse_enter) && (right_button.mouse_hovering) 
						{
							PlaySound(other.sound_select,5,0.75,1.25,false);
							selected_option++;
						}
						
						//LOOP OPTION
						selected_option = Loop(selected_option,0,option_array_length-1)
	
						//CONFIRM (PRESSED BUTTON A SECOND TIME)
						if (times_selected == 2)
						{	
							script_execute(script_,option_array[selected_option]); 
							
							//RESET
							other.inputting = false;
							times_selected = 0;
						}
						
						if (!mouse_hovering) 
						{
							color = merge_color(color,c_gray,0.2);
							x_scale = lerp(x_scale,1,0.3);
							y_scale = lerp(y_scale,1,0.3);
						}
							
					}	
				break;
				
				
				/////////////////////////////////////////////////////////////////
				
				case "PageElementToggle": 
					if (selected_option) display_text = string(option_1);
					else display_text = string(option_2);
					
					x_place	       = set_x_place - option_offset;
					y_place		   = set_y_place;
					option_x_place = set_x_place + option_offset;
					option_y_place = set_y_place;
					
					if (!other.inputting) && (times_selected == 0) && (hovering or mouse_hovering)
					{
						option_color = merge_color(option_color,c_gray,0.2);	
					} else option_color = merge_color(option_color,c_dkgray,0.2);
					
					if (times_selected > 0)
					{
						selected_option = !selected_option;
						script_execute(script_,selected_option); 
						
						//RESET
						times_selected = 0
					}
				break;
				
				/////////////////////////////////////////////////////////////////

				case "PageElementScript": 
					if (times_selected > 0)
					{
						script_execute(script_); 
						
						//RESET
						times_selected = 0
					}
				break;
								
				/////////////////////////////////////////////////////////////////
					
				case "PageElementTransfer":
					if (times_selected > 0)
					{		
						//CHANGE PAGE
						other.main_menu.page_index = page;	
						
						//LOOP THROUGH ELEMENTS ON NEXT PAGE (ANIMATES PAGE CHANGE)
						var _page = other.main_menu.menu_pages[other.main_menu.page_index];
						for (var w = 0; w < _page.grid_width; w++)
						{
							for (var h = 0; h < _page.grid_height; h++)	
							{
								//FIND ELEMENTS
								var _element = _page.element_grid[# w,h];
								_element.x_scale = 0.75;
								_element.y_scale = 0.75;
							}
						}
						
						//RESET
						times_selected = 0;
					}
				break;	
			}
		}	
	}
}






//DESTROY MENU
if (oGameController.destroy_menu) instance_destroy();