uniform sampler2D colorMap;
uniform float intensity;

varying vec2 coord;

#ifdef VERTEX_SHADER

void main(void)
{
    coord = vec2(0.5 * atbCoord + 0.5);
    gl_Position = vec4(atbCoord, 0.0, 1.0);
}

#endif

#ifdef FRAGMENT_SHADER

void main()
{	
	vec3 orgColor = texture2D(uniImage, coord).rgb;
	vec3 resColor = orgColor;

    resColor.r = texture2D(colorMap, vec2(resColor.r, 0.5)).r;
    resColor.g = texture2D(colorMap, vec2(resColor.g, 0.5)).g;
    resColor.b = texture2D(colorMap, vec2(resColor.b, 0.5)).b;
    resColor = mix(orgColor, resColor, intensity);
    
	gl_FragColor = vec4(resColor, 1.0);
}

#endif