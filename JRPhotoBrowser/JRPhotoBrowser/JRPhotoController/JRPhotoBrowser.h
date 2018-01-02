//
//  JRPhotoBrowser.h
//  JRPhotoBrowser
//
//  Created by wxiao on 2017/12/1.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRPhotoBrowser : UIViewController

/**
 图片水平边距 默认:10
 */
@property (nonatomic, assign) CGFloat	horizontalPadding;

/**
 是否允许向上滑动关闭	默认:YES
 */
@property (nonatomic, assign) BOOL		scrollTopCloseAble;

/**
 是否允许滑动关闭	默认:YES
 */
@property (nonatomic, assign) BOOL		scrollCloseAble;

/**
 通过点击图片初始化

 @param view 源View
 @return 图片浏览器
 */
+ (instancetype)photoBrowserWithView:(UIView *)view;

/**
 初始化方法

 @param view 点击图片
 @param imgList 图片列表
 @param index 点击的图片索引
 @return 图片浏览器
 */
+ (instancetype)photoBrowserWithView:(UIView *)view
						   imageList:(NSArray *)imgList
							   index:(NSInteger)index;



@end
