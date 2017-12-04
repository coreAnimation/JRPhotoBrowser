//
//  JRImageViewItem.m
//  JRPhotoBrowser
//
//  Created by 王潇 on 2017/12/4.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import "JRImageViewItem.h"
#import "JRPhotoBrowerHeader.h"
#import "JRImageModel.h"

@interface JRImageViewItem () <UIScrollViewDelegate>

////
@property (nonatomic, strong) UIScrollView	*scrollView;
///
@property (nonatomic, strong) UIImageView	*imgView;

@property (nonatomic, assign) CGFloat		zoomScale;

@end


@implementation JRImageViewItem

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	[self setup];
	return self;
}

- (void)setup {
	
	///
	self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
	self.scrollView.delegate = self;
	self.scrollView.showsHorizontalScrollIndicator = NO;
	self.scrollView.showsVerticalScrollIndicator = NO;
	//设置最大放大倍数
	self.scrollView.minimumZoomScale = 1.0;
	self.scrollView.maximumZoomScale = 2.0;
	
	[self.contentView addSubview:self.scrollView];
	
	///
	self.imgView = [UIImageView new];
	[self.scrollView addSubview:self.imgView];
	self.imgView.backgroundColor = [UIColor orangeColor];
	
	self.imgView.contentMode = UIViewContentModeScaleAspectFit;
	//添加双击事件
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
																					   action:@selector(handleDoubleTap:)];
	[tap setNumberOfTapsRequired:2];
	[self.imgView addGestureRecognizer:tap];
	self.imgView.userInteractionEnabled = YES;
}

- (void)setModel:(JRImageModel *)model {
	_model = model;
	
	if (model.thumbImage) {
		
		CGFloat scale =  model.thumbImage.size.height / model.thumbImage.size.width;
		CGFloat h = SCREEN_W * scale;
		CGFloat y = (SCREEN_H - h) * 0.5;
		self.imgView.frame = CGRectMake(0, y, SCREEN_W, h);
//		self.scrollView.frame = CGRectMake(0, y, SCREEN_W, h);
//		self.imgView.frame = CGRectMake(0, 0, SCREEN_W, h);
		
		self.imgView.image = model.thumbImage;
		
		self.scrollView.backgroundColor = [UIColor grayColor];
	}
	
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return self.imgView;
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gesture {
	CGFloat zoomScale = self.zoomScale;
	zoomScale = (zoomScale == 1.0) ? 2.0 : 1.0;
	self.zoomScale = zoomScale;
	CGRect zoomRect = [self zoomRectForScale:zoomScale
								  withCenter:[gesture locationInView:gesture.view]];
	NSLog(@"================ %@", NSStringFromCGRect(zoomRect));
	[self.scrollView zoomToRect:zoomRect animated:YES];
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
	CGRect zoomRect;
	
//	let w = frame.size.width / scale
//	let h = frame.size.height / scale
//	let x = touchPoint.x - (h / max(UIScreen.main.scale, 2.0))
//	let y = touchPoint.y - (w / max(UIScreen.main.scale, 2.0))
	zoomRect.size.height =self.scrollView.frame.size.height / scale;
	zoomRect.size.width  =self.scrollView.frame.size.width  / scale;
	zoomRect.origin.x = center.x - (zoomRect.size.width  /2.0);
	zoomRect.origin.y = center.y - (zoomRect.size.height /2.0);
	
	zoomRect = CGRectMake(50, -250,  100, 100);
	
	return zoomRect;
}






@end
