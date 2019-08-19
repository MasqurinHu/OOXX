//
//  Xx.m
//  OOXX
//
//  Created by Ｍasqurin on 2017/6/22.
//  Copyright © 2017年 Ｍasqurin. All rights reserved.
//

#import "Xx.h"

@implementation Xx


- (void)drawRect:(CGRect)rect {
    CGSize fl = CGSizeMake(self.frame.size.width, self.frame.size.height);
    UIView *abc = [UIView new];
    abc.backgroundColor = [UIColor blackColor];
    abc.frame = CGRectMake(0, 0, fl.width, fl.height);
    abc.transform = CGAffineTransformMakeRotation(M_PI*0.25);
    abc.bounds = CGRectMake(0, 0, 0, fl.height*.1);
    UIView *bcd = [UIView new];
    bcd.backgroundColor = [UIColor blackColor];
    bcd.frame = CGRectMake(0, 0, fl.width, fl.height);
    bcd.transform = CGAffineTransformMakeRotation(M_PI*.25);
    bcd.bounds = CGRectMake(0, 0, fl.width*.1, 0);
    [self addSubview:bcd];
    
    [UIView animateWithDuration:.6f animations:^{
        abc.bounds = CGRectMake(0, 0, fl.width, fl.height*.1);
        bcd.bounds = CGRectMake(0, 0, fl.width*.1, fl.height);
    }];
    [self addSubview:abc];
}

@end
