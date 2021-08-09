//DRAW DEFAULTS
draw_set_font(fnFont);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_center);
draw_set_alpha(1);
//New code

var _page = main_menu.menu_pages[main_menu.page_index];
for (var w = 0; w < _page.grid_width; w++)
{
	for (var h = 0; h < _page.grid_height; h++)	
	{
		//GET ELEMENT
		var _element = _page.element_grid[# w,h];
		
		//DEBUG
		if (global.debug)
		{
			draw_set_color(c_red);
			draw_set_alpha(0.2);
			draw_rectangle(_element.cx1,_element.cy1,_element.cx2,_element.cy2,false);
			draw_text(_element.x_place-80,_element.y_place,_element.hovering);
			draw_text(_element.x_place-80,_element.y_place+16,_element.times_selected);
		}
		
		//ELEMENT SPECIFIC DRAWING
		with (_element)
		{
			switch (type)
			{	
				case "PageElementSwitch":
					
				
					//DRAW NAME
					DrawSet(font,h_align,v_align);	
					draw_text_transformed_color(x_place,y_place,name,x_scale,y_scale,angle,
						color,color,color,color,alpha);
				
					//DRAW OPTION
					DrawSet(font,h_align,v_align);	
					draw_text_transformed_color(option_x_place,option_y_place,display_text,option_x_scale,option_y_scale,angle,
						option_color,option_color,option_color,option_color,alpha);

					if (times_selected > 0) 
					{
						DrawSet(font,fa_center,fa_center);	
						with (left_button) draw_text_transformed_color(x_place,y_place,text,x_scale,y_scale,0,
							color,color,color,color,1);
						with (right_button) draw_text_transformed_color(x_place,y_place,text,x_scale,y_scale,0,
							color,color,color,color,1);
												
						if (global.debug)
						{
							draw_set_color(c_red);
							draw_set_alpha(0.2);
							with (left_button) draw_rectangle(cx1,cy1,cx2,cy2,false);
							with (right_button) draw_rectangle(cx1,cy1,cx2,cy2,false);
						}
					}
					
				break;
			
				//////////////////////////////////////////////////////////////////////////

				case "PageElementToggle":
					
					//DRAW NAME
					DrawSet(font,h_align,v_align);	
					draw_text_transformed_color(x_place,y_place,name,x_scale,y_scale,angle,
						color,color,color,color,alpha);
				
					//DRAW OPTION
					DrawSet(font,option_h_align,option_v_align);
					draw_text_transformed_color(option_x_place,option_y_place,display_text,x_scale,y_scale,angle,
						option_color,option_color,option_color,option_color,alpha);
				break;
			
				//////////////////////////////////////////////////////////////////////////
			
				case "PageElementScript":
				
					//DRAW NAME
					DrawSet(font,h_align,v_align);	
					draw_text_transformed_color(x_place,y_place,name,x_scale,y_scale,angle,
						color,color,color,color,alpha);
					
				break;
			
				//////////////////////////////////////////////////////////////////////////
				
				case "PageElementTransfer":
				
					//DRAW NAME
					DrawSet(font,h_align,v_align);	
					draw_text_transformed_color(x_place,y_place,name,x_scale,y_scale,angle,
						color,color,color,color,alpha);
				
				break;
			
			}
		}
	}
}





//DEBUG
if (global.debug)
{
	draw_set_font(fnFont);
	draw_set_color(c_white);
	draw_set_halign(fa_right);
	draw_set_valign(fa_center);
	draw_set_alpha(1);
	
	draw_text(room_width-16,16,"Room:" + string(room));
	draw_text(room_width-16,32,"Paused:" + string(global.paused));
	
	draw_set_halign(fa_left);
	draw_text(16,16,string(_page.element_index_x) + "," + string(_page.element_index_y));
	draw_text(16,32,"mouse_use:" + string(_page.mouse_use));
	draw_text(16,48,"inputting:" + string(inputting));
	
	//DRAW CURSOR
	draw_set_color(c_purple);
	draw_set_alpha(0.5);
	var _size = 8;
	draw_rectangle(_mouse_x-_size,_mouse_y-_size,_mouse_x+_size,_mouse_y+_size,false);
}
