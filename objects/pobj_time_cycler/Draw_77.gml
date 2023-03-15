#region//Draw Lights
if(!surface_exists(srf_lights))
{
	var _srf_width = surface_get_width(application_surface) / global.GUI_SCALE / global.viewScale;
	var _srf_height = surface_get_height(application_surface) / global.GUI_SCALE / global.viewScale;
	srf_lights = surface_create(_srf_width,_srf_height);
	tex_lights = surface_get_texture(srf_lights);
}

surface_set_target(srf_lights);

draw_clear(c_black);
gpu_set_blendmode(bm_add);
gpu_set_tex_filter(true);

var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

with(pobj_light)
{
	//if(point_in_rectangle(x,y,vx-sprite_width*image_xscale/2,vy,vx+other.view_w+sprite_width*image_xscale/2,vy+other.view_h))
	if(ObjectIsVisible())
	{
		draw_sprite_ext(sprite_index,image_index,(x - vx)*global.viewScale,(y - vy)*global.viewScale,image_xscale*global.viewScale,image_yscale*global.viewScale,image_angle,c_white,image_alpha);
	}
}

//draw_sprite_ext(spr_night_light,0,global.GUI_W/2,0,global.viewScale,global.viewScale,0,c_white,1);

part_system_position(global.lights_part_system,-vx,-vy);
part_system_drawit(global.lights_part_system);

gpu_set_tex_filter(false);
gpu_set_blendmode(bm_normal);

surface_reset_target();

#endregion

#region//Drawing Application Surface
shader_set(shader);

shader_set_uniform_f_array(u_col,color_mix);
shader_set_uniform_f_array(u_con_sat_brt,con_sat_brt_mix);
texture_set_stage(s_lights,tex_lights)

//draw_surface_ext(application_surface,global.GUI_XOFFSET,global.GUI_YOFFSET,global.GUI_SCALE,global.GUI_SCALE,0,c_white,1);
draw_surface(application_surface,global.GUI_XOFFSET,global.GUI_YOFFSET);

shader_reset();

#endregion