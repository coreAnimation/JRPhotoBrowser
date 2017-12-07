//
//  JRZoomingScrollView.h
//  JRPhotoBrowser
//
//  Created by 王潇 on 2017/12/4.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JRImageViewItem;
@interface JRZoomingScrollView : UIScrollView

@property (nonatomic, weak) JRImageViewItem	*item;

/// 设置图片
@property (nonatomic, strong) UIImage	*image;

/// 是否允许拖拽
@property (nonatomic, assign) BOOL	panIsAble;

/// 缩放
- (void)resetZoom;

@end
