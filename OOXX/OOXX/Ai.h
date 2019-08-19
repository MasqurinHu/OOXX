//
//  Ai.h
//  OOXX
//
//  Created by Ｍasqurin on 2017/6/22.
//  Copyright © 2017年 Ｍasqurin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ai : NSObject
@property(nonatomic,strong)NSMutableArray<NSNumber*> *AiArray;
@property bool startAi;
@property bool reStartCheckAI;
@property bool userChange;
@property int aiChess;

-(void)stupidAiReady;
-(void)aiTurn;
-(void)reset;
@end
