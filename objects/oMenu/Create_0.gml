//VARIABLES
inputting = false;
sound_select = snSelect;

_mouse_x = 0;
_mouse_y = 0;

//MAIN MENU
var _element_grid = ds_grid_create(1,4);
ds_grid_clear(_element_grid,new PageElementBlank(""));
_element_grid[# 0,0] = new PageElementScript("START",GameStart);
_element_grid[# 0,1] = new PageElementTransfer("SETTINGS",1);
_element_grid[# 0,2] = new PageElementScript("RESTART",GameRestart);
_element_grid[# 0,3] = new PageElementScript("EXIT",GameEnd);
var _main = new CreateMenuPage("MAIN MENU",_element_grid,room_width/2,room_height/2,128,32);

//SETTINGS
var _element_grid = ds_grid_create(3,2);
ds_grid_clear(_element_grid,new PageElementBlank(""));
_element_grid[# 0,0] = new PageElementTransfer("PREFERENCES",2);
_element_grid[# 1,0] = new PageElementTransfer("AUDIO",3);
_element_grid[# 2,0] = new PageElementTransfer("GRAPHICS",4);
_element_grid[# 1,1] = new PageElementTransfer("BACK",0);
var _settings = new CreateMenuPage("SETTINGS",_element_grid,room_width/2,room_height/2,128,32);


//PREFERENCES
var _element_grid = ds_grid_create(1,2);
ds_grid_clear(_element_grid,new PageElementBlank(""));
_element_grid[# 0,0] = new PageElementToggle("TIMER",Fullscreen,false,"ON","OFF",fa_right,fa_center,16);
_element_grid[# 0,1] = new PageElementTransfer("BACK",1);
var _preferences = new CreateMenuPage("SETTINGS",_element_grid,room_width/2,room_height/2,128,32);


//AUDIO
var _element_grid = ds_grid_create(1,4);
ds_grid_clear(_element_grid,new PageElementBlank(""));
_element_grid[# 0,0] = new PageElementTransfer("MASTER",1);
_element_grid[# 0,1] = new PageElementTransfer("MUSIC",1);
_element_grid[# 0,2] = new PageElementTransfer("SOUND EFFECTS",1);
_element_grid[# 0,3] = new PageElementTransfer("BACK",1);
var _audio = new CreateMenuPage("SETTINGS",_element_grid,room_width/2,room_height/2,128,32);


//GRAPHICS
var _element_grid = ds_grid_create(1,4);
ds_grid_clear(_element_grid,new PageElementBlank(""));
_element_grid[# 0,0] = new PageElementSwitch("NO RESOLUTION",Resolution,0,["ONE","TWO","THREE","FOUR","FIVE"],fa_right,fa_center,fa_left,fa_center,32,0,16);
_element_grid[# 0,1] = new PageElementToggle("FULLSCREEN",Fullscreen,false,"ON","OFF",fa_right,fa_center,16);
_element_grid[# 0,2] = new PageElementSwitch("RESOLUTION",Resolution,0,["ONE","TWO","THREE","FOUR","FIVE"],fa_center,fa_center,fa_center,fa_center,0,24,64);
_element_grid[# 0,3] = new PageElementTransfer("BACK",1);
var _graphics = new CreateMenuPage("SETTINGS",_element_grid,room_width/2,room_height/2,128,36);


main_menu = new CreateMenu("main_menu",_main,_settings,_preferences,_audio,_graphics);