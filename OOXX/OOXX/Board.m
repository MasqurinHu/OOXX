//
//  Board.m
//  OOXX
//
//  Created by Ｍasqurin on 2017/6/22.
//  Copyright © 2017年 Ｍasqurin. All rights reserved.
//

#import "Board.h"

@implementation Board

- (void)drawRect:(CGRect)rect {
    CGSize sz = CGSizeMake(self.frame.size.width, self.frame.size.height);
    UIView *board = [UIView new];
    board.frame = CGRectMake(0, 0, sz.width, sz.height);
    board.layer.cornerRadius = sz.width/9;
    board.layer.shadowOffset = CGSizeMake(sz.width/20, sz.height/20);
    board.layer.shadowOpacity = .5f;
    board.layer.shadowRadius = 10.0f;
    board.layer.borderWidth = sz.width/35;
    board.backgroundColor = [UIColor brownColor];
    [self addSubview:board];
    UIView *columnL = [UIView new];
    columnL.frame = CGRectMake(sz.width*95/300, sz.height*10/300, sz.width*10/300, sz.height*280/300);
    columnL.backgroundColor = [UIColor blackColor];
    columnL.bounds = CGRectMake(0, 0, 0, 0);
    [self addSubview:columnL];
    UIView *columnR = [UIView new];
    columnR.frame = CGRectMake(sz.width*195/300, sz.height*10/300, sz.width*10/300, sz.height*280/300);
    columnR.backgroundColor = [UIColor blackColor];
    columnR.bounds = CGRectMake(0, 0, 0, 0);
    [self addSubview:columnR];
    UIView *rowH = [UIView new];
    rowH.frame = CGRectMake(sz.width*10/300, sz.height*95/300, sz.width*280/300, sz.height*10/300);
    rowH.backgroundColor = [UIColor blackColor];
    rowH.bounds = CGRectMake(0, 0, 0, 0);
    [self addSubview:rowH];
    UIView *rowL = [UIView new];
    rowL.frame = CGRectMake(sz.width*10/300, sz.height*195/300, sz.width*280/300, sz.height*10/300);
    rowL.backgroundColor = [UIColor blackColor];
    rowL.bounds = CGRectMake(0, 0, 0, 0);
    [self addSubview:rowL];

    [UIView animateWithDuration:.6f animations:^{
        columnL.bounds = CGRectMake(0, 0, sz.width*10/300, sz.height*250/300);
        columnR.bounds = CGRectMake(0, 0, sz.width*10/300, sz.height*250/300);
        rowH.bounds = CGRectMake(0, 0, sz.width*250/300, sz.height*10/300);
        rowL.bounds = CGRectMake(0, 0, sz.width*250/300, sz.height*10/300);
    }];
    
}

@end
