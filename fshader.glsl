#version 120

// Light color
uniform vec4 lightColor;

// Diffuse reflection color
uniform vec4 diffuseColor;
uniform vec4 specColor;
uniform int specExp;

// Vectors "attached" to vertex and get sent to fragment shader
varying vec3 lPos;
varying vec3 vPos;
varying vec3 vNorm;

//Specular shading implemented by Stephen Yingling
void main()
{        
    // calculate your vectors
    vec3 L = normalize (lPos - vPos);
    vec3 N = normalize (vNorm);

    //Vectors for Specular Shading
    vec3 R = normalize (reflect(L,N));
    vec3 V = normalize (vPos);
    
     // calculate components
    vec4 diffuse = lightColor * diffuseColor * (dot(N, L));

    float rv = dot(R,V);

    //Negative values cause an ugly green
    if(rv < 0){
        rv =0;
    }
    vec4 specular = lightColor* specColor * pow(rv,specExp);

    // set the final color
    gl_FragColor = diffuse + specular;
}
