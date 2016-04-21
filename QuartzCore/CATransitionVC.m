//
//  CATransitionVC.m
//  QuartzCore
//
//  Created by njdby on 16/4/21.
//  Copyright © 2016年 njdby. All rights reserved.
//

#import "CATransitionVC.h"

@interface CATransitionVC ()
{
    UIImageView *img;
}
@end

@implementation CATransitionVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
     img = [[UIImageView alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:img];
    img.image = [UIImage imageNamed:@"img_index"];
    [self addNav];
}

-(void)animationCreate{
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:1.0];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
//    [animation setType:@"rippleEffect"];// rippleEffect
    
    
/*
 kCATransitionFade   交叉淡化过渡
 kCATransitionMoveIn 新视图移到旧视图上面
 kCATransitionPush   新视图把旧视图推出去
 kCATransitionReveal 将旧视图移开,显示下面的新视图
 pageCurl            向上翻一页
 pageUnCurl          向下翻一页
 rippleEffect        滴水效果
 suckEffect          收缩效果，如一块布被抽走
 cube                立方体效果
 oglFlip             上下翻转效果
 
 过渡效果
 fade     //交叉淡化过渡(不支持过渡方向)
 push     //新视图把旧视图推出去
 moveIn   //新视图移到旧视图上面
 reveal   //将旧视图移开,显示下面的新视图
 cube     //立方体翻滚效果
 oglFlip  //上下左右翻转效果
 suckEffect   //收缩效果，如一块布被抽走(不支持过渡方向)
 rippleEffect //滴水效果(不支持过渡方向)
 pageCurl     //向上翻页效果
 pageUnCurl   //向下翻页效果
 cameraIrisHollowOpen  //相机镜头打开效果(不支持过渡方向)
 cameraIrisHollowClose //相机镜头关上效果(不支持过渡方向)
 
    
过渡方向
     fromRight;
     fromLeft;
     fromTop;
     fromBottom;
 */
    [animation setType:@"cameraIrisHollowOpen"];
    
//    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromTop];
    
    CAAnimationGroup *animaGroup = [CAAnimationGroup animation];
    animaGroup.duration = 2.0f;
    animaGroup.fillMode = kCAFillModeForwards;
    animaGroup.removedOnCompletion = NO;
    animaGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animaGroup.animations = @[animation];
    
    
    
    
    
//     [img.layer addAnimation:animation forKey:nil];
    [self creteAnimationGroup];
}


-(void)creteAnimationGroup{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.8;
    animation.fromValue = @(.5);
    animation.toValue = @(1.5);
    animation.autoreverses = YES;
//    animation.repeatCount = CGFLOAT_MAX;
//    animation.repeatCount = 2;
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation3.fromValue = @(0);
    animation3.toValue = @(3*M_PI*2);
//    animation3.toValue = @(100);
    animation3.duration = 0.2;
//    animation3.repeatCount = 2;
    animation3.autoreverses = YES;
    
    CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"bounds"];
    
    animation4.fromValue = [NSValue valueWithCGPoint:img.layer.position]; // 起始帧
    animation4.toValue = [NSValue valueWithCGPoint:CGPointMake(320, 480)]; // 终了帧
    animation4.autoreverses = YES;
    animation4.duration = 0.3;
    
//    多个关键针
    CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation2.values = @[
                          [NSValue valueWithCGPoint:img.layer.position],
                          [NSValue valueWithCGPoint:CGPointMake(img.layer.position.x+200, img.layer.position.y)],
                          [NSValue valueWithCGPoint:CGPointMake(img.layer.position.x+200, img.layer.position.y+300)],
                          [NSValue valueWithCGPoint:CGPointMake(img.layer.position.x,img.layer.position.y+300)],
                          [NSValue valueWithCGPoint:img.layer.position]
                          ];
    animation2.keyTimes = @[
                            @(0),@(0.2),@(0.5),@(0.7),@(1)
                            ];
    animation2.autoreverses = NO;
    
    
    CABasicAnimation *animation5 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation5.fromValue = @(0);
    animation5.toValue = @(0.5);
    
    
    CABasicAnimation*animation6 = (CABasicAnimation*)[self animaton:@"transform.scale" fromValue:@(1.0) toValue:@(0.5)];
    
    
    CAAnimationGroup *aniGroup = [CAAnimationGroup animation];
    aniGroup.duration = 2;
    aniGroup.animations = @[animation6];
    aniGroup.repeatCount = 2;
    aniGroup.autoreverses = YES;
    [img.layer addAnimation:aniGroup forKey:@"grouani"];
}


- (CAAnimation *)animaton:(NSString*)keyPath fromValue:(id)fromValue toValue:(id)toValue {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    return animation;
}

- (void)addNav
{
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
//                                                         forBarMetrics:UIBarMetricsDefault];
//    一直显示返回按钮
    self.navigationItem.leftItemsSupplementBackButton = YES;
//    self.navigationItem.leftBarButtonItem.title = @"返回";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"开启" style:UIBarButtonItemStylePlain target:self action:@selector(showActivityView)];
    self.navigationItem.leftBarButtonItems = @[item];
}




- (void)showActivityView
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Animation" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self animationCreate];
    }];
    
    [alertController addAction:action];
    [alertController addAction:actionCancel];
    
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}



- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
