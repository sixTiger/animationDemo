//
//  DSFancyLoaderView.m
//  Design Shots
//
//  Created by Rounak Jain on 19/12/14.
//  Copyright (c) 2014 Rounak Jain. All rights reserved.
//

#import "RJCircularLoaderView.h"

#define MAX_RADIUS 20

@interface RJCircularLoaderView ()<CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer *circlePathLayer;
@end

@implementation RJCircularLoaderView

+ (CGFloat)radiusForPoint:(CGPoint)point {
    return sqrtf((point.x*point.x) + (point.y*point.y));
}

+ (CGFloat)distanceBetweenPoint1:(CGPoint)point1 point2:(CGPoint)point2 {
    return [self radiusForPoint:CGPointMake(point1.x - point2.x, point1.y - point2.y)];
}

- (UIBezierPath *)circlePath {
    CGRect circleFrame = CGRectMake(0, 0, 2*MAX_RADIUS, 2*MAX_RADIUS);
    circleFrame.origin.x = CGRectGetMidX(self.circlePathLayer.bounds) - CGRectGetMidX(circleFrame);
    circleFrame.origin.y = CGRectGetMidY(self.circlePathLayer.bounds) - CGRectGetMidY(circleFrame);
    return [UIBezierPath bezierPathWithOvalInRect:circleFrame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _circlePathLayer = [CAShapeLayer layer];
        _circlePathLayer.frame = self.bounds;
        _circlePathLayer.lineWidth = 2;
        _circlePathLayer.fillColor = [UIColor clearColor].CGColor;
        _circlePathLayer.strokeStart = 0;
        _circlePathLayer.strokeColor = self.tintColor.CGColor;
        _circlePathLayer.strokeEnd = _progress;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.circlePathLayer.frame = self.bounds;
    self.circlePathLayer.path = self.circlePath.CGPath;
}

- (void)tintColorDidChange {
    [super tintColorDidChange];
    self.circlePathLayer.strokeColor = self.tintColor.CGColor;
}

- (void)start {
    [self.layer addSublayer:self.circlePathLayer];
}

- (void)reveal {
    self.progress = 1;
    self.backgroundColor = [UIColor clearColor];
    [self.circlePathLayer removeAnimationForKey:NSStringFromSelector(@selector(strokeEnd))];
    [self.circlePathLayer removeAnimationForKey:NSStringFromSelector(@selector(reveal))];
    self.superview.layer.mask = self.circlePathLayer;
    
    CGRect circleFrame = CGRectMake(0, 0, 2*MAX_RADIUS, 2*MAX_RADIUS);
    UIBezierPath *fromPath = [self circlePath];
    circleFrame.origin.x = CGRectGetMidX(self.circlePathLayer.bounds) - CGRectGetMidX(circleFrame);
    circleFrame.origin.y = CGRectGetMidY(self.circlePathLayer.bounds) - CGRectGetMidY(circleFrame);
    CGFloat finalRadius = [self.class distanceBetweenPoint1:CGPointZero point2:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))];
    CGFloat radius = finalRadius - MAX_RADIUS;
    CGRect outerRect = CGRectInset(circleFrame, -radius, -radius);
    UIBezierPath *toPath = [UIBezierPath bezierPathWithOvalInRect:outerRect];
    
    CGFloat fromLineWidth = 2;
    CGFloat toLineWidth = 2*finalRadius;
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.fillMode = kCAFillModeForwards;
    // Prevent the removal of the animation on completion to fix a flicker.  We will remove it manually after we remove the mask.
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.duration = 3;
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    
    CABasicAnimation *lineWidthAnimation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(lineWidth))];
    lineWidthAnimation.fromValue = @(fromLineWidth);
    lineWidthAnimation.toValue = @(toLineWidth);
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(path))];
    pathAnimation.fromValue = (id)fromPath.CGPath;
    pathAnimation.toValue = (id)toPath.CGPath;
    self.circlePathLayer.path = fromPath.CGPath;
    
    groupAnimation.animations = @[lineWidthAnimation, pathAnimation];
    groupAnimation.delegate = self;
    [self.circlePathLayer addAnimation:groupAnimation forKey:NSStringFromSelector(@selector(reveal))];
}

- (void)setProgress:(CGFloat)progress {
    if (progress > 1) {
        progress = 1;
    }
    if (progress < 0) {
        progress = 0;
    }
    [self.circlePathLayer removeAllAnimations];
    _progress = progress;
    self.circlePathLayer.strokeEnd = _progress;
}

- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"XXB | %s [Line %d] %@ %@",__func__,__LINE__,anim,@([[NSDate date] timeIntervalSince1970]));
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"XXB | %s [Line %d] %@ %@ %@",__func__,__LINE__,anim,@([[NSDate date] timeIntervalSince1970]), @(flag));
    if (flag) {
        if (anim == [self.circlePathLayer animationForKey:NSStringFromSelector(@selector(reveal))]) {
            self.superview.layer.mask = nil;
            [self.circlePathLayer removeAllAnimations];
        } else {
            [self.circlePathLayer removeAllAnimations];
        }
    } else {
    }
}

@end
