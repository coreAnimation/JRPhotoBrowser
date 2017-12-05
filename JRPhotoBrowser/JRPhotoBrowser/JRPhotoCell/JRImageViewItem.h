//
//  JRImageViewItem.h
//  JRPhotoBrowser
//
//  Created by 王潇 on 2017/12/4.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JRImageModel;

@protocol JRImageViewItemDelegate <NSObject>

/// 关闭图片浏览器
- (void)closePhotoBrowerViewController;

@end

@interface JRImageViewItem : UICollectionViewCell

/// 模型
@property (nonatomic, strong) JRImageModel	*model;

/// 代理对象
@property (nonatomic, weak) id<JRImageViewItemDelegate>	delegate;

/// 重置缩放比例
- (void)resetScrollViewZoom;

/// 关闭控制器
- (void)closePhotoBrowerController;

@end
