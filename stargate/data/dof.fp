// Texture to dof
uniform sampler2D tex;
//depth texture
uniform sampler2D dtex;

uniform sampler2D btex;

void main()
{
	//float dx = 1.0 / w;
	//float dy = 1.0 / h;
	vec2 st = gl_TexCoord[0].st;

	// Apply 3x3 gaussian filter
	vec3 bcolor = texture2D(btex, st).rgb;
	//bcolor +=		0.2419 * texture2D(btex, st+vec2(+dx,+dy)).rgb;
	//bcolor +=		0.2419 * texture2D(btex, st+vec2(-dx,-dy)).rgb;
	//bcolor +=		0.0539 * texture2D(btex, st+vec2(+dx * 2.0,+dy * 2.0)).rgb;
	//bcolor +=		0.0539 * texture2D(btex, st+vec2(-dx * 2.0,-dy * 2.0)).rgb;
	//bcolor +=		0.0004 * texture2D(btex, st+vec2(+dx * 3.0,+dy * 3.0)).rgb;
	//bcolor +=		0.0004 * texture2D(btex, st+vec2(-dx * 3.0,-dy * 3.0)).rgb;
	
	//bcolor = bcolor / 0.9913;

	vec3 ncolor = texture2D(tex,st).rgb;
	float depth = texture2D(dtex,st).r;
	depth = smoothstep(0.7, 0.85, depth);

	vec3 color = (ncolor * (1.0 - depth)) + (bcolor * depth);

	gl_FragColor = vec4(color, 1.0);
}