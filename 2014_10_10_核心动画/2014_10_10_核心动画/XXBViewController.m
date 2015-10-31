//
//  XXBViewController.m
//  2014_10_10_核心动画
//
//  Created by Mac10.9 on 14-10-10.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBViewController.h"

@interface XXBViewController ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) CALayer *layer;

@end

@implementation XXBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self testView];
    [self setUpNewLayer];
}

- (void)testView
{
    [self testView1];
}
/**
 *  动画的基本使用
 */
- (void)testView1
{
#pragma mark - 简单的属性
    
    self.view1.layer.borderWidth = 4;
    self.view1.layer.borderColor = [UIColor purpleColor].CGColor;
    
    self.view1.layer.cornerRadius = 10;
    //超出边框剪裁
    self.view1.layer.masksToBounds = NO;
    
    self.view1.layer.shadowColor = [UIColor purpleColor].CGColor;
    self.view1.layer.shadowOffset = CGSizeMake(20, 20);
    self.view1.layer.shadowOpacity = 0.5;
    
    self.view1.layer.transform = CATransform3DMakeTranslation(1.5, 1.5, 1.5);
    //旋转绕（0，0，1）旋转
    self.view1.transform = CGAffineTransformMakeRotation(M_PI_4/4.0);
#pragma mark 一些简单的属性
    // 可以传递哪些key path, 在官方文档搜索 "CATransform3D key paths"
    
    //旋转 绕自己设定的轴旋转 （3D的）
    self.view1.layer.transform = CATransform3DMakeRotation(M_PI_4, 2, 2, 1);
    //旋转
    NSValue *value = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_4/4, 0, 0, 1)];
    [self.view1.layer setValue:value forKeyPath:@"transform"];
    //伸缩
    self.view1.layer.transform = CATransform3DMakeScale(0.5, 2, 0);
    //伸缩
    [self.view1.layer setValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 0)] forKeyPath:@"transform"];
    //平移
    [self.view1.layer setValue:@(100) forKeyPath:@"transform.translation.x"];
}
/**
 *  建立一个新的图层
 */
- (void)setUpNewLayer
{
    CALayer *layer = [CALayer layer];
    self.layer = layer;
    layer.backgroundColor = [UIColor grayColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 100, 100);
    //锚点默认是（0，0）
    layer.position = CGPointMake(50, 50);
    layer.contents = (id)[UIImage imageNamed:@"newpic"].CGImage;
    [self.view.layer addSublayer:layer];
}
/**
 *  系统自带的动画默认时间为0.25秒
 */
- (void)systemAnimation
{
    self.layer.backgroundColor = [UIColor blueColor].CGColor;
    /**
     *  事务默认开启的
     */
    [CATransaction begin]; // 开启事务
    //隐藏动画
    //[CATransaction setDisableActions:YES];
    
    self.layer.position = CGPointMake(100, 100);
    self.layer.opacity = 0.1;
    [CATransaction commit]; // 提交事务
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self systemAnimation];
}
@end
