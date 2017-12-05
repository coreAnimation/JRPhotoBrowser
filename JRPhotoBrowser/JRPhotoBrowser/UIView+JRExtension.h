//
//  UIView+JRExtension.h
//  ZHCircle
//
//  Created by wxiao on 2017/11/22.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JRExtension)

/**
 view y
 */
@property (nonatomic) CGFloat y;

@property (nonatomic) CGFloat centerX;

@property (nonatomic) CGFloat centerY;

/**
 view x + width
 */
@property (nonatomic) CGFloat max_x;

/**
 view y + height
 */
@property (nonatomic) CGFloat max_y;

@end
