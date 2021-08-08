function GameStart() {
	room_goto_next();	
	
	global.paused = false;
}

function GameRestart() {
	game_restart();	
}

function GameEnd() {
	game_end();	
}

function Fullscreen(_selected_option) {
	if (_selected_option == true) window_set_fullscreen(true);
	else window_set_fullscreen(false);
}

function Resolution(_selected_option) {
	
}