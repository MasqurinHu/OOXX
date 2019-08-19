//
//  UIImageOX.m
//  OOXX
//
//  Created by Ｍasqurin on 2017/6/22.
//  Copyright © 2017年 Ｍasqurin. All rights reserved.
//

#import "UIImageOX.h"

@implementation UIImageOX

+ (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0f);
    view.backgroundColor = [UIColor whiteColor];
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    UIImage * snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    view.backgroundColor = [UIColor clearColor];
    return snapshotImage;
}
@end
