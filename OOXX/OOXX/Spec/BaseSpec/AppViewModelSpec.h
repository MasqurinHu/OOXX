//
//  AppViewModelSpec.h
//  OOXX
//
//  Created by 五加一 on 2019/8/29.
//  Copyright © 2019 Ｍasqurin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDataSourceSpec.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AppViewModelSpec <NSObject>

@property (nonatomic, retain) id<AppDataSourceSpec> _Nullable dataSource;

@end

NS_ASSUME_NONNULL_END
