event_inherited();

title_font = Font(fn_bestiary_title);

sprite_top_right = spr_bestiary_asset_corner;
sprite_circle = spr_bestiary_asset_circle;
sprite_titler = spr_bestiary_asset_titler;

var page_enemy = 0;

#macro corner_asset_x_offset -26
#macro corner_asset_y_offset 25

#macro portrait_x_offset 28
#macro portrait_y_offset 28

#macro circle_asset_R 75

#macro enemy_hp_height 23
#macro enemy_hp_width 26

#macro circle_asset_offset -(circle_asset_R + 28)

sprite_enemy_idle = global.enemies[ENEMY.IDLE][page_enemy];
enemy_idle_spr_spd = sprite_get_speed(sprite_enemy_idle) / FRAME_RATE;
enemy_idle_spr_img_prog = 0;
enemy_idle_spr_img_num = sprite_get_number(sprite_enemy_idle) - 1;

enemy_hp_image = 0;
if(page_enemy == ENEMIES.DOUHTA)
{
	enemy_hp_image = 1;	
}

circle_asset_x = x + page_w + circle_asset_offset;
circle_asset_y = y + page_h + circle_asset_offset;

corner_asset_x = x + page_w + corner_asset_x_offset;
corner_asset_y = y + corner_asset_y_offset;

sprite_enemy_portrait = global.enemies[ENEMY.PORTRAIT][page_enemy];
portrait_asset_x = x + portrait_x_offset;
portrait_asset_y = y + portrait_y_offset;

var enemy_idle_y_offset = SpriteBBoxYOffsetCenter(sprite_enemy_idle,false);
idle_asset_x = circle_asset_x;
idle_asset_y = circle_asset_y + enemy_idle_y_offset;

title_x = portrait_asset_x + 4;
title_y = portrait_asset_y + portrait_height + 8;

hp_assets_x = portrait_asset_x + portrait_width + 8;
hp_assets_y = portrait_asset_y + 4;

enemy_hp = global.enemies[ENEMY.MAX_HP][page_enemy];
hp_assets_gap = enemy_hp_width + 4;

title_asset_x = hp_assets_x + 6;
title_asset_y = hp_assets_y + enemy_hp_height + 8;

var _enemy_name = global.enemies[ENEMY.NAME][page_enemy];
title_string = Text(_enemy_name);

enum ENEMY_BESTIARY_TEXT{
	ABOUT,
	NAME,
	TACTICS,
	ARRAY_LENGTH
}

page_text[ENEMY_BESTIARY_TEXT.ABOUT] = Text(("enemy about: " + _enemy_name));
page_text[ENEMY_BESTIARY_TEXT.NAME] = Text(("enemy name: " + _enemy_name));
page_text[ENEMY_BESTIARY_TEXT.TACTICS] = Text(("enemy tactic: " + _enemy_name));

draw_set_font(title_font);

text_x = title_x;
text_y = title_y + string_height(title_string) + GUI_BOUND;

text_width = page_w - portrait_x_offset - GUI_BOUND * 2 - 4;
last_text_width = text_width + circle_asset_offset - circle_asset_R + portrait_x_offset - 4;


