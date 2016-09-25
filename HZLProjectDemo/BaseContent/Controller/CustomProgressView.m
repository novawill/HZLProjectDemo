//
//  CustomProgressView.m
//  MOMO
//
//  Created by 黄梓伦 on 6/11/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "CustomProgressView.h"
#import "CustomProgressView+BaseConfiguration.h"
@interface CustomProgressView()

@property (strong, nonatomic) CAShapeLayer *colorMaskLayer;
@property (strong, nonatomic) CAShapeLayer *colorLayer;
@property (strong, nonatomic) CAShapeLayer *blueMaskLayer;

@end

@implementation CustomProgressView
- (void)awakeFromNib
{
    self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    [self setupColorLayer];
    [self setupColorMaskLayer];
    [self setupBlueMaskLayer];
    self.percentage = 0.0f;

}


- (CAShapeLayer *)generateMaskLayer {
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    
    
    UIBezierPath *path = nil;
    if ([CustomProgressView clockWiseType]) {
        path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 3+10, self.height ) radius:self.width / 3 startAngle:[CustomProgressView startAngle] endAngle:[CustomProgressView endAngle] clockwise:YES];
    } else {
        path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 3+10, self.height ) radius:self.width / 3 startAngle:[CustomProgressView endAngle] endAngle:[CustomProgressView startAngle] clockwise:NO];
    }
    
    layer.lineWidth = [CustomProgressView lineWidth];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.lineCap = kCALineCapRound; 
    return layer;
}

- (void)setupColorLayer {
    
    self.colorLayer = [CAShapeLayer layer];
    self.colorLayer.frame = self.bounds;
    [self.layer addSublayer:self.colorLayer];
    
    CAGradientLayer *leftLayer = [CAGradientLayer layer];
    leftLayer.frame = CGRectMake(0, 0, self.width / 2, self.height);
  
    leftLayer.locations = @[@0.3, @0.9, @1];
    leftLayer.colors = @[(id)[CustomProgressView centerColor].CGColor, (id)[CustomProgressView startColor].CGColor];
    [self.colorLayer addSublayer:leftLayer];
    
    CAGradientLayer *rightLayer = [CAGradientLayer layer];
    rightLayer.frame = CGRectMake(self.width / 2, 0, self.width / 2, self.height);
    rightLayer.locations = @[@0.3, @0.9, @1];
    rightLayer.colors = @[(id)[CustomProgressView centerColor].CGColor, (id)[CustomProgressView endColor].CGColor];
    [self.colorLayer addSublayer:rightLayer];
}

- (void)setupBlueMaskLayer {
    
    CAShapeLayer *layer = [self generateMaskLayer];
    self.layer.mask = layer;
    self.blueMaskLayer = layer;
}
- (void)setPercentage:(CGFloat)percentage {
    
    _percentage = percentage;
   
    
    [self animationWithStrokeEnd:percentage];
}

- (void)setupColorMaskLayer {
    
    CAShapeLayer *layer = [self generateMaskLayer];
    layer.lineWidth = [CustomProgressView lineWidth] + 0.5;
    self.colorLayer.mask = layer;
    self.colorMaskLayer = layer;
}
- (void)animationWithStrokeEnd:(CGFloat)strokeEnd {
    
    POPSpringAnimation *strokeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    strokeAnimation.toValue = @(strokeEnd);
    strokeAnimation.springBounciness = 12.f;
    strokeAnimation.removedOnCompletion = NO;
    [self.colorMaskLayer pop_addAnimation:strokeAnimation forKey:@"layerStrokeAnimation"];
}


@end
