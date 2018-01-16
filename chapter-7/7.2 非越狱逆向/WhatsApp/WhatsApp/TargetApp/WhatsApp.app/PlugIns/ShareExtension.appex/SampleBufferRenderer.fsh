uniform sampler2D SamplerY;
uniform sampler2D SamplerUV;

varying highp vec2 texCoordVarying;

void main() {
    mediump vec3 yuv;
    lowp vec3 rgb;

    /*
     I tried a bunch of YUV->RGB transformations but none of them look right when compared to a
     still frame extracted with AVAssetImageGenerator in -[WAMessageHelper imageForMediaAtPath:].

    // BT.709, the HDTV standard.
    mat3(1,        1,       1,
         0,       -0.18732, 1.8556,
         1.57481, -0.46813, 0)


    // PC 601
    mat3(1.164,  1.164,  1.164,
         0,     -0.813,  1.596,
         2.018,  1.596,  0)

    // Rec601
    mat3(1.164,  1.164, 1.164,
         0,      0,     1.371,
         1.732, -0.336, 0)

    // Rec709
    mat3(1.16438,   1.16438,   1.16438,
         0.00000,  -0.18300,   1.81600,
         1.54000,  -0.45900,   0.00000)

    // PC 709
    mat3(1.164,   1.164,   1.164,
         0.000,   0.213,   2.115,
         1.793,   0.534,   0.000);

     What finally worked was taking a video with known YUV values provided by Milan and solving
     a system of equations to find the transformation to the RGB values in the device-dependent RGB
     color space output by imageForMediaAtPath:. This was the "Dima.mp4" file, which has four big
     rectangles of primary-ish colors. I extracted these values from the corners:
     
     Color   Input              AVAssetImageGenerator  Corner
               Y    U    V        R    G    B
     red      96  114  210      210   50   72          top left
     green   127   96   67       59  196   72          top right
     blue     83  184  119       75   77  199          bottom left
     yellow  210   16  146      254  253    0          bottom right

     Using three values, we solve for A:
     
     R = [ 210,  59,  75;
            50, 196,  77;
            72,  72, 199 ] / 255

     Y = [  96-16,  127-16,   83-16,
           114-128,  96-128, 184-128
           210-128,  67-128, 119-128 ] / 255

     A = (R * inverse(Y))'
     
     Note that YUV values are offset by 16 and 128, which is the only reasonable interpretation. I
     tried augmenting the matrix so these offsets could be inferred, but it looked worse. My guess
     is that it's because of rounding errors since the inputs were all integral.
     
     The resulting transformation matrix is:
     1.270334   1.295852   1.249046
     0.032724  -0.288497   2.061001
     1.327212  -0.703746   0.011346
     */
    yuv.x = WA_TEX_Y(texture2D(SamplerY, texCoordVarying)) - 0.0625;
    yuv.yz = WA_TEX_UV(texture2D(SamplerUV, texCoordVarying)) - vec2(0.5, 0.5);
    rgb = mat3(1.270334,  1.295852, 1.249046,
               0.032724, -0.288497, 2.061001,
               1.327212, -0.703746, 0.011346) * yuv.xyz;

    gl_FragColor = vec4(rgb, 1);
}

