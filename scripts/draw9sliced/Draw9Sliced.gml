///@desc Draw9SlicedBox
///@arg sprite
///@arg x1
///@arg y1
///@arg x2
///@arg y2
function Draw9Sliced(argument0, argument1, argument2, argument3, argument4) {

	var _size=sprite_get_width(argument0)/3;
	var _x1=argument1;
	var _y1=argument2;
	var _x2=argument3;
	var _y2=argument4;

	var _w=_x2-_x1;
	var _h=_y2-_y1;

#region//MIDDLE

	draw_sprite_part_ext(argument0,image_index,_size,_size,1,1,_x1+_size,_y1+_size,_w-(_size*2),_h-(_size*2),c_white,1);

#endregion

#region//CORNERS

		//Top Left
		draw_sprite_part(argument0,image_index,0,0,_size,_size,_x1,_y1);
	
		//Top Right
		draw_sprite_part(argument0,image_index,_size*2,0,_size,_size,_x2-_size,_y1);
	
		//Bottom Left
		draw_sprite_part(argument0,image_index,0,_size*2,_size,_size,_x1,_y2-_size);
	
		//Bottom Right
		draw_sprite_part(argument0,image_index,_size*2,_size*2,_size,_size,_x2-_size,_y2-_size);
	
#endregion

#region//EDGES

		//Left
		draw_sprite_part_ext(argument0,image_index,0,_size,_size,1,_x1,_y1+_size,1,_h-(_size*2),c_white,1);
									   
		//Top						  
		draw_sprite_part_ext(argument0,image_index,_size,0,1,_size,_x1+_size,_y1,_w-(_size*2),1,c_white,1);
									   
		//Right						  
		draw_sprite_part_ext(argument0,image_index,_size*2,_size,_size,1,_x2-_size,_y1+_size,1,_h-(_size*2),c_white,1);

		//Bottom					   
		draw_sprite_part_ext(argument0,image_index,_size,_size*2,1,_size,_x1+_size,_y2-_size,_w-(_size*2),1,c_white,1);
	
#endregion



}
