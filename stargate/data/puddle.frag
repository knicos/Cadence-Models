
/*
	We need a noisy gradient texture for the destabalisation thingy
	and a cool ripply effect for the puddle
	Maybe use something completely separate for the kwoosh effect
	as it did look seperate in the film
*/


varying	vec3 g_lightVec;
varying	vec3 g_viewVec;

//Time - for ripple effect and fade out
uniform float time;
uniform float hole;
uniform sampler2D world;
uniform float sd;
uniform float bright;

const vec3 unitX = vec3(1.0, 0.0, 0.0);
const vec3 unitY = vec3(0.0, 1.0, 0.0);

void main()
{   
	const float invRadius = 0.01;

	float distSqr = dot(g_lightVec, g_lightVec);
	
	float d = distance(vec2(0.5, 0.5), gl_TexCoord[0].xy);
	float att = bright / (sd * 2.5) * exp(-(d * d)/(sd*sd));
	
	
	//vec3 lVec = g_lightVec * inversesqrt(distSqr);
	vec3 lVec = vec3(0.25, 0.1, 0.3) * inversesqrt(distSqr);
	

	vec3 vVec = normalize(g_viewVec);
	
	vec4 base = vec4(0.3, 0.5, 0.8, 1.0);
	
	float d1 = -length(gl_TexCoord[0].xy - vec2(0.5, 0.5));
	float d2 = -length(gl_TexCoord[0].xy - vec2(0.0, 0.5)) * 0.7;
	float d3 = length(gl_TexCoord[0].xy - vec2(1.0, 0.2));
	
	const float s = 120.0;
	float v1 = sin(time + d1 * s) + sin(time + d2 * s) + sin(time + d3 * s);
	
	vec3 bump  = normalize(vec3(v1, v1, 8.0));
	vec3 bump2 = normalize(vec3(v1, v1, 200.0));
	
	vec4 vAmbient = gl_LightSource[0].ambient * vec4(0.0, 0.0, 0.25, 1.0);

	float diffuse = max( dot(lVec, bump), 0.0 );
	
	vec4 vDiffuse = gl_LightSource[0].diffuse * diffuse;	

	float specular = pow(clamp(dot(reflect(-lVec, bump), vVec), 0.0, 1.0), 20.0 );
	
	vec4 vSpecular =  vec4(0.0, 0.75, 0.75, 1.0) * specular;	
	
	float k = pow(d - (hole-d), 3.0);
	if(bump.x < -k || bump.x > k) discard;
	
	
	vec3 rfl = normalize(reflect(g_viewVec, bump2));
	
	//generate coordinates
    vec2 index;
    index.y = -dot(rfl, unitY) * 0.5 + 0.5;
    rfl.y = 0.0;
    index.x = -dot(rfl, unitX) * 0.5 + 0.5;	
	
	//sample texture
	vec4 tex = vec4((texture2D(world, index) ).xyz, 1.0);
	
	gl_FragColor = vec4(((vAmbient*base + tex + vDiffuse*base + vSpecular) * att).xyz , 1.0);

}

