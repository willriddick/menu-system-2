//CREATE PAGE ELEMENTS
function CreatePageElement(_name) constructor {
	name = _name;
	display_text = "";
	font = fnFont;
	h_align = fa_center;
	v_align = fa_center;
	
	times_selected = 0;
	hovering = false;
	mouse_hovering = false;
	
	set_x_place = 0;
    set_y_place = 0;
	x_place = 0;
    y_place = 0;
	
	x_offset = 0;
	y_offset = 0;
    x_scale = 0.75;
    y_scale = 0.75;
	angle = 0;
	color = c_white;
    alpha = 0;
	option_color = c_white;
		
	cx1 = x_place;
	cy1 = y_place;
	cx2 = x_place;
	cy2 = y_place;	
}

function PageElementBlank(_name) : CreatePageElement(_name) constructor {
	type    = instanceof(self);
}

function PageElementSwitch(_name,_script,_selected_option,_array,_halign,_valign,_option_halign,_option_valign) : CreatePageElement(_name) constructor {
	type    = instanceof(self);
	script_ = _script;
	h_align = _halign;
	v_align = _valign;
	
	selected_option = _selected_option;
	option_array = _array;
	option_array_length = array_length(_array);
	option_x_offset = 0;
	option_y_offset = 0;
	option_xscale = 1;
	option_yscale = 1;
	option_x_place = 0;
	option_y_place = 0;
	option_h_align = _option_halign;
	option_v_align = _option_valign;
	
	left_button = 0;
	right_button = 0;
}

function PageElementToggle(_name, _script, _selected_option,_option_1, _option_2,_halign,_valign,_option_offset) : CreatePageElement(_name) constructor {
	type    = instanceof(self);
	script_ = _script;
	h_align = _halign;
	v_align = _valign;
	
	selected_option = _selected_option;
	option_1 = _option_1;
	option_2 = _option_2;
	
	option_offset = _option_offset;
	option_x_place = 0;
	option_y_place = 0;
	option_h_align = fa_left;
	option_v_align = fa_center
}

function PageElementScript(_name, _script) : CreatePageElement(_name) constructor {
	type    = instanceof(self);
	script_ = _script;
}

function PageElementTransfer(_name, _page) : CreatePageElement(_name) constructor {
	type    = instanceof(self);
	page    = _page;
}

//CREATE MENUS
function CreateMenu(_name,_pages) constructor {
	name       = _name;
	menu_pages = [];
	page_index = 0;
	
	for (var i = 1; i < argument_count; i++)
	{
		array_push(menu_pages,argument[i]);	
	}
}


//CREATE MENU PAGES
function CreateMenuPage(_page_name,_element_grid,_x_initial,_y_initial,_x_offset,_y_offset) constructor {
	page_name       = _page_name;
	element_grid    = _element_grid;
	grid_width		= ds_grid_width(element_grid);
	grid_height		= ds_grid_height(element_grid);
		
	element_index_x = 0;
	element_index_y = 0;
	mouse_use = false;
	
	x_initial = _x_initial;
	y_initial = _y_initial;
	x_offset  = _x_offset;
	y_offset  = _y_offset;
}