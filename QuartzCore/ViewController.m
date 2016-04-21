//
//  ViewController.m
//  QuartzCore
//
//  Created by njdby on 16/4/20.
//  Copyright © 2016年 njdby. All rights reserved.
//

#import "ViewController.h"
#import "Draw.h"

@interface ViewController ()
{
    double add;
}
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property(nonatomic,strong)NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}



#pragma mark ForExample

- (void)forExample{
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = CGRectMake(0, 0, 200, 200);//设置shapeLayer的尺寸和位置
    self.shapeLayer.position = self.view.center;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    self.shapeLayer.strokeStart = 0.0f;
    self.shapeLayer.strokeEnd = .5f;
    
    self.shapeLayer.lineCap = kCALineCapRound;
    self.shapeLayer.lineJoin = kCALineJoinBevel;
    
    //设置线条的宽度和颜色
    self.shapeLayer.lineWidth = 2.0f;
    self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 200, 200)];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    self.shapeLayer.path = circlePath.CGPath;
    
    
    
    //添加并显示
    //    [self.view.layer addSublayer:self.shapeLayer];
    
    add = 0.1;//每次递增0.1
    //用定时器模拟数值输入的情况
    //    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1
    //                                              target:self
    //                                            selector:@selector(circleAnimationTypeOne)
    //                                            userInfo:nil
    //                                             repeats:YES];
    
    
    //    Draw *d = [[Draw alloc] initWithFrame:CGRectMake(0, 200, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 200)];
    //    [self.view addSubview:d];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, 200)];
    [path addLineToPoint:CGPointMake(200, 200)];
    [path addLineToPoint:CGPointMake(200,0)];
    [path addQuadCurveToPoint:CGPointMake(0, 0) controlPoint:CGPointMake(100, 100)];
    [path closePath];
    
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    //    layer.frame = self.view.frame;
    layer.path = path.CGPath;
    layer.lineWidth = 5;
    layer.strokeStart = 0.0f;
    layer.strokeEnd = 1.0f;
    
    layer.strokeColor = [UIColor orangeColor].CGColor;
    layer.fillColor = [UIColor redColor].CGColor;
    
    
    //    [self.view.layer addSublayer:layer];
    
    CABasicAnimation *animation =
    [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setFromValue:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
    
    
    [animation setToValue:[NSValue valueWithCGPoint:CGPointMake(200, 200)]];
    [animation setDuration:5.0];
    //    [layer setPosition:endpoint];
    //    动画的速度变化
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //   是否进行逆动画，也就是恢复到原位
    animation.autoreverses = YES;
    //    指定动画开始的时间。从开始延迟几秒的话，设置为【CACurrentMediaTime() + 秒数】 的方式
    animation.beginTime = CACurrentMediaTime() + 1;
    //    设置动画的时间。在该时间内动画一直执行，不计次数。
    //    animation.repeatDuration = 2;
    //
    animation.repeatCount = HUGE_VALF;
    animation.delegate = self;
    //    [layer addAnimation:animation forKey:@"Animation"];
    
    
    CAKeyframeAnimation *animationA=[CAKeyframeAnimation animation];
    //设置属性值
    animationA.values=[NSArray arrayWithObjects:
                       (id)self.view.backgroundColor.CGColor,
                       (id)[UIColor yellowColor].CGColor,
                       (id)[UIColor greenColor].CGColor,
                       (id)[UIColor blueColor].CGColor,nil];
    animationA.duration=3;
    animation.repeatCount = HUGE_VALF;
    //    animationA.autoreverses=YES;
    //把关键帧添加到layer中
    [self.view.layer addAnimation:animationA forKey:@"backgroundColor"];
    
    [self animationOfCAKeyframeAnimationPath];
}

- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"开始执行");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{

}

-(void)animationOfCAKeyframeAnimationPath
{
    //初始化一个View，用来显示动画
    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    redView.backgroundColor=[UIColor redColor];
    
    [self.view addSubview:redView];
    
    CAKeyframeAnimation *ani=[CAKeyframeAnimation animation];
//    //初始化路径
//    CGMutablePathRef aPath=CGPathCreateMutable();
//    //动画起始点
//    CGPathMoveToPoint(aPath, nil, 20, 20);
//    CGPathAddCurveToPoint(aPath, nil,
//                          160, 30,//控制点
//                          220, 220,//控制点
//                          240, 380);//控制点

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, 200)];
    [path addLineToPoint:CGPointMake(200, 200)];
    [path addLineToPoint:CGPointMake(200,0)];
    [path addQuadCurveToPoint:CGPointMake(0, 0) controlPoint:CGPointMake(100, 100)];
    
    ani.path=path.CGPath;
    ani.duration=10;
    //设置为渐出
    ani.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    //自动旋转方向
    ani.rotationMode=@"auto";
    
    [redView.layer addAnimation:ani forKey:@"position"];
}

- (void)circleAnimationTypeOne
{
    if (self.shapeLayer.strokeEnd > 1 && self.shapeLayer.strokeStart < 1) {
        self.shapeLayer.strokeStart += add;
    }else if(self.shapeLayer.strokeStart == 0){
        self.shapeLayer.strokeEnd += add;
    }
    
    if (self.shapeLayer.strokeEnd == 0) {
        self.shapeLayer.strokeStart = 0;
    }
    
    if (self.shapeLayer.strokeStart == self.shapeLayer.strokeEnd) {
        self.shapeLayer.strokeEnd = 0;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
