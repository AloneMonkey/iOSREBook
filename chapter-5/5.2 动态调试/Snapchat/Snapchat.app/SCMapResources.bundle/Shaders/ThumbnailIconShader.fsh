#ifdef GL_OES_standard_derivatives
#   extension GL_OES_standard_derivatives : enable
#endif

precision mediump int;
precision mediump float;

varying vec2 v_unitCoord;
varying vec2 v_thumbCoord;

uniform sampler2D u_thumbnail_texture;
uniform sampler2D u_label_texture;
uniform float u_alpha;
uniform int u_shape_type;
uniform float u_border_scale;
uniform int u_should_draw_label; // 0 or 1
uniform int u_should_draw_thumbnail; // 0 or 1
uniform float u_loading_radians;
uniform float u_loading_spinner_alpha;

// label cut away uniforms
uniform vec2 u_circle_stretch;
uniform vec2 u_circle_translate;

// shape constants shared with host program
uniform float u_outer_circle_radius;
uniform float u_border_width;

// colors
const vec4 dropShadowColor = vec4(0.0, 0.0, 0.0, 1.0);
const vec4 white = vec4(1.0, 1.0, 1.0, 1.0);
const vec4 black = vec4(0.0, 0.0, 0.0, 1.0);
const vec4 clear = vec4(0.0, 0.0, 0.0, 0.0);
const vec4 lightRed = vec4(1.0, 0.8, 0.8, 1.0);
const vec4 purple = vec4(0.933, 0.5, 0.933, 1.0);
const vec4 innerCircleGray = vec4(0.88, 0.88, 0.88, 0.95);

// rect constants
const float stretch_gaussian = 3.0; // into the -1 to 1 space

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

float inv_smoothstep(float a, float b, float d) {
    return 1.0 - smoothstep(a, b, d);
}

float unit_circle_drop_shadow_alpha(float dist) {
    return clamp((exp(-dist * dist / 0.32) - 0.044) * 3.0, 0.0, 1.0);
}

vec4 color_for_circle(float scaled_border_width) {
    vec2 coord = v_unitCoord * 2.0 - 1.0;

    float dist = distance(coord, vec2(0.0, 0.0));
    float delta = f_delta(dist);
    float inner_circle = u_outer_circle_radius - scaled_border_width;

    float thumbAlpha = inv_smoothstep(inner_circle - delta, inner_circle, dist);
    vec4 thumbColor = texture2D(u_thumbnail_texture, v_thumbCoord) * thumbAlpha * float(u_should_draw_thumbnail);

    float backingAlpha = inv_smoothstep(u_outer_circle_radius - delta, u_outer_circle_radius, dist);

    vec2 radarCoord = vec2(cos(2.0 * 3.14159 - u_loading_radians), sin(2.0 * 3.14159 - u_loading_radians));
    float dotPrd = radarCoord.x * coord.x + radarCoord.y * coord.y;
    float det = coord.x * radarCoord.y - coord.y * radarCoord.x;
    float angle = atan(det, dotPrd);
    float angleAlpha = (angle + 3.14159) / 2.0 / 3.14159;
    float loadingAlpha = clamp((backingAlpha * angleAlpha * u_loading_spinner_alpha) - thumbAlpha, 0.0, 1.0);
    vec4 loadingColor = purple * loadingAlpha;

    vec4 outerRingColor = white * clamp(backingAlpha - thumbAlpha, 0.0, 1.0);
    vec4 innerBackingColor = innerCircleGray * backingAlpha;
    vec4 backingColor = mix_colors(loadingColor, mix_colors(outerRingColor, innerBackingColor));

    float dropShadowAlpha = clamp(unit_circle_drop_shadow_alpha(dist) - thumbAlpha, 0.0, 1.0);

    vec4 iconColor = mix_colors(thumbColor, backingColor);
    return mix_colors(iconColor, dropShadowColor * dropShadowAlpha);
}

vec4 color_for_label() {
    vec2 coord = v_unitCoord * 2.0 - 1.0;
    vec4 color = texture2D(u_label_texture, v_unitCoord);

    // find the cut-away for the circle shape
    vec2 circleCenter = vec2(0.0, 0.0);

    float distFromCircle = distance(circleCenter, vec2((coord.x - u_circle_translate.x) * u_circle_stretch.x, (coord.y - u_circle_translate.y) * u_circle_stretch.y));
    float delta = f_delta(distFromCircle) * 2.0; // a little extra to avoid a gap

    return color * smoothstep(1.0 - delta, 1.0, distFromCircle);
}

vec4 debug_grid(vec4 color) {
    float width = 0.01;
    if (v_unitCoord.x < width || v_unitCoord.x > 1.0 - width) {
        return color;
    }

    if (v_unitCoord.y < width || v_unitCoord.y > 1.0 - width) {
        return color;
    }

    if (v_unitCoord.x > 0.5-width/2.0 && v_unitCoord.x < 0.5+width/2.0) {
        return color;
    }

    if (v_unitCoord.y > 0.5-width/2.0 && v_unitCoord.y < 0.5+width/2.0) {
        return color;
    }

    return clear;
}

vec4 pre_alpha_color() {
    vec4 labelColor = color_for_label() * float(u_should_draw_label);
    vec4 circleColor = color_for_circle(u_border_scale * u_border_width) * float(1 - u_should_draw_label);
    return mix_colors(labelColor, circleColor);
}

void main() {
    gl_FragColor = pre_alpha_color() * u_alpha;
//    gl_FragColor = mix_colors(debug_grid(lightRed)*0.5, gl_FragColor) * u_alpha;
}
