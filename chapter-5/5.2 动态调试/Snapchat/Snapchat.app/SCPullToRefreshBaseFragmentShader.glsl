//
//  SCPullToRefreshBaseFragmentShader.glsl
//  Snapchat
//
//  Created by Jesse Chand on 12/1/16.
//  Copyright © 2016 Snapchat, Inc. All rights reserved.
//

// This is a standard, bare-minimum fragment shader.

precision lowp float;

varying lowp vec2 TexCoordOut;
uniform sampler2D Texture;

void main(void)
{
    gl_FragColor = texture2D(Texture, TexCoordOut);
}
