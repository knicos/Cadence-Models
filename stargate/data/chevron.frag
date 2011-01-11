uniform int on;

varying vec3 lightVec;
varying vec3 eyeVec;
uniform sampler2D colourMap;
uniform sampler2D normalMap;


void main() {

	float invRadius = 0.01;
	float distSqr = dot(lightVec, lightVec);
	float att = clamp(1.0 - invRadius * sqrt(distSqr), 0.0, 1.0);
	vec3 lVec = lightVec * inversesqrt(distSqr);
	
	vec3 vVec = normalize(eyeVec);
	
	vec4 base = texture2D(colourMap, gl_TexCoord[0].st);
	
	//Detect chevron lights
	vec3 glow = vec3(0.0, 0.0, 0.0);
	if(base.r > 0.5 && base.b < 0.3){
		if(on!=0) 	glow = base.rgb * 3.0;
		else		glow = base.rgb * -0.5;
	}
	
	vec3 bump = normalize( texture2D(normalMap, gl_TexCoord[0].st).xyz * 2.0 - 1.0);

	vec4 vAmbient = gl_LightSource[0].ambient * gl_FrontMaterial.ambient;

	float diffuse = max( dot(lVec, bump), 0.0 );
	
	vec4 vDiffuse = gl_LightSource[0].diffuse * gl_FrontMaterial.diffuse * diffuse;	

	float specular = pow(clamp(dot(reflect(-lVec, bump), vVec), 0.0, 1.0), gl_FrontMaterial.shininess );
	
	vec4 vSpecular = gl_LightSource[0].specular * gl_FrontMaterial.specular * specular;	

	gl_FragColor = vec4(( (vAmbient*base + vDiffuse*base + vSpecular) * att).rgb + glow, 1.0);
	
}
