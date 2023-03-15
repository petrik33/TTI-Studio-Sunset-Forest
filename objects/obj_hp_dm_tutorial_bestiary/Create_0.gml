// Inherit the parent event
event_inherited();

column_width = (page_w - bestiary_border_w * 2 - GUI_BOUND * 2)/2;

HP_asset_width = sprite_get_width(spr_hp_fragment_alternative);
HP_assets_num = sprite_get_number(spr_hp_fragment_alternative);
HP_assets_gap = 10;
HP_asset_xoffset = sprite_get_xoffset(spr_hp_fragment_alternative);
var _hp_assets_width = (HP_asset_width + HP_assets_gap) * HP_assets_num - HP_assets_gap;

HP_column_x = x + GUI_BOUND/2 + bestiary_border_w;
HP_assets_y = y + bestiary_border_w + GUI_BOUND + sprite_get_height(spr_hp_fragment_alternative);
HP_assets_x = HP_column_x + (column_width - _hp_assets_width)/2;

HP_text = Text("tutorial bestiary: hp");
HP_text_y = HP_assets_y + GUI_BOUND/2;
HP_text_x = HP_column_x + column_width/2;

DM_column_x = HP_column_x + column_width + GUI_BOUND;

DM_bar_x = DM_column_x + GUI_BOUND/2;
DM_bar_y = y + bestiary_border_w + GUI_BOUND;

DM_bar_width = (column_width - GUI_BOUND) * 0.5;
DM_bar_width += DM_bar_width mod 3;
DM_bar_height = sprite_get_height(spr_dark_matter_bar);

DM_gap_bar_assets = 15;
var _space_left = (column_width - GUI_BOUND / 2) - DM_bar_width - DM_gap_bar_assets;

DM_asset_width = sprite_get_width(spr_dark_matter_particle);
DM_asset_xoffset = sprite_get_xoffset(spr_dark_matter_particle);
DM_assets_x = DM_bar_x + DM_bar_width + DM_gap_bar_assets;
DM_assets_y = DM_bar_y + DM_bar_height/2;
DM_assets_gap = 5;
DM_assets_num = floor((_space_left + DM_assets_gap) / (DM_asset_width + DM_assets_gap));

DM_text = Text("tutorial bestiary: dark matter");
DM_text_x = DM_column_x + column_width/2;
//DM_text_y = DM_bar_y + DM_bar_height + GUI_BOUND/2;
DM_text_y = HP_text_y;