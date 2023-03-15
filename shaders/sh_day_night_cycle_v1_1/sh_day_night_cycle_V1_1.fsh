//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 col;
uniform float con_sat_brt[5];

uniform sampler2D lights;

#define contrast con_sat_brt[0]
#define saturation con_sat_brt[1]
#define brightness con_sat_brt[2]
#define pop_strength con_sat_brt[3]
#define pop_threshold con_sat_brt[4]

void main()
{
	vec3 base_col = texture2D( gm_BaseTexture, v_vTexcoord).rgb;
	
	float grey = dot(base_col,vec3(0.299,0.587,0.114));
	
	//overlay
	vec3 out_col = grey > 0.5 ? 1.0 - (1.0 - 2.0 * (base_col - 0.5)) * (1.0 - col) : 2.0 * base_col * col;
	
	//add saturation
	out_col = mix(vec3(grey),out_col,saturation);
	
	//add contrast
	out_col = (out_col - 0.5) * contrast + 0.5;
	
	//pop lights
	out_col = out_col + pop_strength * max(grey - pop_threshold,0.0);
	
	//add brightness
	out_col = out_col + brightness;
	
	//handle lights
	vec3 lights_col = texture2D(lights, v_vTexcoord).rgb;
	grey = dot(lights_col,vec3(0.333));
	out_col = mix(out_col, base_col * normalize(lights_col + 0.05) * 3.0, grey);
	
	out_col += 0.1 * lights_col; //Optional
	
    gl_FragColor = vec4(out_col,1.0);
}
