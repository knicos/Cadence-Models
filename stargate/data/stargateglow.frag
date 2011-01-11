uniform int chevron;

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
	vec3 ct = vec3(1.0, 1.0, 1.0);
	float pos = gl_TexCoord[0].x * 10.0;
	if(base.r > 0.5 && base.b < 0.3){
		bool lit = true;
		
		//have to do this as bitwise operations are not in shader model 2
		float c = floor(float(chevron)) / 2.0;
		if(fract(c) != 0.0 && pos > 8.0)	lit=false;
		
		c = floor(c) / 2.0;
		if(fract(c) != 0.0 && pos > 7.0 && pos < 8.0)	lit=false;
		
		c = floor(c) / 2.0;
		if(fract(c) != 0.0 && pos > 6.0 && pos < 7.0)	lit=false;
		
		c = floor(c) / 2.0;
		if(fract(c) != 0.0 && pos > 5.0 && pos < 6.0)	lit=false;
		
		c = floor(c) / 2.0;
		if(fract(c) != 0.0 && pos > 4.0 && pos < 5.0)	lit=false;
		
		c = floor(c) / 2.0;
		if(fract(c) != 0.0 && pos > 3.0 && pos < 4.0)	lit=false;
		
		c = floor(c) / 2.0;
		if(fract(c) != 0.0 && pos > 2.0 && pos < 3.0)	lit=false;
		
		c = floor(c) / 2.0;
		if(fract(c) != 0.0 && pos > 1.0 && pos < 2.0)	lit=false;
		
		c = floor(c) / 2.0;
		if(fract(c) != 0.0 && pos < 1.0)	lit=false;
		
		
		if(lit==true){
			ct = ct * 0.5;
		} else {
			ct = ct * 3.0;
		}
	}
	
	
	vec3 bump = normalize( texture2D(normalMap, gl_TexCoord[0].st).xyz * 2.0 - 1.0);

	vec4 vAmbient = gl_LightSource[0].ambient * gl_FrontMaterial.ambient;

	float diffuse = max( dot(lVec, bump), 0.0 );
	
	vec4 vDiffuse = gl_LightSource[0].diffuse * gl_FrontMaterial.diffuse * diffuse;	

	float specular = pow(clamp(dot(reflect(-lVec, bump), vVec), 0.0, 1.0), gl_FrontMaterial.shininess );
	
	vec4 vSpecular = gl_LightSource[0].specular * gl_FrontMaterial.specular * specular;	

	gl_FragColor = vec4(( (vAmbient*base + vDiffuse*base + vSpecular) * att).rgb * ct, 1.0);
	
}
