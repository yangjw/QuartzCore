//
//  Draw.m
//  QuartzCore
//
//  Created by njdby on 16/4/20.
//  Copyright © 2016年 njdby. All rights reserved.
//

#import "Draw.h"

@implementation Draw


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.sideToCenterDelta =0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
    CGFloat yOffset = 30.0;
    CGFloat width   = CGRectGetWidth(rect);
    CGFloat height  = CGRectGetHeight(rect);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.0, yOffset)]; //去设置初始线段的起点
    CGPoint controlPoint = CGPointMake(width / 2, yOffset + self.sideToCenterDelta);
    [path addQuadCurveToPoint:CGPointMake(width, yOffset) controlPoint:controlPoint];
    [path addLineToPoint:CGPointMake(width, height)];
    [path addLineToPoint:CGPointMake(0.0, height)];
    [path closePath];
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path.CGPath);
    [[UIColor redColor] set];
    CGContextFillPath(context);
}
@end
