//
//  CZViewController.m
//  10.车小模仿(掌握)
//
//  Created by apple on 14-10-11.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "CZViewController.h"
#import "OBShapedButton.h"

@interface CZViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bigCircle;

@end

@implementation CZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 添加三个按钮
    for (int i = 0; i < 3; i++) {
        OBShapedButton *btn = [OBShapedButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        NSString *imageName = [NSString stringWithFormat:@"circle%d",i+1];
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        btn.frame = self.bigCircle.bounds;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bigCircle addSubview:btn];
    }
    
    // 添加中间按钮
    UIButton *centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    centerBtn.bounds = CGRectMake(0, 0, 112, 112);
    [centerBtn setBackgroundImage:[UIImage imageNamed:@"home_btn_dealer_had_bind"] forState:UIControlStateNormal];
   
    centerBtn.center = self.bigCircle.center;
    
    [centerBtn addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:centerBtn];
    
}


#pragma mark 扇形按钮的点击
- (void)btnClick:(UIButton *)btn
{
    NSLog(@"%d",btn.tag);
}

#pragma mark 中间按钮的点击
- (void)centerBtnClick:(UIButton *)btn
{
    NSLog(@"%d",btn.tag);
    // 隐藏方法 hidden alpha
    
    // 透明度 旋转 缩放动画
    
    // 透明度
    CABasicAnimation *opacityAni = [CABasicAnimation animation];
    opacityAni.keyPath = @"opacity";
    
    
    // 旋转
    CABasicAnimation *rotationAni = [CABasicAnimation animation];
    rotationAni.keyPath = @"transform.rotation";
    
    // 缩放
    CAKeyframeAnimation *scaleAni = [CAKeyframeAnimation animation];
    scaleAni.keyPath = @"transform.scale";
    
    if (self.bigCircle.alpha == 0) {// 显示
        self.bigCircle.alpha = 1;
        
        opacityAni.fromValue = @(0);
        opacityAni.toValue = @(1);
        
        
        rotationAni.fromValue = @(-M_PI_4);
        rotationAni.toValue = @(0);
        
        
        scaleAni.values = @[@(0),@(1.2),@(1)];
        
    }else{ // 隐藏
        self.bigCircle.alpha = 0;
        
        opacityAni.fromValue = @(1);
        opacityAni.toValue = @(0);
        
        rotationAni.fromValue = @(0);
        rotationAni.toValue = @(-M_PI_4);
        
        scaleAni.values = @[@(1),@(1.2),@(0)];
    }
    
    
    // 添加动画
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[opacityAni,rotationAni,scaleAni];
    group.duration = 5.0;
    
    [self.bigCircle.layer addAnimation:group forKey:nil];
}

@end
