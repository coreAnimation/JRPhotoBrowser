//
//  JRZoomingScrollView.m
//  JRPhotoBrowser
//
//  Created by 王潇 on 2017/12/4.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import "JRZoomingScrollView.h"
#import "JRPhotoBrowerHeader.h"

@interface JRZoomingScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView	*imgView;

@end

@implementation JRZoomingScrollView

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	[self setup];
	return self;
}

- (void)setup {
	
	self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_W)];
	[self addSubview:self.imgView];
	self.delegate = self;
	self.minimumZoomScale = 1.0;
	self.maximumZoomScale = 2.0;
	
	//添加双击事件
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
																		  action:@selector(handleDoubleTap:)];
	[tap setNumberOfTapsRequired:2];
	[self.imgView addGestureRecognizer:tap];
	self.imgView.userInteractionEnabled = YES;
}


- (void)handleDoubleTap:(UIGestureRecognizer *)gesture {
	CGFloat zoomScale = self.zoomScale;
	zoomScale = (zoomScale == 1.0) ? 2.0 : 1.0;
	self.zoomScale = zoomScale;
	CGRect zoomRect = [self zoomRectForScale:zoomScale
								  withCenter:[gesture locationInView:gesture.view]];
	NSLog(@"================ %@", NSStringFromCGRect(zoomRect));
	[self zoomToRect:zoomRect animated:YES];
}

///
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
	CGRect zoomRect;
	zoomRect.size.height =self.frame.size.height / scale;
	zoomRect.size.width  =self.frame.size.width  / scale;
	zoomRect.origin.x = center.x - (zoomRect.size.width  /2.0);
	zoomRect.origin.y = center.y - (zoomRect.size.height /2.0);
	
	return zoomRect;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return self.imgView;
}


- (void)setImage:(UIImage *)image {
	_image = image;
	
	self.imgView.image = image;
	CGFloat scale =  image.size.height / image.size.width;
	CGFloat h = SCREEN_W * scale;
	CGFloat y = (SCREEN_H - h) * 0.5;
	self.imgView.frame = CGRectMake(0, y, SCREEN_W, h);
}

@end
