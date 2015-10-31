//
//  XXBViewController.m
//  2014_10_10_核心动画_2
//
//  Created by Mac10.9 on 14-10-10.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBViewController.h"

@interface XXBViewController ()

@property (strong, nonatomic) CALayer *animationLayer;

@end

@implementation XXBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CALayer *layer = [CALayer layer];
    self.animationLayer = layer;
    layer.frame = CGRectMake(110, 110, 100, 100);
    layer.backgroundColor = [UIColor yellowColor].CGColor;
    //设置锚点
    layer.position = CGPointMake(110, 110);
    layer.anchorPoint = CGPointMake(0, 0.5);
    [self.view.layer addSublayer:layer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self testScle];
}
/**
 *  旋转动画
 */
- (void)testRotate
{
    //创建动画
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform";
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI,1, 1, 1)];
    animation.duration = 2;
    //播放完毕后不回到原处
    //animation.removedOnCompletion = NO;
    //animation.fillMode = kCAFillModeForwards;
    //添加动画
    [self.animationLayer addAnimation:animation forKey:nil];
}
/**
 *  测试平移
 */
- (void)testTransform
{
    CABasicAnimation *anim = [CABasicAnimation animation];
    // keyPath决定了执行怎样的动画, 调整哪个属性来执行动画
    // anim.keyPath = @"transform.rotation";
    // anim.keyPath = @"transform.scale.x";
    anim.keyPath = @"transform.translation.x";
    //移动100
    anim.byValue = @(100);
    //移动到100
    //anim.toValue = @(100);
    // anim.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    anim.duration = 2.0;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [self.animationLayer addAnimation:anim forKey:nil];
}
/**
 *  平移
 */
- (void)testTranslate
{
    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.keyPath = @"position";
    anima.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    anima.toValue = [NSValue valueWithCGPoint:CGPointMake(320, 480)] ;
    anima.duration = 1.0;
    anima.removedOnCompletion = NO;
    anima.fillMode = kCAFillModeForwards;
    [self.animationLayer addAnimation:anima forKey:nil];
}
/**
 *  测试缩放
 */
- (void)testScle
{
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"bounds";
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 320, 480)];
    anim.duration = 2.0;

    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [self.animationLayer addAnimation:anim forKey:nil];
}
@end
