//
//  AppCoordinatorSpec.h
//  OOXX
//
//  Created by 五加一 on 2019/8/29.
//  Copyright © 2019 Ｍasqurin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AppCoordinatorSpec <NSObject>

@property (nonatomic, weak) id<AppCoordinatorSpec> _Nullable lastCoordinator;

-(void) start;

@end

NS_ASSUME_NONNULL_END
