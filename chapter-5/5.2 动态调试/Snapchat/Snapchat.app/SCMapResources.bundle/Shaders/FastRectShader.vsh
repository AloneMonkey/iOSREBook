precision highp int;

precision highp float;

attribute vec2 a_pos;

varying vec2 v_texCoord;

uniform vec2 u_scale;

uniform vec2 u_translate;

void main() {
    gl_Position = vec4(a_pos.x * u_scale.x + u_translate.x,
                       a_pos.y * u_scale.y + u_translate.y,
                       0, 1);

    v_texCoord = a_pos;
}

