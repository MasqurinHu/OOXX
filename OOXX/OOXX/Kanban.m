//
//  Kanban.m
//  OOXX
//
//  Created by Ｍasqurin on 2017/7/13.
//  Copyright © 2017年 Ｍasqurin. All rights reserved.
//

#import "Kanban.h"

@implementation Kanban


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGSize sz = self.frame.size;
    UIView *board = [UIView new];
    board.frame = self.frame;
    board.layer.cornerRadius = sz.width/8;
    board.layer.shadowOffset = CGSizeMake(sz.width/20, sz.height/20);
    board.layer.shadowOpacity = .5f;
    board.layer.shadowRadius = 10.0f;
    board.layer.borderWidth = sz.width/30;
    board.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:board];
//    UILabel *title = [UILabel new];
//    title.text = 

    
    [UIView animateWithDuration:.6f animations:^{
        
    }];
    

}


@end
