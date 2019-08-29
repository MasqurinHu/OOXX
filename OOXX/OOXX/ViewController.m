//
//  ViewController.m
//  OOXX
//
//  Created by Ｍasqurin on 2017/6/12.
//  Copyright © 2017年 Ｍasqurin. All rights reserved.
//

#import "ViewController.h"
#import "Ai.h"
#import "Xx.h"
#import "Oo.h"
#import "Board.h"
#import "UIImageOX.h"
#import "Define.h"
#import <GoogleMobileAds/GoogleMobileAds.h>


@implementation ViewController

{
    int time;                           //順序
    bool identifity;                    //記憶ox
    NSMutableArray *chessBoardArray ;   //棋盤位置
    BOOL end;                           //終局
    
    UIImageOX *btimage;
    UIView *chMode;                     //模式畫面
    UIView *chOX;                       //選擇ox畫面
    Board *chechBoard;                 //棋盤畫面
    UIView *chechBoardR;
    UIView *finis;                      //結算畫面
    NSMutableArray *chessLoc;
    Ai *ai;
    CGFloat boardSize;
    CGPoint boardPoint;
    #define AD_ID @"ca-app-pub-9464558371025216/3511144883"
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAdBanner];
    [self preparation];
}

-(void)setAdBanner {
    
    GADBannerView * banner = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    [banner setRootViewController:self];
    [banner setAdUnitID:AD_ID];
    #ifndef NDEBUG
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ @"2077ef9a63d2b398840261c8221a0c9b" ];
    #endif

    [[self view] addSubview:banner];
    [banner setTranslatesAutoresizingMaskIntoConstraints:false];
    if (@available(iOS 11.0, *)) {
        [[[banner bottomAnchor] constraintEqualToAnchor: [[[self view] safeAreaLayoutGuide] bottomAnchor]] setActive:true];
    } else {
        [[[banner bottomAnchor] constraintEqualToAnchor: [[self view] bottomAnchor]] setActive:true];
    }
    [[[banner centerXAnchor] constraintEqualToAnchor:[[self view] centerXAnchor]] setActive:true];
    
    [banner loadRequest:[GADRequest request]];
}

-(void)preparation{
    ai = [Ai new];
    [ai stupidAiReady];
    chessLoc = [NSMutableArray new];
    chessBoardArray = [NSMutableArray new];
    for(int i=0 ; i<9; i++){
        [chessBoardArray addObject:@"0"];
    }
    [self boardSize];
    [self chMode];
}

-(void)boardSize{
    if (self.view.frame.size.width>=self.view.frame.size.height) {
        boardSize = self.view.frame.size.height*.9;
    }else{
        boardSize = self.view.frame.size.width*.9;
    }
    CGFloat vCenter = self.view.frame.size.height/2;
    CGFloat hCenter = self.view.frame.size.width/2;
    boardPoint = CGPointMake(hCenter, vCenter);
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    CGFloat vCenter = self.view.frame.size.height/2;
    CGFloat hCenter = self.view.frame.size.width/2;
    boardPoint = CGPointMake(hCenter, vCenter);
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:.3f animations:^{
        //tag = 50 is masterView
        __strong typeof(weakSelf) strongSelf = weakSelf;
        for(UIView *tmp in self.view.subviews) {
            if ([tmp tag] == 50) {
                tmp.center = strongSelf -> boardPoint;
            }else if ([tmp tag]==51){
                tmp.frame = self.view.frame;
            }
        }
    }];
}

-(void)reset{
    time = 0;
    end = true;
    [ai reset];
    chessLoc = nil;
    chessLoc = [NSMutableArray new];
    for(UIView *tmp in self.view.subviews) {
        [tmp removeFromSuperview];
    }
    for(int i=0 ; i<9; i++){
        chessBoardArray[i] = @"0";
    }
}

-(void)chMode{
    [self reset];
    if (ai.reStartCheckAI) {
        ai.reStartCheckAI = false;
    }
    chMode = [UIView new];
    [chMode setTag:50];
    chMode.frame = CGRectMake(0, 0, boardSize, boardSize*53/103);
    chMode.center = boardPoint;
    chMode.layer.cornerRadius = chMode.frame.size.height*.1;
    chMode.layer.borderWidth = chMode.frame.size.height*.03;
    chMode.backgroundColor = [UIColor brownColor];
    [self.view addSubview:chMode];
    UILabel *title = [UILabel new];
    title.text = CHOOS_EPLAY_MODE;//@"選擇模式"
    title.font = [UIFont systemFontOfSize:30];
    [title sizeToFit];
    title.center = CGPointMake(boardSize/2, boardSize/8);
    title.backgroundColor = [UIColor orangeColor];
    title.layer.borderWidth = 1;
    title.layer.cornerRadius = 5;
    title.layer.masksToBounds = true;//圓角 切內容
    [chMode addSubview:title];
    //3wait
    for (NSInteger i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTag:i];
        NSString *title =@"";
        if (i==0) {
            title = DOUBLE_BATTLE;//@"雙人對戰"
        }else if(i==1){
            title = AI_BATTLE;//@"vs電腦"
        }else if (i==2){
            title = NSLocalizedString(@"crezzyAI", nil) ;//@"瘋狂電腦"
        }
        button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [button setTitle:title forState:UIControlStateNormal];
        button.backgroundColor = [UIColor blueColor];
        button.frame = CGRectMake(chMode.frame.size.width*((i*7)+1)/22, chMode.frame.size.height*.5, chMode.frame.size.width*6/22, chMode.frame.size.height*.4);
        button.layer.cornerRadius = button.frame.size.height*.1;
        button.layer.borderWidth = button.frame.size.height*.03;
        [button addTarget:self action:@selector(chModeBt:) forControlEvents:UIControlEventTouchUpInside];
        [chMode addSubview:button];
    }
    [self setAdBanner];
}


-(void)chModeBt:(UIButton*)sender{
    [self reset];
    if (sender.tag == 0) {
        [self changeOX];
        return;
    }else if (sender.tag==1){
        ai.startAi = true;
        [self changeOX];
        return;
    }else if (sender.tag==2){
        
    }
    [chMode removeFromSuperview];
    UIButton *mes = [UIButton buttonWithType:UIButtonTypeCustom];
    mes.frame = CGRectMake(0, 0, 80, 40);
    mes.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [mes setTitle:@"尚未開放" forState:UIControlStateNormal];
    mes.backgroundColor = [UIColor blackColor];
    [mes setTag:50];
    [self.view addSubview:mes];
    [mes addTarget:self action:@selector(scapegoat:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)scapegoat:(UIButton*)sender{
    [sender removeFromSuperview];
    [self chMode];
}

-(void)changeOX{
    if (ai.reStartCheckAI) {
        ai.startAi = true;
    }
    UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    backbutton.frame = self.view.frame;
    [backbutton addTarget:self action:@selector(chMode) forControlEvents:UIControlEventTouchUpInside];
    backbutton.tag = 51 ;
    [self.view addSubview:backbutton];
    [chMode removeFromSuperview];
    chOX = [UIView new];
    chOX.frame = CGRectMake(0, 0, boardSize*13/15, boardSize*53/103);
    chOX.center = boardPoint;
    chOX.layer.borderWidth = chOX.frame.size.height*.03;
    chOX.layer.cornerRadius = chOX.frame.size.height*.1;
    chOX.backgroundColor = [UIColor yellowColor];
    [chOX setTag:50];
    [self.view addSubview:chOX];
    
    Oo *oo = [Oo new];
    oo.frame = CGRectMake(0, 0, chOX.frame.size.height/2, chOX.frame.size.height/2);
    oo.center = CGPointMake(chOX.frame.size.width/7*2, chOX.frame.size.height*2/7);
    oo.backgroundColor = [UIColor clearColor];
    [chOX addSubview:oo];
    
    Xx *xx = [Xx new];
    xx.frame = CGRectMake(0, 0, chOX.frame.size.height/2, chOX.frame.size.height/2);
    xx.center = CGPointMake(chOX.frame.size.width/7*5, chOX.frame.size.height*2/7);
    xx.backgroundColor = [UIColor clearColor];
    [chOX addSubview:xx];
    
    
    UILabel *chO =[UILabel new];
//    chO.frame = CGRectMake(chOX.frame.size.width*1/14, chOX.frame.size.height*1/6, chOX.frame.size.width*5.5/14, chOX.frame.size.height*4/6);
    NSString *chooseCross;
    NSString *chooseCircle;
    if (ai.startAi){
        chooseCross = AI_LAST;//@"AI後手"
        chooseCircle = AI_FIRST;//@"AI先手"
    }else{
        chooseCircle = OO_FIRST;//@"圈圈先手"
        chooseCross = XX_FIRST;//@"叉叉先手"
    }
    chO.text = chooseCircle;
    chO.numberOfLines = 0;
    [chO sizeToFit];
    chO.center = CGPointMake(chOX.frame.size.width/7*2, chOX.frame.size.height*5/7);
    chO.backgroundColor = [UIColor redColor];
    chO.layer.masksToBounds = true;
    chO.layer.cornerRadius = chO.frame.size.height*.1;
    chO.textColor = [UIColor whiteColor];
    [chOX addSubview:chO];
    
    UIButton *ooo = [UIButton buttonWithType:UIButtonTypeSystem];
    ooo.frame = CGRectMake(0, 0, chOX.frame.size.width/2.5, chOX.frame.size.height*.9);
    ooo.center = CGPointMake(chOX.frame.size.width*2/7, chOX.frame.size.height/2);
    ooo.layer.cornerRadius = ooo.frame.size.width*.1;
    ooo.layer.borderWidth = ooo.frame.size.height*.03;
    ooo.backgroundColor = [UIColor blackColor];
    ooo.alpha = .1;
    [ooo addTarget:self action:@selector(selO) forControlEvents:UIControlEventTouchUpInside];
    [chOX addSubview:ooo];
    
    
    UILabel *chX = [UILabel new];
//    chX.frame = CGRectMake(chOX.frame.size.width*7.5/14, chOX.frame.size.height*1/6, chOX.frame.size.width*5.5/14, chOX.frame.size.height*4/6);
        
    chX.numberOfLines = 0;
    chX.text = chooseCross;
    chX.backgroundColor = [UIColor blackColor];
    [chX sizeToFit];
    chX.center = CGPointMake(chOX.frame.size.width*5/7, chOX.frame.size.height*5/7);
    chX.layer.cornerRadius = chX.frame.size.height*.1;
    chX.layer.masksToBounds = true;
    chX.textColor = [UIColor whiteColor];
    [chOX addSubview:chX];
    UIButton *xxx = [UIButton buttonWithType:UIButtonTypeSystem];
    xxx.frame = CGRectMake(0, 0, chOX.frame.size.width/2.5, chOX.frame.size.height*.9);
    xxx.center = CGPointMake(chOX.frame.size.width*5/7, chOX.frame.size.height/2);
    xxx.layer.cornerRadius = xxx.frame.size.width*.1;
    xxx.layer.borderWidth = xxx.frame.size.height*.03;
    xxx.backgroundColor = [UIColor blackColor];
    xxx.alpha = .1;
    [xxx addTarget:self action:@selector(selX) forControlEvents:UIControlEventTouchUpInside];
    [chOX addSubview:xxx];
}
//等待使用者回應


-(void)selO{
    identifity = true;
    [self ooxx];
}
-(void)selX{
    identifity = false;
    [self ooxx];
}

-(void)ooxx{
    if (ai.startAi) {
        ai.userChange = identifity;;
    }
    [chOX removeFromSuperview];
    CGSize scpaegoat = self.view.frame.size;
    chechBoard = [[Board alloc] initWithFrame:CGRectMake(scpaegoat.width/10, scpaegoat.width/10, boardSize, boardSize)];
    chechBoard.center = CGPointMake(scpaegoat.width/2, scpaegoat.height/2);
    chechBoard.backgroundColor = [UIColor clearColor];
    [chechBoard setTag:50];
    [self.view addSubview:chechBoard];
    chechBoardR = [UIView new];
    chechBoardR.frame = chechBoard.frame;
    [chechBoardR setTag:50];
    [self.view addSubview:chechBoardR];
    CGRect bord = chechBoardR.frame;
    
    NSInteger k =1;
    for(int i=0;i<3;i++){
        for (int j = 0; j<3; j++) {
            UIButton *chessBt = [UIButton buttonWithType:UIButtonTypeCustom];
            [chessBt setTag:k];
            chessBt.frame = CGRectMake(bord.size.width*j/3+bord.size.width/60, bord.size.width*i/3+bord.size.width/60, bord.size.width*3/10, bord.size.width*3/10);
            CGFloat chessLocW = chessBt.frame.size.width;
            NSNumber *nsChessLocW = [NSNumber numberWithFloat:chessLocW];
            CGFloat locChessH = chessBt.frame.size.height;
            NSNumber *nsChessLocH = [NSNumber numberWithFloat:locChessH];
            
            [chessLoc addObject:nsChessLocW];
            [chessLoc addObject:nsChessLocH];
            
            [chechBoardR addSubview:chessBt];
            [chessBt addTarget:self action:@selector(show1:) forControlEvents:UIControlEventTouchUpInside];
            k++;
        }
    }
    if (ai.startAi&&ai.userChange) {
        time++;
        identifity = true;
        [ai aiTurn];
        CGFloat chesslocW = [chessLoc[ai.aiChess*2] floatValue];
        CGFloat chesslocH = [chessLoc[ai.aiChess*2+1] floatValue];
        Xx *xx = [[Xx alloc] initWithFrame:CGRectMake(0, 0, chesslocW, chesslocH)];
        xx.backgroundColor = [UIColor clearColor];
        [[self.view viewWithTag:ai.aiChess+1] addSubview:xx];
        for (NSInteger i = 0; i<9; i++) {
            if (i==ai.aiChess) {
                chessBoardArray[i] = @"2";
            }
        }
        [self Settlement];
    }
  }

-(void)show1:(UIButton*)sender{
    if (!end) {
        sender.enabled = false;
        return;
    }
    time+=1;
    sender.enabled = false;
    NSString *scapegoat;
    CGFloat chesslocW = [chessLoc[sender.tag/2] floatValue];
    CGFloat chesslocH = [chessLoc[sender.tag/2+1] floatValue];
    ai.AiArray[sender.tag-1] = @-1;
    if(identifity){
        identifity = false;
        scapegoat = @"1";
        Oo *oo = [[Oo alloc] initWithFrame:CGRectMake(0, 0, chesslocW, chesslocH)];
        oo.backgroundColor = [UIColor clearColor];
        [sender addSubview:oo];
    }else{
        identifity = true;
        scapegoat = @"2";
        Xx *xx = [[Xx alloc] initWithFrame:CGRectMake(0, 0, chesslocW, chesslocH)];
        xx.backgroundColor = [UIColor clearColor];
        [sender addSubview:xx];
    }
    for (NSInteger i = 0; i<9; i++) {
        if (i==sender.tag-1) {
            chessBoardArray[i] = scapegoat;
        }
    }
    [self Settlement];
    if (ai.startAi&&ai.userChange!=identifity&&time<9) {
        time++;
        [ai aiTurn];
        CGFloat chesslocW = [chessLoc[ai.aiChess*2] floatValue];
        CGFloat chesslocH = [chessLoc[ai.aiChess*2+1] floatValue];
        if (identifity) {
            identifity = false;
            scapegoat = @"1";
            Oo *oo = [[Oo alloc] initWithFrame:CGRectMake(0, 0, chesslocW, chesslocH)];
            oo.backgroundColor = [UIColor clearColor];
            [[self.view viewWithTag:ai.aiChess+1] addSubview:oo];
        }else {
            identifity = true;
            scapegoat = @"2";
            Xx *xx = [[Xx alloc] initWithFrame:CGRectMake(0, 0, chesslocW, chesslocH)];
            xx.backgroundColor = [UIColor clearColor];
            [[self.view viewWithTag:ai.aiChess+1] addSubview:xx];
        }
        for (NSInteger i = 0; i<9; i++) {
            if (i==ai.aiChess) {
                chessBoardArray[i] = scapegoat;
            }
        }
        [self Settlement];
    }
    
}

-(void)Settlement{
    NSLog(@"\n次數＝%d \n棋盤\n%@%@%@\n%@%@%@\n%@%@%@",time,chessBoardArray[0],chessBoardArray[1],chessBoardArray[2],chessBoardArray[3],chessBoardArray[4],chessBoardArray[5],chessBoardArray[6],chessBoardArray[7],chessBoardArray[8]);
    if([self checkWin:1]){
        [self finish];
    }else if([self checkWin:2]){
        [self finish];
    }else if(time>8){
        [self finish];
    }

}

-(void)finish{
    if (ai.startAi) {
        ai.reStartCheckAI = true;
        ai.startAi = false;
    }
    end = false;
    finis = [UIView new];
    CGFloat sw = self.view.frame.size.width;
    CGFloat sh = self.view.frame.size.height;
    finis.frame = CGRectMake(sw/15, sh*2/5, boardSize, boardSize/2);
    finis.center = CGPointMake(boardPoint.x, 0);
    finis.backgroundColor = [UIColor magentaColor];
    [finis setTag:50];
    finis.layer.cornerRadius = finis.frame.size.height*.1;
    finis.layer.borderWidth = finis.frame.size.height*.03;
    [self.view addSubview:finis];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:1.2f animations:^{
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf -> finis.center = strongSelf -> boardPoint;
    }];
    CGFloat mw = finis.frame.size.width;
    CGFloat mh = finis.frame.size.height;
    UILabel *fl = [UILabel new];
    NSString *theOutcome;
    if([self checkWin:1]){
        theOutcome = OO_WIN;//@"O獲勝"
    }else if ([self checkWin:2]){
        theOutcome = XX_WIN;//@"X獲勝"
    }else{
        theOutcome = TIE;//@"平手"
    }
    
    fl.text = theOutcome;
    fl.frame = CGRectMake(mw*.1, mh*.1, mw*.3, mh*.2);
    [finis addSubview:fl];
    UIButton *finish = [UIButton buttonWithType:UIButtonTypeSystem];
    finis.tintColor = [UIColor blackColor];
    finish.frame = CGRectMake(mw/16, mh*.5, mw*4/16, mh*.4);
    finish.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [finish setTitle:CLOSE_THE_GAME forState:UIControlStateNormal];//@"結束遊戲"
    finish.backgroundColor = [UIColor greenColor];
    [finish addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    finish.layer.borderWidth = finish.frame.size.height*.03;
    finish.layer.cornerRadius = finish.frame.size.height*.1;
    [finis addSubview:finish];
    UIButton *restar = [UIButton buttonWithType:UIButtonTypeSystem];
    restar.frame = CGRectMake(mw*6/16, mh*.5, mw*4/16, mh*.4);
    [restar setTitle:RESTART forState:UIControlStateNormal];//@"重新開始"
    [restar addTarget:self action:@selector(restare) forControlEvents:UIControlEventTouchUpInside];
    restar.backgroundColor = [UIColor yellowColor];
    restar.layer.borderWidth = restar.frame.size.height*.03;
    restar.layer.cornerRadius = restar.frame.size.height*.1;
    [finis addSubview:restar];
    UIButton *rech = [UIButton buttonWithType:UIButtonTypeSystem];
    rech.frame = CGRectMake(mw*11/16, mh*.5, mw*4/16, mh*.4);
    rech.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [rech setTitle:CHOOS_BPLAY_MODE forState:UIControlStateNormal];//@"選擇模式"
    [rech addTarget:self action:@selector(chMode) forControlEvents:UIControlEventTouchUpInside];
    rech.backgroundColor = [UIColor redColor];
    rech.layer.borderWidth = rech.frame.size.height*.03;
    rech.layer.cornerRadius = rech.frame.size.height*.1;
    [finis addSubview:rech];
}
-(void)restare{
    [self reset];
    [self changeOX];
}

-(void)exit{
    exit(0);
}

-(BOOL)checkWin:(int)OX{
    bool checkwin = false;
    if([chessBoardArray[0] intValue]==OX&&[chessBoardArray[1] intValue]==OX&&[chessBoardArray[2] intValue]==OX){
        checkwin = true;
    }else if([chessBoardArray[3] intValue]==OX&&[chessBoardArray[4] intValue]==OX&&[chessBoardArray[5] intValue]==OX){
        checkwin = true;
    }else if([chessBoardArray[6] intValue]==OX&&[chessBoardArray[7] intValue]==OX&&[chessBoardArray[8] intValue]==OX){
        checkwin = true;
    }else if([chessBoardArray[0] intValue]==OX&&[chessBoardArray[3] intValue]==OX&&[chessBoardArray[6] intValue]==OX){
        checkwin = true;
    }else if([chessBoardArray[1] intValue]==OX&&[chessBoardArray[4] intValue]==OX&&[chessBoardArray[7] intValue]==OX){
        checkwin = true;
    }else if([chessBoardArray[2] intValue]==OX&&[chessBoardArray[5] intValue]==OX&&[chessBoardArray[8] intValue]==OX){
        checkwin = true;
    }else if([chessBoardArray[0] intValue]==OX&&[chessBoardArray[4] intValue]==OX&&[chessBoardArray[8] intValue]==OX){
        checkwin = true;
    }else if([chessBoardArray[2] intValue]==OX&&[chessBoardArray[4] intValue]==OX&&[chessBoardArray[6] intValue]==OX){
        checkwin = true;
    }
    return  checkwin;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

