precision highp int;

precision highp float;

attribute vec2 a_pos;

varying vec2 v_coord;

uniform vec2 u_scale;
uniform vec2 u_translate;

void main() {
    gl_Position = vec4(a_pos * u_scale + u_translate, 0, 1);
    v_coord = a_pos;
}
