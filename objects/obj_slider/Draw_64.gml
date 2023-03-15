draw_set_color(dark_color);
draw_rectangle(x,y,x+width,y+height,0);

var progress = (current_value - value_min) / (value_max - value_min)

draw_set_color(light_color);
draw_circle(x + progress * width,y + height/2,circle_radius,0);

var text_color = c_white;
DrawSetText(text_color,fa_middle,fa_left,Font(fn_percents));
var stringgy = value_name + ": " + string(current_value);
draw_text(x+width + 4,y+(height/2),stringgy);

draw_set_color(c_white);