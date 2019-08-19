//
//  Ai.m
//  OOXX
//
//  Created by Ｍasqurin on 2017/6/22.
//  Copyright © 2017年 Ｍasqurin. All rights reserved.
//

#import "Ai.h"

@implementation Ai

-(void)stupidAiReady{
    self.AiArray = [NSMutableArray new];
    for (int i = 0; i<9; i++) {
        NSNumber *scapegot = [NSNumber numberWithInt:i];
        [self.AiArray addObject:scapegot];
    }
}

-(void)reset{
    for (int i=0; i<9; i++) {
        NSNumber *scapegoat = [NSNumber numberWithInt:i];
        self.AiArray[i] = scapegoat;
    }
    _startAi = false;
    _userChange = false;
    _aiChess = 0;
    
}

-(void)aiTurn{
    int i;
    while (true) {
        NSLog(@"%@",self.AiArray);
        int scapegoat = (int)self.AiArray.count;
        i = arc4random_uniform(scapegoat);
        NSNumber *dummy = self.AiArray[i];
        self.AiArray[i] = @-1;
        self.aiChess = [dummy intValue];
        NSLog(@"陣列第%d個 %@值是",i,dummy);
        if ([dummy integerValue] != -1) {
            NSLog(@"陣列第%d個 %@值是",i,dummy);
            break;
        }
    }
}

@end
