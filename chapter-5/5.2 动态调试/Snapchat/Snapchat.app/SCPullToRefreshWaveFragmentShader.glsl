//
//  SCPullToRefreshWaveFragmentShader.glsl
//  Snapchat
//
//  Created by Jesse Chand on 12/1/16.
//  Copyright © 2016 Snapchat, Inc. All rights reserved.
//

// This fragment shader is used for the Refresh State of the Pull-To-Refresh background.

precision lowp float;

varying lowp vec2 TexCoordOut;     // The UV coordinates of our primary texture (second render pass).

uniform sampler2D TextureFBO;      // The RGB data of our frame buffer object's texture (first render pass).
uniform sampler2D Texture;         // The RGB data of our primary texture (second render pass).
uniform lowp vec3 ColorBlend;      // The RGB color value we apply to our TextureFBO via a Color blend mode.

uniform float ShouldColorBlend;    // This value is 1 if we should apply a color blend.
uniform float Amplitude;           // The amplitude of the wave.

const float WaveVerticalShift = 1.70;
const float PI = 3.1415926535;

#define ApplyColorDodgeBlendMode(blend, base) ((blend == 1.0) ? blend : min(base / (1.0 - blend), 1.0))

// The next four functions are used to replicate the proprietary 'Color' Photoshop blend mode.
// See the following documentation for implementation details:
// http://wwwimages.adobe.com/content/dam/Adobe/en/devnet/pdf/pdfs/pdf_reference_archives/blend_modes.pdf

float Lum(vec3 c)
{
    vec3 f = vec3(0.3, 0.59, 0.11);
    return dot(c, f);
}

vec3 ClipColor(vec3 C)
{
    float L = Lum(C);
    float n = min(C.r, min(C.g, C.b));
    float x = max(C.r, max(C.g, C.b));
    
    if (n < 0.0) {
        C = L + (((C - L) * L) / (L - n));
    }
    if (x > 1.0) {
        C = L + (((C - L) * (1.0 - L)) / (x - L));
    }
    
    return C;
}

vec3 SetLum(vec3 C, float l)
{
    float d = l - Lum(C);
    return ClipColor(C + d);
}

vec3 ApplyColorBlendMode(vec3 Cb, vec3 Cs)
{
    return SetLum(Cs, Lum(Cb));
}

void main(void)
{
    // Gray gradient texture: we warp the UVs here to create an animated wave.
    vec4 textureColor = texture2D(Texture, vec2(TexCoordOut.x, TexCoordOut.y + cos(TexCoordOut.x * PI * 2.0) * Amplitude - Amplitude * WaveVerticalShift));
    
    // Color gradient texture: we mirror the left half on to the right.
    float mirroredX = (TexCoordOut.x > 0.5 ? (1.0 - (1.0 - TexCoordOut.x)) : (1.0 - TexCoordOut.x));
    vec4 textureFBOColor = texture2D(TextureFBO, vec2(mirroredX, TexCoordOut.y));
    
    float r = ApplyColorDodgeBlendMode(textureColor.r, textureFBOColor.r);
    float g = ApplyColorDodgeBlendMode(textureColor.g, textureFBOColor.g);
    float b = ApplyColorDodgeBlendMode(textureColor.b, textureFBOColor.b);
    
    // Apply color blend if necessary:
    vec3 colorBlend = ApplyColorBlendMode(vec3(r, g, b), ColorBlend);
    gl_FragColor = (vec4(r, g, b, 1.0) * (1.0 - ShouldColorBlend)) + (vec4(colorBlend.r, colorBlend.g, colorBlend.b, 1.0) * ShouldColorBlend);
}

