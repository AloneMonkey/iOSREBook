precision mediump int;

precision mediump float;

const vec4 zero = vec4(0.0, 0.0, 0.0, 0.0);

/* Texture Coordinates */
varying vec2 v_texCoord;

/* Intensity Factor to use */
uniform float u_intensity;

/* Alpha Mask to render the icon texture. */
uniform sampler2D u_alphaMask;

void main() {
    float a = texture2D(u_alphaMask, v_texCoord).a;
    gl_FragColor = a > 0.0 ? vec4(0.0, 0.0, 0.0, a * u_intensity) : zero;
}