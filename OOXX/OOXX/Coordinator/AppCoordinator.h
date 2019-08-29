//
//  AppCoordinator.h
//  OOXX
//
//  Created by 五加一 on 2019/8/29.
//  Copyright © 2019 Ｍasqurin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppCoordinatorSpec.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppCoordinator : NSObject <AppCoordinatorSpec>

- (void)start;
- (void)end;

@end

NS_ASSUME_NONNULL_END
