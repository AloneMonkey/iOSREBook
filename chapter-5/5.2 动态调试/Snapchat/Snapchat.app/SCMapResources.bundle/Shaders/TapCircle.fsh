#ifdef GL_OES_standard_derivatives
#   extension GL_OES_standard_derivatives : enable
#endif

precision mediump int;
precision mediump float;

varying vec2 v_coord;
uniform float u_alpha;
uniform float u_border_scale;

const float border_width = 0.05;
const float base_alpha = 0.8;
const float base_drop_shadow_alpha = 0.5;
const vec4 clear = vec4(0.0, 0.0, 0.0, 0.0);
const vec4 white = vec4(1.0, 1.0, 1.0, 1.0);
const vec4 black = vec4(0.0, 0.0, 0.0, 1.0);

float f_delta(float x) {
#ifdef GL_OES_standard_derivatives
    return fwidth(x);
#else
    return 0.0;
#endif
}

vec4 mix_colors(vec4 src, vec4 dest) {
    return vec4(src.rgb + dest.rgb * (1.0 - src.a), clamp(dest.a + src.a, 0.0, 1.0));
}

float unit_circle_drop_shadow_alpha(float dist) {
    return (exp(-dist * dist / 0.32) - 0.044) * 3.0;
}

void main() {
    float borderWidth = border_width * u_border_scale;
    float circleRadius = 1.0 - borderWidth;

    float dist = sqrt(v_coord.x * v_coord.x + v_coord.y * v_coord.y);
    float delta = f_delta(dist);

    float circleMask = 1.0 - smoothstep(circleRadius - delta, circleRadius, dist);
    float outerAlpha = 1.0;

    vec4 circleColor = white * outerAlpha * circleMask;

    // don't show drop for small circles where it would dominate the size
    float dropShadowAlphaStep = clamp(1.0 - smoothstep(0.1, 0.5, borderWidth) - circleMask, 0.0, 1.0);
    vec4 dropShadowColor = black * unit_circle_drop_shadow_alpha(dist) * dropShadowAlphaStep * base_drop_shadow_alpha;

    gl_FragColor = mix_colors(circleColor, dropShadowColor) * u_alpha * base_alpha;
}
