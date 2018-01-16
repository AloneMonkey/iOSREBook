precision highp int;

precision highp float;

attribute vec2 a_pos;

varying vec2 v_texCoord;

uniform vec2 u_scale;
uniform vec2 u_translate;
uniform vec2 u_anchor_point;

void main() {
    vec2 normalized_anchor = u_anchor_point * 2.0 - 1.0;
    gl_Position = vec4(a_pos * u_scale + u_translate - normalized_anchor * u_scale, 0, 1.0);
    v_texCoord = (a_pos + 1.0) / 2.0;
}
