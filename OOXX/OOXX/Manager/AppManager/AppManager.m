//
//  AppManager.m
//  OOXX
//
//  Created by 五加一 on 2019/8/29.
//  Copyright © 2019 Ｍasqurin. All rights reserved.
//

#import "AppManager.h"
#import "AppManager+Firebase.h"
#import "AppCoordinator.h"

@implementation AppManager {
    
    AppCoordinator *appCoordinator;
    
}

+(instancetype) sharedInstance {
    
    static AppManager * instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [AppManager new];
    });
    
    return instance;
}

- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setFirebase];
    
    
}

@end
