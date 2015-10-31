//
//  XXBViewController.m
//  2014_10_10_核心动画_3
//
//  Created by Mac10.9 on 14-10-10.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBViewController.h"
#import "RecordingCircleOverlayView.h"
#import "GradientProgressView.h"
#define Angle2Radian(angle) ((angle) / 180.0 * M_PI)
@interface XXBViewController ()
/**
 *  一个需要执行动画的view
 */
@property (weak, nonatomic) IBOutlet UIView *animationView;
@end

@implementation XXBViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    RecordingCircleOverlayView *recordingCircleOverlayView = [[RecordingCircleOverlayView alloc] initWithFrame:CGRectMake(20, 20, 200, 200) strokeWidth:7.f insets:UIEdgeInsetsMake(10.f, 0.f, 10.f, 0.f)];
    recordingCircleOverlayView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    recordingCircleOverlayView.duration = 10.f;
    [self.view addSubview:recordingCircleOverlayView];
    //剪裁
    self.animationView.layer.cornerRadius = self.animationView.bounds.size.width * 0.1;
    self.animationView.clipsToBounds = YES;
    NSLog(@"%lf",self.view.bounds.origin.x);
    
    
    
    GradientProgressView *progressView;
    CGRect frame = CGRectMake(0, 22.0f, CGRectGetWidth([[self view] bounds]), 1.0f);
    progressView = [[GradientProgressView alloc] initWithFrame:frame];
    [progressView startAnimating];
    UIView *view = [self view];
    [view setBackgroundColor:[UIColor blackColor]];
    [view addSubview:progressView];
    [progressView setProgress:1.0];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    [self testMove];
    //    [self testShake];
    //    [self testPantograph];
    //    [self testPath];
}
//移动
- (void)testMove
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    anim.keyPath = @"position";
    CGFloat x = self.animationView.center.x;
    CGFloat y = self.animationView.center.y;
    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(x, y)];
    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(x + 100, y)];
    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(x + 100,  y + 100)];
    NSValue *v4 = [NSValue valueWithCGPoint:CGPointMake(x, y + 100)];
    NSValue *v5 = [NSValue valueWithCGPoint:CGPointMake(x, y )];
    anim.values = @[v1, v2, v3, v4 , v5];
    //到达每个点得时间点 百分比
    anim.keyTimes = @[@(0.0),@(0.7),@(0.8),@(0.9),@(1.0)];
    anim.duration = 2.0;
    anim.removedOnCompletion = NO;
    anim.repeatCount = MAXFLOAT;
    anim.fillMode = kCAFillModeForwards;
    [self.animationView.layer addAnimation:anim forKey:nil];
}
//沿着固定的路径走
- (void)testRadius
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.duration = 2.0;
    anim.repeatCount = MAXFLOAT;
    //新建一个路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat radius = 100;
    //绘制路径
    CGPathAddArc(path, nil, self.animationView.center.x, self.animationView.center.y + radius, radius, -M_PI_2, -M_PI_2 + M_PI * 2, 0);
    //设定动画的路径
    anim.path = path;
    //释放路径
    CGPathRelease(path);
    //和上一句同样的效果
    //CFRelease(path);
    // 设置动画的执行节奏
    // kCAMediaTimingFunctionEaseInEaseOut : 一开始比较慢, 中间会加速,  临近结束的时候, 会变慢
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.delegate = self;
    [self.animationView.layer addAnimation:anim forKey:nil];
}
/**
 *  抖动
 */
- (void)testShake
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.values = @[@(Angle2Radian(0)), @(Angle2Radian(-3)),  @(Angle2Radian(3)), @(Angle2Radian(0))];
    anim.duration = 0.12;
    // 动画的重复执行次数
    anim.repeatCount = MAXFLOAT;
    
    // 保持动画执行完毕后的状态
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    [self.animationView.layer addAnimation:anim forKey:@"shake"];
}
//缩放
- (void)testPantograph
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    anim.keyPath = @"transform.scale";
    NSValue *v1 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0,1.0, 1)];
    NSValue *v2 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1,1.1, 1)];
    NSValue *v3 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2,1.2, 1)];
    NSValue *v4 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3,1.3, 1)];
    NSValue *v5 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.4,1.4, 1)];
    anim.values = @[v1, v2, v3, v4 , v5];
    //到达每个点得时间点 百分比
    anim.keyTimes = @[@(0.0),@(0.1),@(0.3),@(0.6),@(1.0)];
    anim.duration = 2.0;
    anim.removedOnCompletion = NO;
    anim.repeatCount = MAXFLOAT;
    anim.fillMode = kCAFillModeForwards;
    [self.animationView.layer addAnimation:anim forKey:nil];
}
- (void)testPath
{
    CAShapeLayer *shapeLayer = [CAShapeLayer new];
    shapeLayer.fillColor = [UIColor purpleColor].CGColor;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineWidth = 4;
    [self.view.layer addSublayer:shapeLayer];
    
    CAKeyframeAnimation   *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    pathAnimation.repeatCount = MAXFLOAT;
    
    CGPoint center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    UIBezierPath *circlePath1 = [UIBezierPath bezierPath];
    [circlePath1 addArcWithCenter:center radius:40 startAngle:0 endAngle:2*M_PI clockwise:YES];
    UIBezierPath *circlePath2 = [UIBezierPath bezierPath];
    [circlePath2 addArcWithCenter:center radius:self.view.frame.size.width/2*1.4 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    [pathAnimation setValues:@[(id)circlePath1.CGPath, (id)circlePath2.CGPath]];
    [pathAnimation setDuration:1.0];
    [pathAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [pathAnimation setRemovedOnCompletion:YES];
    [shapeLayer addAnimation:pathAnimation forKey:nil];
}
@end
