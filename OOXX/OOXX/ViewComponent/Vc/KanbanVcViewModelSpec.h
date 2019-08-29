//
//  KanbanVcViewModelSpec.h
//  OOXX
//
//  Created by 五加一 on 2019/8/29.
//  Copyright © 2019 Ｍasqurin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppViewModelSpec.h"

NS_ASSUME_NONNULL_BEGIN

@protocol KanbanVcViewModelSpec <AppViewModelSpec>

@property (nonatomic, strong) NSString * _Nullable title;
@property (nonatomic, strong) NSArray<NSString *> * _Nullable BtnTitleList;

-(int) selectIndex;

@end

NS_ASSUME_NONNULL_END
