//use with normal.frag

uniform float angle;

attribute vec3 tangent; 

varying vec3 lightVec; 
varying vec3 eyeVec;					 

void main(void)
{

	//need rotation matrix about z;
	float s = sin(angle);
	float c = cos(angle);
	vec4 v0 = vec4(c, s, 0.0, 0.0); 
	vec4 v1 = vec4(-s, c, 0.0, 0.0);
	vec4 v2 = vec4(0.0, 0.0, 1.0, 0.0);
	vec4 v3 = vec4(0.0, 0.0, 0.0, 1.0);
	mat4 rotation = mat4(v0, v1, v2, v3);
	gl_Position = gl_ModelViewProjectionMatrix * rotation * gl_Vertex;

	//gl_Position = ftransform();
	gl_TexCoord[0] = gl_MultiTexCoord0;
	
	
	vec4 tnormal = rotation * vec4(gl_Normal, 1.0);
	vec4 ttangent = rotation * vec4(tangent, 1.0);
	
	vec3 n = normalize(gl_NormalMatrix * tnormal.xyz);
	vec3 t = normalize(gl_NormalMatrix * ttangent.xyz);
	vec3 b = cross(n, t);
	
	vec3 vVertex = vec3(gl_ModelViewMatrix * rotation * gl_Vertex);
	vec3 tmpVec = gl_LightSource[0].position.xyz - vVertex;

	lightVec.x = dot(tmpVec, t);
	lightVec.y = dot(tmpVec, b);
	lightVec.z = dot(tmpVec, n);

	tmpVec = -vVertex;
	eyeVec.x = dot(tmpVec, t);
	eyeVec.y = dot(tmpVec, b);
	eyeVec.z = dot(tmpVec, n);
	
}