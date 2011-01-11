//The shader is fine, the problem is that it is not getting the 
//tangent variables from c++, which breaks lightVec and eyeVec.
//so it may be possible for you to get it to work tomorrow...

uniform float position;

attribute vec3 tangent; 

varying vec3 lightVec; 
varying vec3 eyeVec;					 

#define angle 0.64437
#define hangle 0.32219

void main(void)
{
	//gl_Position = ftransform();
	gl_TexCoord[0] = gl_MultiTexCoord0;
	
	
	//test - make tangent something
	//tangent = cross(gl_Normal, vec3(1.0, 0.0, 0.0));
	
	vec3 n = normalize(gl_NormalMatrix * gl_Normal);
	vec3 t = normalize(gl_NormalMatrix * tangent);
	vec3 b = cross(n, t);
	
	vec3 vVertex = vec3(gl_ModelViewMatrix * gl_Vertex);
	vec3 tmpVec = gl_LightSource[0].position.xyz - vVertex;

	lightVec.x = dot(tmpVec, t);
	lightVec.y = dot(tmpVec, b);
	lightVec.z = dot(tmpVec, n);

	tmpVec = -vVertex;
	eyeVec.x = dot(tmpVec, t);
	eyeVec.y = dot(tmpVec, b);
	eyeVec.z = dot(tmpVec, n);

	//Crazy bit to get the chevron to move
	if(gl_MultiTexCoord0.s < 0.4 || gl_MultiTexCoord0.s < 0.5 && gl_MultiTexCoord0.t > 0.5){
	
		//need to get the angle
		float ang = atan(gl_Vertex.y, gl_Vertex.x) - 1.5707;
		if(ang < -3.141592) ang += 6.283185;
		ang = floor((ang + hangle) / angle) * angle;
		vec4 dir = vec4(sin(ang), -cos(ang), 0.0, 0.0);
		
		
		//side bits
		if(gl_MultiTexCoord0.t > 0.5){
			if(gl_MultiTexCoord0.s < 0.225) dir = vec4(dir.y, -dir.x, 0.0, 0.0);
			else dir = vec4(-dir.y, dir.x, 0.0, 0.0);
			if (ang > -hangle) dir = -dir;
		}
		
		vec4 pos = gl_Vertex + dir * position * 0.1;
		gl_Position = gl_ModelViewProjectionMatrix * pos;
	} else {
		gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
	}
}