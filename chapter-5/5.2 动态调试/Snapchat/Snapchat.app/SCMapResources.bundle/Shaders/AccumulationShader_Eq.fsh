precision mediump int;

precision mediump float;

const vec4 zero = vec4(0.0, 0.0, 0.0, 0.0);

/* Texture Coordinates */
varying vec2 v_texCoord;

/* Intensity Factor to use */
uniform float u_intensity;

void main() {
    gl_FragColor = zero;

    float r = v_texCoord.x * v_texCoord.x + v_texCoord.y * v_texCoord.y;

    if (r < 1.0) {
        gl_FragColor.a = ALPHA_MASK_EQUATION * u_intensity;
    }
}