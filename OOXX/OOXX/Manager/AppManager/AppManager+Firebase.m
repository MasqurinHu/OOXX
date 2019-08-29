//
//  AppManager+Firebase.m
//  OOXX
//
//  Created by 五加一 on 2019/8/29.
//  Copyright © 2019 Ｍasqurin. All rights reserved.
//

#import "AppManager+Firebase.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
@import Firebase;

@implementation AppManager (Firebase)

-(void) setFirebase {
    
    [[GADMobileAds sharedInstance] startWithCompletionHandler:nil];
    [FIRApp configure];
}


@end
