precision mediump int;

precision mediump float;

const vec4 zero = vec4(0.0, 0.0, 0.0, 0.0);

varying vec2 v_texCoord;

uniform float maxHint;
uniform float layerAlpha;
uniform sampler2D renderedTexture;
uniform sampler2D gradientTexture;
uniform int u_use_tap_texture;
uniform sampler2D u_tap_texture;

void main(){
	float heatAlpha = texture2D(renderedTexture, v_texCoord).a;

    // if tap texture available, spike intensity based on tap alpha channel
    if (u_use_tap_texture != 0) {
        float tapAlpha = texture2D(u_tap_texture, v_texCoord).a;
        heatAlpha = clamp(heatAlpha * (1.0 + tapAlpha * 0.2), 0.0, 1.0);
    }

    gl_FragColor = texture2D(gradientTexture, vec2(heatAlpha, 0.5)) * heatAlpha * layerAlpha;

}
