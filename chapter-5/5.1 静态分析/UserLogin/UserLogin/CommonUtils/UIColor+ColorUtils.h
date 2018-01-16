//
//  UIColor+ColorUtils.h
//  CycriptDemo
//
//  Created by AloneMonkey on 16/10/18.
//  Copyright © 2016年 Coder. All rights reserved.
//

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wauto-import"
#pragma GCC diagnostic ignored "-Wobjc-missing-property-synthesis"


#import <UIKit/UIKit.h>


@interface UIColor (ColorUtils)

@property (nonatomic, readonly) CGFloat red;
@property (nonatomic, readonly) CGFloat green;
@property (nonatomic, readonly) CGFloat blue;
@property (nonatomic, readonly) CGFloat alpha;

+ (instancetype)randomRGBColor;
+ (instancetype)randomRGBAColor;

+ (instancetype)colorWithString:(NSString *)string;
+ (instancetype)colorWithRGBValue:(uint32_t)rgb;
+ (instancetype)colorWithRGBValue:(uint32_t)rgb alpha:(CGFloat)alpha;
+ (instancetype)colorWithRGBAValue:(uint32_t)rgba;
- (instancetype)initWithString:(NSString *)string;
- (instancetype)initWithRGBValue:(uint32_t)rgb;
- (instancetype)initWithRGBAValue:(uint32_t)rgba;

- (uint32_t)RGBValue;
- (uint32_t)RGBAValue;
- (NSString *)stringValue;

- (BOOL)isMonochromeOrRGB;
- (BOOL)isEquivalent:(id)object;
- (BOOL)isEquivalentToColor:(UIColor *)color;

- (instancetype)colorWithBrightness:(CGFloat)brightness;
- (instancetype)colorBlendedWithColor:(UIColor *)color factor:(CGFloat)factor;

@end


#pragma GCC diagnostic pop
