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
	self.decelerationRate = UIScrollViewDecelerationRateFast;
	
	//添加双击事件
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
																		  action:@selector(handleDoubleTap:)];
	[tap setNumberOfTapsRequired:2];
	[self addGestureRecognizer:tap];
	self.imgView.userInteractionEnabled = YES;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
//	NSLog(@"---- %@", NSStringFromCGRect(self.imgView.frame));
//	self.imgView.center = CGPointMake(SCREEN_W * 0.5, SCREEN_H * 0.5);
	
//	CGSize boundsSize = self.bounds.size;
//	CGRect frameToCenter = self.imgView.frame;
//
//	// horizon
//	if (frameToCenter.size.width < boundsSize.width) {
//		frameToCenter.origin.x = floor((boundsSize.width - frameToCenter.size.width) / 2);
//	} else {
//		frameToCenter.origin.x = 0;
//	}
//	// vertical
//	if (frameToCenter.size.height < boundsSize.height) {
//		frameToCenter.origin.y = floor((boundsSize.height - frameToCenter.size.height) / 2);
//	} else {
//		frameToCenter.origin.y = 0;
//	}
//
//	// Center
//
//
//	if (!CGRectEqualToRect(self.imgView.frame, frameToCenter)) {
//		self.imgView.frame = frameToCenter;
//		NSLog(@"======---- %@", NSStringFromCGRect(frameToCenter));
//	}
	
//	self.imgView.center = CGPointMake(SCREEN_W * 0.5, SCREEN_H * 0.5);
}


- (void)handleDoubleTap:(UIGestureRecognizer *)gesture {
	
	NSLog(@"A------ %@", NSStringFromCGSize(self.contentSize));
	
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
//	zoomRect.size.height =self.frame.size.height / scale;
//	zoomRect.size.width  =self.frame.size.width  / scale;
//	zoomRect.origin.x = center.x - (zoomRect.size.width  /2.0);
//	zoomRect.origin.y = center.y - (zoomRect.size.height /2.0);
//
//	CGFloat newZoomScale = self.maximumZoomScale;
//	CGFloat xsize = self.frame.size.width / newZoomScale;
//	CGFloat ysize = self.frame.size.height / newZoomScale;
//	zoomRect = CGRectMake(center.x - xsize/2, center.y - ysize/2, xsize, ysize);
	
	zoomRect = CGRectMake(-50, -50, 100, 100);
	
//	if (scale == 2) {
////		zoomRect = CGRectMake(50, 50, 100, 100);
//	} else {
//		UIImage *image = self.imgView.image;
//		CGFloat scale =  image.size.height / image.size.width;
//		CGFloat h = SCREEN_W * scale;
//		zoomRect = CGRectMake(0, 0, SCREEN_W, h);
//	}
	
	return zoomRect;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return self.imgView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
	
	NSLog(@"AAAAAAAAAAAAAASD %@", NSStringFromCGRect(self.imgView.frame));
	NSLog(@"AAAAAAAAAAAAAASD %@", NSStringFromCGSize(self.contentSize));
	
//	self.imgView.center = CGPointMake(SCREEN_W * 0.5, SCREEN_H * 0.5);
	
//	CGRect f = CGRectMake(0, 0, self.imgView.frame.size.width, self.imgView.frame.size.height);
//	self.imgView.frame = f;
	
//	[self setNeedsLayout];
//	[self layoutIfNeeded];

//	UIView *subView = self.imgView;
//
//	CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
//	(scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
//
//	CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
//	(scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
//
//	subView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
//								 scrollView.contentSize.height * 0.5 + offsetY);
	
	
//	CGSize boundsSize = self.bounds.size;
//	CGRect frameToCenter = self.imgView.frame;
//
//	// horizon
//	if (frameToCenter.size.width < boundsSize.width) {
//		frameToCenter.origin.x = floor((boundsSize.width - frameToCenter.size.width) / 2);
//	} else {
//		frameToCenter.origin.x = 0;
//	}
//	// vertical
//	if (frameToCenter.size.height < boundsSize.height) {
//		frameToCenter.origin.y = floor((boundsSize.height - frameToCenter.size.height) / 2);
//	} else {
//		frameToCenter.origin.y = 0;
//	}
//
//	// Center
//
//
//	if (!CGRectEqualToRect(self.imgView.frame, frameToCenter)) {
//		self.imgView.frame = frameToCenter;
//		NSLog(@"======---- %@", NSStringFromCGRect(frameToCenter));
//	}
	
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
