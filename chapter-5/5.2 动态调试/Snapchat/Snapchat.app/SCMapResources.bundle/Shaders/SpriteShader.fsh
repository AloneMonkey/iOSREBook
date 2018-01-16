precision mediump int;
precision mediump float;

varying vec2 v_texCoord;

uniform sampler2D u_sprite_texture;
uniform float u_alpha;

void main(){
    gl_FragColor = texture2D(u_sprite_texture, v_texCoord) * u_alpha;
}
