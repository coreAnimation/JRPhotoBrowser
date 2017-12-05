//
//  JRZoomingScrollView.h
//  JRPhotoBrowser
//
//  Created by 王潇 on 2017/12/4.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRZoomingScrollView : UIScrollView

/// 设置图片
@property (nonatomic, strong) UIImage	*image;

/// 缩放
- (void)resetZoom;

@end