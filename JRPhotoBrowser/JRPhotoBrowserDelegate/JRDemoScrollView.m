//
//  JRDemoScrollView.m
//  JRPhotoBrowser
//
//  Created by wxiao on 2017/12/5.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import "JRDemoScrollView.h"
#import "JRPhotoBrowerHeader.h"

@interface JRDemoScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView	*imgView;

@end

@implementation JRDemoScrollView


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
	[self.imgView addGestureRecognizer:tap];
	self.imgView.userInteractionEnabled = YES;
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gesture {

	CGFloat zoomScale = self.zoomScale;
	zoomScale = (zoomScale == 1.0) ? 2.0 : 1.0;
	CGRect zoomRect = [self zoomRectForScale:zoomScale
								  withCenter:[gesture locationInView:gesture.view]];
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

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
	CGFloat offsetX=0.0;
	CGFloat offsetY=0.0;
	if (scrollView.bounds.size.width> scrollView.contentSize.width){
		
		offsetX = (scrollView.bounds.size.width- scrollView.contentSize.width)/2;
	}
	if (scrollView.bounds.size.height> scrollView.contentSize.height){
		
		offsetY = (scrollView.bounds.size.height- scrollView.contentSize.height)/2;
	}
	
	self.imgView.center = CGPointMake(scrollView.contentSize.width/2+offsetX,scrollView.contentSize.height/2+offsetY);
}


- (void)setImage:(UIImage *)image {
	_image = image;
	
	self.imgView.image = image;
	CGFloat scale =  image.size.height / image.size.width;
	CGFloat h = SCREEN_W * scale;
	CGFloat y = (SCREEN_H - 64 - 49 - h) * 0.5;
	self.imgView.frame = CGRectMake(0, y, SCREEN_W, h);
}


@end
