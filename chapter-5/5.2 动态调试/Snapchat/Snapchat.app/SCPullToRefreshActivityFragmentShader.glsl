//
//  SCPullToRefreshActivityFragmentShader.glsl
//  Snapchat
//
//  Created by Jesse Chand on 12/1/16.
//  Copyright © 2016 Snapchat, Inc. All rights reserved.
//

// This fragment shader is used for the Activity State of the Pull-To-Refresh background.

// To achieve this effect, we take two render passes:
// 1. The first pass is the animated blue gradient. We store this data using a frame buffer object texture and pass it via 'TextureFBO'.
// 2. The second pass is the grayscale static gradient. We pass this data via 'Texture'.
// Finally, we apply a color dodge blend mode on the two textures.

precision lowp float;

varying lowp vec2 TexCoordOut;     // The UV coordinates of our primary texture (second render pass).

uniform sampler2D TextureFBO;      // The RGB data of our frame buffer object's texture (first render pass).
uniform sampler2D Texture;         // The RGB data of our primary texture (second render pass).

#define ApplyColorDodgeBlendMode(blend, base) ((blend == 1.0) ? blend : min(base / (1.0 - blend), 1.0))

void main(void)
{
    // Render pass one: blue gradient.
    vec4 textureFBOColor = texture2D(TextureFBO, TexCoordOut);
    
    // Render pass two: grayscale gradient.
    vec4 textureColor = texture2D(Texture, TexCoordOut);
    
    // Apply blend mode:
    float r = ApplyColorDodgeBlendMode(textureColor.r, textureFBOColor.r);
    float g = ApplyColorDodgeBlendMode(textureColor.g, textureFBOColor.g);
    float b = ApplyColorDodgeBlendMode(textureColor.b, textureFBOColor.b);
    gl_FragColor = vec4(r, g, b, 1.0);
}


