//
//  SecondViewController.m
//  JRPhotoBrowser
//
//  Created by wxiao on 2017/12/5.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import "SecondViewController.h"
#import "JRPhotoBrowerHeader.h"
#import "JRDemoScrollView.h"

@interface SecondViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) JRDemoScrollView	*myScrollView;

@property (nonatomic, strong) UIScrollView	*scrollView;

@property (nonatomic, strong) UIImageView	*imgView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.automaticallyAdjustsScrollViewInsets = NO;
//	[self setup];
	[self setup2];
}

- (void)setup2 {
	
	CGRect frame = CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64 - 49);
	self.myScrollView = [[JRDemoScrollView alloc] initWithFrame:frame];
	self.myScrollView.contentSize = CGSizeMake(SCREEN_W, SCREEN_H - 64 - 49);
	self.myScrollView.minimumZoomScale = 1.0;
	self.myScrollView.maximumZoomScale = 4.0;
	self.myScrollView.backgroundColor = [UIColor orangeColor];
	[self.view addSubview:self.myScrollView];
	
	UIImage *image = [UIImage imageNamed:@"image10"];
	self.myScrollView.image = image;
	
}



- (void)setup {
	
	CGFloat margin = 20;
	CGFloat w = SCREEN_W - margin * 2;
	CGFloat y = (SCREEN_H - w) * 0.5;
	self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(margin, y, w, w)];
	self.scrollView.contentSize = CGSizeMake(w, w);
	self.scrollView.minimumZoomScale = 1.0;
	self.scrollView.maximumZoomScale = 4.0;
	self.scrollView.delegate = self;
	self.scrollView.backgroundColor = [UIColor yellowColor];
	[self.view addSubview:self.scrollView];
	
	
	UIImage *image = [UIImage imageNamed:@"image10"];
	CGFloat scale =  image.size.height / image.size.width;
	CGFloat h = w * scale;
	CGFloat yy = (w - h) * 0.5;
	
	self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, yy, w, h)];
	self.imgView.image = image;
	[self.scrollView addSubview:self.imgView];
	
	//添加双击事件
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
																		  action:@selector(handleDoubleTap:)];
	[tap setNumberOfTapsRequired:2];
	[self.scrollView addGestureRecognizer:tap];
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gesture {
	
	CGFloat zoomScale = self.scrollView.zoomScale;
	zoomScale = (zoomScale == 1.0) ? 2.0 : 1.0;
	CGRect zoomRect = [self zoomRectForScale:zoomScale
								  withCenter:[gesture locationInView:gesture.view]];
	[self.scrollView zoomToRect:zoomRect animated:YES];
}

///
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
	CGRect zoomRect;
	zoomRect.size.height =self.scrollView.frame.size.height / scale;
	zoomRect.size.width  =self.scrollView.frame.size.width  / scale;
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


@end
