//
//  SNBSpeechView.m
//  SinaBlog
//
//  Created by ych on 15/10/29.
//  Copyright © 2015年 Robin. All rights reserved.
//

#define kCircleBorderWidth 1.0f
#define kAnimationDuring 1.5f
#define kButtonRadius 40.0f
#define kAnnulusRadius 40.0f
#define kCircleRadius 60.0f
#define kCircleVolumeRadius 46.0f
#define kSB_ColorRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#import "SNBSpeechView.h"

@interface SNBSpeechView ()

@property (nonatomic, strong)CAShapeLayer *annulusLayer1;
@property (nonatomic, strong)CAShapeLayer *annulusLayer2;
@property (nonatomic, strong)CAShapeLayer *circleLayer;
@property (nonatomic, strong)CAShapeLayer *circleVolumeLayer;
@property (nonatomic, strong)UIButton *micButton;

@property (nonatomic, strong)CABasicAnimation *annulusPathAnimation;
@property (nonatomic, strong)CABasicAnimation *annulusOpacityAnitmation;
@property (nonatomic, strong)CAAnimationGroup *annulusAnimationGroup1;
@property (nonatomic, strong)CAAnimationGroup *annulusAnimationGroup2;
@property (nonatomic, strong)CABasicAnimation *circleTransformScaleInitAnimation;
@property (nonatomic, strong)CABasicAnimation *circleTransformScaleAnimation;
@property (nonatomic, strong)CABasicAnimation *circleVolumeTransformScaleInitAnimation;
@property (nonatomic, strong)CABasicAnimation *circleVolumeTransformScaleAnimation;
@property (nonatomic, assign)BOOL voiceIsRecognizing;
@property (nonatomic, assign)int volume;

@end

@implementation SNBSpeechView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self p_setupSNBSpeechView];
    }
    return self;
}
- (void)p_setupSNBSpeechView{
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    _voiceIsRecognizing = NO;
    
    _micButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _micButton.frame = CGRectMake(0, 0, 50, 50);
    _micButton.layer.cornerRadius = kButtonRadius;
    [_micButton setBackgroundColor:[UIColor orangeColor]];
    [_micButton setImage:[UIImage imageNamed:@"mic_big"] forState:UIControlStateNormal];
    [_micButton setImage:[UIImage imageNamed:@"mic_big"] forState:UIControlStateHighlighted];
    [_micButton addTarget:self action:@selector(micButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [_micButton addTarget:self action:@selector(micButtonTouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
    [_micButton addTarget:self action:@selector(micButtonTouchDown) forControlEvents:UIControlEventTouchDown];
    [_micButton addTarget:self action:@selector(micButtonTouchCancel) forControlEvents:UIControlEventTouchCancel];
    [self addSubview:_micButton];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self initLayerAndAnimation];
    });
}

#pragma mark - private method

- (void)initLayerAndAnimation{
    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    //圆环layer
    UIBezierPath *annulusPath = [UIBezierPath bezierPath];
    [annulusPath addArcWithCenter:center radius:kAnnulusRadius startAngle:0 endAngle:2*M_PI clockwise:YES];
    _annulusLayer1 = [CAShapeLayer new];
    _annulusLayer1.fillColor = [UIColor clearColor].CGColor;
    _annulusLayer1.strokeColor = kSB_ColorRGBA(254, 167, 132, 1.0).CGColor;
    _annulusLayer1.lineWidth = kCircleBorderWidth;
    _annulusLayer1.path = annulusPath.CGPath;
    [self.layer addSublayer:_annulusLayer1];
    
    _annulusLayer2 = [CAShapeLayer new];
    _annulusLayer2.fillColor = [UIColor clearColor].CGColor;
    _annulusLayer2.strokeColor = kSB_ColorRGBA(254, 167, 132, 1.0).CGColor;
    _annulusLayer2.lineWidth = kCircleBorderWidth;
    _annulusLayer2.path = annulusPath.CGPath;
    [self.layer addSublayer:_annulusLayer2];
    
    //圆圈layer
    _circleLayer = [CAShapeLayer new];
    _circleLayer.backgroundColor = kSB_ColorRGBA(255, 228, 217, 1.0).CGColor;
    _circleLayer.frame = CGRectMake(center.x-kCircleRadius, center.y-kCircleRadius, kCircleRadius*2, kCircleRadius*2);
    _circleLayer.fillColor = kSB_ColorRGBA(255, 228, 217, 1.0).CGColor;
    _circleLayer.cornerRadius = kCircleRadius;
    _circleLayer.transform = CATransform3DMakeScale(0.5, 0.5, 1.0);
    [self.layer addSublayer:_circleLayer];
    
    _circleVolumeLayer = [CAShapeLayer new];
    _circleVolumeLayer.backgroundColor = kSB_ColorRGBA(255, 191, 165, 1.0).CGColor;
    _circleVolumeLayer.frame = CGRectMake(center.x-kCircleVolumeRadius, center.y-kCircleVolumeRadius, kCircleVolumeRadius*2, kCircleVolumeRadius*2);
    _circleVolumeLayer.fillColor = kSB_ColorRGBA(255, 191, 165, 1.0).CGColor;
    _circleVolumeLayer.cornerRadius = kCircleVolumeRadius;
    _circleVolumeLayer.transform = CATransform3DMakeScale(0.5, 0.5, 1.0);
    [self.layer addSublayer:_circleVolumeLayer];
    
    [self bringSubviewToFront:_micButton];
    
    [self configAnimation];
}

- (void)configAnimation{
    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    
    if (!_annulusPathAnimation) {
        _annulusPathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    }
    _annulusPathAnimation.repeatCount = MAXFLOAT;
    _annulusPathAnimation.fillMode = kCAFillModeForwards;
    _annulusPathAnimation.removedOnCompletion = NO;
    _annulusPathAnimation.duration = kAnimationDuring;
    _annulusPathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    _annulusPathAnimation.toValue = (id)[UIBezierPath bezierPathWithArcCenter:center radius:self.frame.size.width/2*1.4 startAngle:0 endAngle:2*M_PI clockwise:YES].CGPath;
    
    if (!_annulusOpacityAnitmation) {
        _annulusOpacityAnitmation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    }
    _annulusOpacityAnitmation.repeatCount = MAXFLOAT;
    _annulusOpacityAnitmation.fillMode = kCAFillModeForwards;
    _annulusOpacityAnitmation.removedOnCompletion = NO;
    _annulusOpacityAnitmation.duration = kAnimationDuring;
    _annulusOpacityAnitmation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    _annulusOpacityAnitmation.toValue = [NSNumber numberWithFloat:0.9];
    
    if (!_annulusAnimationGroup1) {
        _annulusAnimationGroup1 = [CAAnimationGroup animation];
    }
    _annulusAnimationGroup1.duration = kAnimationDuring;
    _annulusAnimationGroup1.repeatCount = MAXFLOAT;
    [_annulusAnimationGroup1 setAnimations:[NSArray arrayWithObjects:_annulusPathAnimation, _annulusOpacityAnitmation, nil]];
    
    if (!_annulusAnimationGroup2) {
        _annulusAnimationGroup2 = [CAAnimationGroup animation];
    }
    _annulusAnimationGroup2.duration = kAnimationDuring;
    _annulusAnimationGroup2.repeatCount = MAXFLOAT;
    _annulusAnimationGroup2.timeOffset = 0.5;
    [_annulusAnimationGroup2 setAnimations:[NSArray arrayWithObjects:_annulusPathAnimation, _annulusOpacityAnitmation, nil]];
    
    if (!_circleTransformScaleAnimation) {
        _circleTransformScaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    }
    _circleTransformScaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    _circleTransformScaleAnimation.toValue = [NSNumber numberWithFloat:0.95];
    _circleTransformScaleAnimation.duration = kAnimationDuring/2;
    _circleTransformScaleAnimation.autoreverses = YES;
    _circleTransformScaleAnimation.repeatCount = MAXFLOAT;
    _circleTransformScaleAnimation.fillMode = kCAFillModeForwards;
    
    if (!_circleTransformScaleInitAnimation) {
        _circleTransformScaleInitAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    }
    _circleTransformScaleInitAnimation.toValue = [NSNumber numberWithFloat:1.0];
    _circleTransformScaleInitAnimation.duration = kAnimationDuring/4;
    _circleTransformScaleInitAnimation.autoreverses = NO;
    _circleTransformScaleInitAnimation.repeatCount = 1;
    _circleTransformScaleInitAnimation.fillMode = kCAFillModeForwards;
    _circleTransformScaleInitAnimation.removedOnCompletion = NO;
    
    if (!_circleVolumeTransformScaleInitAnimation) {
        _circleVolumeTransformScaleInitAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    }
    _circleVolumeTransformScaleInitAnimation.toValue = [NSNumber numberWithFloat:1.0];
    _circleVolumeTransformScaleInitAnimation.duration = kAnimationDuring/4;
    _circleVolumeTransformScaleInitAnimation.autoreverses = NO;
    _circleVolumeTransformScaleInitAnimation.repeatCount = 1;
    _circleVolumeTransformScaleInitAnimation.fillMode = kCAFillModeForwards;
    _circleVolumeTransformScaleInitAnimation.removedOnCompletion = NO;
    
    if (!_circleVolumeTransformScaleAnimation) {
        _circleVolumeTransformScaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    }
    _circleVolumeTransformScaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    _circleVolumeTransformScaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    _circleVolumeTransformScaleAnimation.duration = 0.1;
    _circleVolumeTransformScaleAnimation.autoreverses = YES;
    _circleVolumeTransformScaleAnimation.repeatCount = 1;
    _circleVolumeTransformScaleAnimation.fillMode = kCAFillModeForwards;
    _circleVolumeTransformScaleAnimation.removedOnCompletion = NO;
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        CGFloat scale = 1.0+(CGFloat)(_volume)/100.0;
        scale = scale > 1.2 ? 1.2 : scale;
        _circleVolumeTransformScaleAnimation.toValue = [NSNumber numberWithFloat:scale];
        [_circleVolumeLayer addAnimation:_circleVolumeTransformScaleAnimation forKey:@"transform.scale"];
    }
}

#pragma mark - public method

- (void)startRecognize{
    [self configAnimation];
    _voiceIsRecognizing = YES;
    [_annulusLayer1 addAnimation:_annulusAnimationGroup1 forKey:@"AnnulusAnimationGroup"];
    [_annulusLayer2 addAnimation:_annulusAnimationGroup2 forKey:@"AnnulusAnimationGroup"];
    
    [_circleLayer addAnimation:_circleTransformScaleInitAnimation forKey:@"transform.scale"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_circleTransformScaleInitAnimation.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_circleLayer addAnimation:_circleTransformScaleAnimation forKey:@"transform.scale"];
    });
    
    [_circleVolumeLayer addAnimation:_circleVolumeTransformScaleInitAnimation forKey:@"transform.scale"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_circleVolumeTransformScaleInitAnimation.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _circleVolumeTransformScaleAnimation.delegate = self;
        [_circleVolumeLayer addAnimation:_circleVolumeTransformScaleAnimation forKey:@"transform.scale"];
    });
}

- (void)stopRecognize{
    _voiceIsRecognizing = NO;
    [_annulusLayer1 removeAllAnimations];
    [_annulusLayer2 removeAllAnimations];
    
    _circleTransformScaleAnimation.toValue = [NSNumber numberWithFloat:0.5];
    _circleTransformScaleAnimation.duration = 0.2;
    _circleTransformScaleAnimation.repeatCount = 1;
    _circleTransformScaleAnimation.removedOnCompletion = NO;
    _circleTransformScaleAnimation.autoreverses = NO;
    [_circleLayer addAnimation:_circleTransformScaleAnimation forKey:@"transform.scale"];
    
    _circleVolumeTransformScaleAnimation.delegate = nil;
    _circleVolumeTransformScaleAnimation.toValue = [NSNumber numberWithFloat:0.5];
    _circleVolumeTransformScaleAnimation.duration = 0.2;
    _circleVolumeTransformScaleAnimation.repeatCount = 1;
    _circleVolumeTransformScaleAnimation.removedOnCompletion = NO;
    _circleVolumeTransformScaleAnimation.autoreverses = NO;
    [_circleVolumeLayer addAnimation:_circleVolumeTransformScaleAnimation forKey:@"transform.scale"];
}

- (void)volumeChanged:(int)volume{
    _volume = volume;
}

#pragma mark - button action

- (void)micButtonTouchUpInside{
    [_micButton setBackgroundColor:[UIColor grayColor]];
    if (_voiceIsRecognizing) {
        [self stopRecognize];
        if (_delegate && [_delegate respondsToSelector:@selector(speech:shouldRecognize:)]) {
            [_delegate speech:self shouldRecognize:NO];
        }
    }else{
        [self startRecognize];
        if (_delegate && [_delegate respondsToSelector:@selector(speech:shouldRecognize:)]) {
            [_delegate speech:self shouldRecognize:YES];
        }
    }
}

- (void)micButtonTouchUpOutside{
    [_micButton setBackgroundColor:[UIColor orangeColor]];
}

- (void)micButtonTouchDown{
    [_micButton setBackgroundColor:[UIColor grayColor]];
}

- (void)micButtonTouchCancel{
    [_micButton setBackgroundColor:[UIColor orangeColor]];
}

@end
