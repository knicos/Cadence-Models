//The shader is fine, the problem is that it is not getting the 
//tangent variables from c++, which breaks lightVec and eyeVec.
//so it may be possible for you to get it to work tomorrow...

attribute vec3 tangent; 

varying vec3 lightVec; 
varying vec3 eyeVec;					 

void main(void)
{
	gl_Position = ftransform();
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
}