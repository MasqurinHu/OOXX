//
//  AppResponderSpec.h
//  OOXX
//
//  Created by 五加一 on 2019/8/29.
//  Copyright © 2019 Ｍasqurin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppViewModelSpec.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AppResponderSpec <UIResponderStandardEditActions>

@property (nonatomic, retain) id<AppViewModelSpec> _Nullable viewModel;

@end

NS_ASSUME_NONNULL_END
