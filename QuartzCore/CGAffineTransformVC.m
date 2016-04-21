//
//  CGAffineTransformVC.m
//  QuartzCore
//
//  Created by njdby on 16/4/21.
//  Copyright © 2016年 njdby. All rights reserved.
//

#import "CGAffineTransformVC.h"


CGAffineTransform CGAffineTransformMakeShear(CGFloat x,CGFloat y)
{
        CGAffineTransform transform = CGAffineTransformIdentity;
    
        transform.c= -x;
    
        transform.b= y;
    
        return transform;

}

@interface CGAffineTransformVC()
{
    UIImageView *img;
}
@end

@implementation CGAffineTransformVC
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    img = [[UIImageView alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:img];
    img.image = [UIImage imageNamed:@"img_index"];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"动画" style:UIBarButtonItemStylePlain target:self action:@selector(createAffineTransForm)];
    
    self.navigationItem.rightBarButtonItem = item;
//    [self createAffineTransForm];

}




-(void)createAffineTransForm{
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformRotate(transform, 1.0/3*3.14);
//    transform = CGAffineTransformTranslate(transform, 200, 0);
    
//    img.transform = CGAffineTransformMakeShear(10, 10);
//    移动
//    img.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 200);
    
//    缩放
//    img.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 1);
    
//  快速生成
//    img.transform = CGAffineTransformMakeRotation(3.14);
//    img.transform = CGAffineTransformRotate(CGAffineTransformIdentity,M_PI*180/2);
    
//    img.transform = transform;
    
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    NSValue *value = [NSValue valueWithCGAffineTransform:CGAffineTransformIdentity];
    animation.fromValue = value;
    
    value = [NSValue valueWithCGAffineTransform:transform];
    animation.toValue = value;

    
    animation.duration = 10;
    
    [img.layer addAnimation:animation forKey:nil];
    [img.layer setAffineTransform:transform];
}


@end
