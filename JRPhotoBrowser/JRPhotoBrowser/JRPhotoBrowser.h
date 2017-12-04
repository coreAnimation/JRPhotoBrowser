//
//  JRPhotoBrowser.h
//  JRPhotoBrowser
//
//  Created by wxiao on 2017/12/1.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRPhotoBrowser : UIViewController

+ (instancetype)photoBrowserWithView:(UIView *)view;

+ (instancetype)photoBrowserWithView:(UIView *)view
						   imageList:(NSArray *)imgList
							   index:(NSInteger)index;

@end
