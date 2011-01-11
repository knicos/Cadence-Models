// Texture to blur
uniform sampler2D tex;

// Texture size
uniform float dx, dy;

void main()
{
	//float dx = 1.0 / w;
	//float dy = 1.0 / h;
	vec2 st = gl_TexCoord[0].st;

	vec3 color =	0.3989 * texture2D(tex, st).rgb;
	color +=		0.2419 * texture2D(tex, st+vec2(+dx,+dy)).rgb;
	color +=		0.2419 * texture2D(tex, st+vec2(-dx,-dy)).rgb;
	color +=		0.0539 * texture2D(tex, st+vec2(+dx * 2.0,+dy * 2.0)).rgb;
	color +=		0.0539 * texture2D(tex, st+vec2(-dx * 2.0,-dy * 2.0)).rgb;
	color +=		0.0004 * texture2D(tex, st+vec2(+dx * 3.0,+dy * 3.0)).rgb;
	color +=		0.0004 * texture2D(tex, st+vec2(-dx * 3.0,-dy * 3.0)).rgb;

	// Apply 3x3 gaussian filter
	/*vec3 color	 = 4.0 * texture2D(tex, st).rgb;
	color		+= 2.0 * texture2D(tex, st + vec2(+dx, 0.0)).rgb;
	color		+= 2.0 * texture2D(tex, st + vec2(-dx, 0.0)).rgb;
	color		+= 2.0 * texture2D(tex, st + vec2(0.0, +dy)).rgb;
	color		+= 2.0 * texture2D(tex, st + vec2(0.0, -dy)).rgb;
	color		+= texture2D(tex, st + vec2(+dx, +dy)).rgb;
	color		+= texture2D(tex, st + vec2(-dx, +dy)).rgb;
	color		+= texture2D(tex, st + vec2(-dx, -dy)).rgb;
	color		+= texture2D(tex, st + vec2(+dx, -dy)).rgb;*/

	gl_FragColor = vec4(color / 0.9913, 1.0);
}