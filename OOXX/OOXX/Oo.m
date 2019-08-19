//
//  Oo.m
//  OOXX
//
//  Created by Ｍasqurin on 2017/6/22.
//  Copyright © 2017年 Ｍasqurin. All rights reserved.
//

#import "Oo.h"

@implementation Oo


- (void)drawRect:(CGRect)rect {
    CGFloat fl = self.frame.size.width/2;
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(fl, fl) radius:fl/1.4 startAngle:0 endAngle:2*M_PI clockwise:true];
    [[UIColor redColor] setStroke];
    [path setLineWidth:fl/4.8];
    [path stroke];
}


@end
