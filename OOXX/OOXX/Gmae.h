//
//  Gmae.h
//  OOXX
//
//  Created by Ｍasqurin on 2017/7/13.
//  Copyright © 2017年 Ｍasqurin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gmae : NSObject
@property(nonatomic,assign)int gameMode;                        //3 or 5
@property(nonatomic,assign)int batMode;                         //0 vs 1 AI
@property(nonatomic,assign)int turn;                            //順序
@property(nonatomic,assign)Boolean whoTurn;                     //O true X faluse
@property(nonatomic,strong)NSMutableArray *chessBoardArray ;    //棋盤位置
@property(nonatomic,assign)Boolean endGame;                     //終局

//-(void)choosePlayMode;
//-(void)chooseFirsthand;
//-(void)aiTurn;
//-(void)playerTurn;
//-(void)checkWin;
//-(void)finalGame;


@end






