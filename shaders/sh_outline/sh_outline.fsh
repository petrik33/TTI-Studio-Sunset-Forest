//
// Simple passthrough fragment shader
//
//varying vec2 v_vTexcoord;
//varying vec4 v_vColour;
//uniform float pixelW;
//uniform float pixelH;
//uniform vec3 outline_colour;

//void main()
//{
//	vec2 offsetx;
//	offsetx.x = pixelW;
//	vec2 offsety;
//	offsety.y = pixelH;
	
//	float alpha = texture2D(gm_BaseTexture,v_vTexcoord).a;
//	float old_alpha = alpha;
	
//	alpha += ceil(texture2D(gm_BaseTexture,v_vTexcoord + offsetx).a);
//	alpha += ceil(texture2D(gm_BaseTexture,v_vTexcoord - offsetx).a);
//	alpha += ceil(texture2D(gm_BaseTexture,v_vTexcoord + offsety).a);
//	alpha += ceil(texture2D(gm_BaseTexture,v_vTexcoord - offsety).a);
	
//	gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord);
//	gl_FragColor.a = alpha;	
	
//	if(old_alpha == 0.0 && alpha > old_alpha)
//	{
//		gl_FragColor.rgb += outline_colour;
		
//	}
	
//}
//
// Outline shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float pixelWidth;
uniform float pixelHeight;
void main()
{
  // Compute the textel offsets
  vec2 offsetX;
  offsetX.x = pixelWidth;
  vec2 offsetY;
  offsetY.y = pixelHeight;
  float originAlpha = sign(texture2D(gm_BaseTexture, v_vTexcoord).a);
  float alpha = originAlpha;
  // Combine the alpha from all surrounding textels.
  alpha += ceil(texture2D(gm_BaseTexture, v_vTexcoord + offsetX).a);
  alpha += ceil(texture2D(gm_BaseTexture, v_vTexcoord - offsetX).a);
  alpha += ceil(texture2D(gm_BaseTexture, v_vTexcoord + offsetY).a);
  alpha += ceil(texture2D(gm_BaseTexture, v_vTexcoord - offsetY).a);
  //alpha *= 1;
  // Only blend with the image_blend factor if the original alpha was 0.
  // That means the image_blend parameter is the outline color.
  gl_FragColor = (v_vColour * (1.0 - originAlpha)) +
                 texture2D(gm_BaseTexture, v_vTexcoord);
  // Use the computed alpha
  gl_FragColor.a = alpha * 0.5;
}
