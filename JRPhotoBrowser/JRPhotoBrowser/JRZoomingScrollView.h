//
//  JRZoomingScrollView.h
//  JRPhotoBrowser
//
//  Created by 王潇 on 2017/12/4.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRZoomingScrollView : UIScrollView

@property (nonatomic, strong) UIImage	*image;

- (void)resetZoom;

@end
