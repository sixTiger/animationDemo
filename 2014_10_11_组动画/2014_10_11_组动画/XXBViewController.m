//
//  XXBViewController.m
//  2014_10_11_组动画
//
//  Created by Mac10.9 on 14-10-11.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBViewController.h"
#import "OBShapedButton.h"

@interface XXBViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bigImage;
@property (assign, nonatomic, getter = isOpen) BOOL open;

@end

@implementation XXBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}
- (void)setup
{
    self.open = YES;
    for (int i = 0; i < 3;  i++) {
        OBShapedButton *button = [OBShapedButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"circle%d" , i+1]] forState:UIControlStateNormal];
        button.frame = self.bigImage.bounds;
        button.tag = 100 + i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bigImage addSubview:button];
    }
    OBShapedButton *button = [OBShapedButton buttonWithType:UIButtonTypeCustom];
    UIImage *btnBg = [UIImage imageNamed:@"home_btn_dealer_had_bind"];
    [button setBackgroundImage:btnBg forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, btnBg.size.width, btnBg.size.height);
    button.center = self.bigImage.center;
    [button addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
- (void)centerBtnClick:(OBShapedButton *)sender
{
    //更改透明度
    CABasicAnimation *opacityAnimation = [CABasicAnimation animation];
    opacityAnimation.keyPath = @"opacity";
    
    // 旋转
    CABasicAnimation *rotationAnimation = [CABasicAnimation animation];
    rotationAnimation.keyPath = @"transform.rotation";
    
    //缩放
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animation];
    scaleAnimation.keyPath = @"transform.scale";
    if (self.isOpen) {
        opacityAnimation.toValue = @(0);
        rotationAnimation.toValue = @(M_PI_4);
        scaleAnimation.values = @[@(1),@(1.2),@(0)];
    }
    else
    {
        opacityAnimation.toValue = @(1);
        rotationAnimation.toValue = @(0);
        scaleAnimation.values = @[@(0),@(1.2),@(1)];
    }
    self.open = !self.isOpen;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[opacityAnimation , rotationAnimation ,scaleAnimation];
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.duration = 2;
    [self.bigImage.layer addAnimation:animationGroup forKey:nil];
   
    
}
- (void)btnClick:(OBShapedButton *)btn
{
    NSLog(@"%d",btn.tag);
}

@end
