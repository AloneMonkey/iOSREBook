//
//  SCPullToRefreshBaseVertexShader.glsl
//  Snapchat
//
//  Created by Jesse Chand on 12/1/16.
//  Copyright © 2016 Snapchat, Inc. All rights reserved.
//

// This is a standard, bare-minimum vertex shader.

attribute vec4 Position;
attribute vec2 TexCoordIn;

varying vec2 TexCoordOut;
uniform mat4 ModelView;

void main(void)
{
    gl_Position = ModelView * Position;
    TexCoordOut = TexCoordIn;
}
