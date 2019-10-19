//
//  KanbanVc.m
//  OOXX
//
//  Created by 五加一 on 2019/8/29.
//  Copyright © 2019 Ｍasqurin. All rights reserved.
//

#import "KanbanVc.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface KanbanVc ()

@end

@implementation KanbanVc {
    
    GADBannerView * banner;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) setAdView {
    
    banner = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    [banner setRootViewController:self];
    
}



@synthesize viewModel;

@end
