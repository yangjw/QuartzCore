//
//  CATransform3DVC.m
//  QuartzCore
//
//  Created by njdby on 16/4/21.
//  Copyright © 2016年 njdby. All rights reserved.
//

#import "CATransform3DVC.h"

@interface CATransform3DVC ()
{
      UIImageView *img;
}
@end

@implementation CATransform3DVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    img = [[UIImageView alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:img];
    img.image = [UIImage imageNamed:@"img_index"];
    [self caTransform3DCreate];
}

/*
 struct CATransform3D
 {
 CGFloat m11(x缩放), m12(y切变), m13(旋转), m14;
 CGFloat m21(x切变), m22(y缩放), m23, m24;
 CGFloat m31(旋转), m32, m33, m34(透视效果，要操作的对象要有旋转的角度，不然没效果);
 CGFloat m41(x平移), m42(y平移), m43(z平移), m44;
 };
 */
-(void)caTransform3DCreate
{
    
    
//    CATransform3D perspective = CATransform3DIdentity;
//    
//    perspective.m34 = - 1.0 / 500.0;
//    
//    self.view.layer.sublayerTransform = perspective;
    
//    3D,顾名思义就是可以在z轴上动作，这里列举三个用例
    
    //用例1 scale
    CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D transform = CATransform3DMakeScale(0.5, 0.5, 1.0);  //x,y,z放大缩小倍数
    NSValue *value = [NSValue valueWithCATransform3D:transform];
    [theAnimation setToValue:value];
    
    transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
    value = [NSValue valueWithCATransform3D:transform];
    [theAnimation setFromValue:value];
    
  
    
    
    //用例2 rotate
//    ......
    CATransform3D transform1 = CATransform3DMakeRotation(1.57, 1, 1, 0); //1.57表示所转角度的弧度 = 90Pi/180 = 90*3.14/180
    NSValue *value1 = [NSValue valueWithCATransform3D:transform];
    [theAnimation setToValue:value1];
    
    transform = CATransform3DMakeRotation(0, 1, 1, 0);
    value = [NSValue valueWithCATransform3D:transform1];
    [theAnimation setFromValue:value];
    
    [theAnimation setAutoreverses:YES];  //原路返回的动画一遍
    [theAnimation setDuration:1.0];
    [theAnimation setRepeatCount:2];
    
    [img.layer addAnimation:theAnimation forKey:nil];
//    ......
    
    //用例3 scale+rotate+position
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D rotateTransform = CATransform3DMakeRotation(1.57, 0, 0, -1);
    CATransform3D scaleTransform = CATransform3DMakeScale(5, 5, 5);
    CATransform3D positionTransform = CATransform3DMakeTranslation(0, 0, 0); //位置移动
    
    CATransform3D combinedTransform =CATransform3DConcat(rotateTransform, scaleTransform); //Concat就是combine的意思
    combinedTransform = CATransform3DConcat(combinedTransform, positionTransform); //再combine一次把三个动作连起来
    
    [anim setFromValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]]; //放在3D坐标系中最正的位置
    [anim setToValue:[NSValue valueWithCATransform3D:combinedTransform]];
    [anim setDuration:5.0f];
    
    [img.layer addAnimation:anim forKey:nil];
    
    [img.layer setTransform:combinedTransform];  //如果没有这句，layer执行完动画又会返回最初的state
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




@end
