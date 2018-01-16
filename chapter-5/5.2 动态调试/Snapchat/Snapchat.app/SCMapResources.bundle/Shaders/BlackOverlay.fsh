precision highp int;

precision highp float;

uniform float u_alpha;

void main()
{
    gl_FragColor = vec4(0.0, 0.0, 0.0, u_alpha);
}
