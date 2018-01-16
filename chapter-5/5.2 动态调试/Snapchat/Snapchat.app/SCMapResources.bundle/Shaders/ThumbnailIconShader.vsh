precision highp int;

precision highp float;

attribute vec2 a_pos;

varying vec2 v_unitCoord;
varying vec2 v_thumbCoord;

uniform vec2 u_scale;
uniform vec2 u_translate;
uniform vec2 u_anchor_point;

// for sampling non-square shapes
uniform vec2 u_texture_scale;
uniform vec2 u_texture_translate;

void main() {
    vec2 normalized_anchor = u_anchor_point * 2.0 - 1.0;
    gl_Position = vec4(a_pos * u_scale + u_translate - normalized_anchor * u_scale, 0, 1.0);

    v_unitCoord = (a_pos + 1.0) / 2.0;
    v_thumbCoord = v_unitCoord * u_texture_scale + u_texture_translate;
}

