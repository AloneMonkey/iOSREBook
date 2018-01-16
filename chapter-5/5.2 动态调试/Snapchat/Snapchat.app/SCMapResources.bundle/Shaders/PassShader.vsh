precision highp int;

precision highp float;

attribute vec2 a_pos;

varying vec2 v_texCoord;

uniform vec2 u_scale;

void main() {

    v_texCoord = vec2((a_pos.x + 1.0) / 2.0,
                      (a_pos.y + 1.0) / 2.0);

    gl_Position = vec4(a_pos.xy, 0.0, 1.0);
}
