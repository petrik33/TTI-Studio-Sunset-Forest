// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CameraStateControlled(){
	var horizontal_input = keyboard_check(ord("D")) - keyboard_check(ord("A"));
	var vertical_input = keyboard_check(ord("S")) - keyboard_check(ord("W"));
	x += horizontal_input * 8;
	y += vertical_input * 8;
}