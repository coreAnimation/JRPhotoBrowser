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
#import "JRZoomingScrollView.h"


@interface JRImageProgressView ()

@end


@implementation JRImageProgressView

@end


@interface JRImageViewItem ()

///
@property (nonatomic, strong) UIImageView	*imgView;

@property (nonatomic, assign) CGFloat		zoomScale;

@property (nonatomic, assign) CGRect		myFrame;

@end


@implementation JRImageViewItem

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	self.myFrame = frame;
	[self setup];
	return self;
}

- (void)setup {
	///
	CGFloat x = (self.myFrame.size.width - SCREEN_W) * 0.5;
	self.scrollView = [[JRZoomingScrollView alloc] initWithFrame:CGRectMake(x, 0, SCREEN_W, SCREEN_H)];
	self.scrollView.item = self;
	[self.contentView addSubview:self.scrollView];
}

- (void)setModel:(JRImageModel *)model {
	_model = model;
	
	if (model.thumbImage) {
		self.scrollView.image = model.thumbImage;
	} else {
		self.scrollView.image = [UIImage imageNamed:@"error"];
	}
	
	if (model.urlString.length > 0) {
		NSURL *url = [NSURL URLWithString:model.urlString];
		
		/// 图片下载
		[[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
			
		} completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
			if (image) {
				self.scrollView.image = image;
			}
		}];
	}
}

- (void)resetScrollViewZoom {
	[self.scrollView resetZoom];
}

/// 关闭图片浏览器
- (void)closePhotoBrowerController {
	if ([self.delegate respondsToSelector:@selector(closePhotoBrowerViewController)]) {
		[self.delegate closePhotoBrowerViewController];
	}
}

@end



