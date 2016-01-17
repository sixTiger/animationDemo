//
//  XXBView.m
//  ProgressAnimation
//
//  Created by xiaobing on 16/1/5.
//  Copyright © 2016年 xiaobing. All rights reserved.
//

#import "XXBView.h"

@interface XXBView ()
{
    UIColor   *_backLineColor;
    UIColor   *_lineColor;
}
@property(nonatomic , strong) CAShapeLayer      *animationLayer;
@property(nonatomic , weak) UILabel             *messageLabel;
@end

@implementation XXBView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self p_setupView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView
{
    self.backgroundColor = [UIColor clearColor];
    _lineWidth = 10.0;
    self.percent = 0.5;
}


- (void)setLineWidth:(CGFloat)lineWidth
{
    if (_lineWidth == lineWidth) {
        return;
    }
    _lineWidth = lineWidth;
    [self.animationLayer removeFromSuperlayer];
    _animationLayer = nil;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self drawCircleRect:rect];
}
- (void)drawCircleRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.lineWidth * 0.5  , self.lineWidth * 0.5 ,rect.size.width - self.lineWidth ,rect.size.height - self.lineWidth)];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = self.lineWidth;
    [self.backLineColor set];
    [path stroke];
    [self animationLayer];
}

- (void)setBackLineColor:(UIColor *)backLineColor
{
    _backLineColor = backLineColor;
    [self setNeedsDisplay];
}

- (UIColor *)backLineColor
{
    if (_backLineColor == nil)
    {
        _backLineColor = [UIColor colorWithWhite:1.0 alpha:0.4];
    }
    return _backLineColor;
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    self.animationLayer.strokeColor = lineColor.CGColor;
}
- (UIColor *)lineColor
{
    if(_lineColor == nil)
    {
        _lineColor = [UIColor colorWithRed:100/255.0 green:181/255.0 blue:58/255.0 alpha:1.0];
    }
    return _lineColor;
}

- (CAShapeLayer *)animationLayer
{
    if (_animationLayer == nil)
    {
        _animationLayer = [CAShapeLayer layer];
        CGRect rect = self.bounds;
        _animationLayer.frame = rect;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(rect.size.width/2.0 ,rect.size.height/2.0) radius:rect.size.width/2.0 - self.lineWidth * 0.5 startAngle:0 - M_PI * 0.5 endAngle: 1.5*M_PI clockwise:YES];
        _animationLayer.path=path.CGPath;//46,169,230
        _animationLayer.lineCap = @"butt";
        _animationLayer.fillColor = [UIColor clearColor].CGColor;
        _animationLayer.strokeColor= self.lineColor.CGColor;
        _animationLayer.lineWidth=self.lineWidth;
        [self.layer addSublayer:_animationLayer];
    }
    return _animationLayer;
}

- (UILabel *)messageLabel
{
    if (_messageLabel == nil)
    {
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:self.bounds];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.font = [UIFont boldSystemFontOfSize:40];
        [self addSubview:messageLabel];
        _messageLabel = messageLabel;
    }
    return _messageLabel;
}
- (void)setPercent:(CGFloat)percent
{
    CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration=0.0;
    bas.delegate=self;
    bas.fromValue=@(self.percent);
    bas.toValue=@(percent);
    bas.removedOnCompletion = NO;
    bas.fillMode = kCAFillModeForwards;
    [self.animationLayer addAnimation:bas forKey:@"key"];
    _percent = percent;
    self.messageLabel.text = [NSString stringWithFormat:@"%.4f",percent];
}
@end
