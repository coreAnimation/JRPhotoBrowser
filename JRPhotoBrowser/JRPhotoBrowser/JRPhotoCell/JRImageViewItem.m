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

@end


@implementation JRImageViewItem

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	[self setup];
	return self;
}

- (void)setup {
	///
	self.scrollView = [[JRZoomingScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
	self.scrollView.item = self;
	[self.contentView addSubview:self.scrollView];
}

- (void)setModel:(JRImageModel *)model {
	_model = model;
	
	if (model.thumbImage) {
		self.scrollView.image = model.thumbImage;
		
		if (model.urlString.length > 0) {
			NSURL *url = [NSURL URLWithString:model.urlString];
			
			/// 图片下载
			[[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
				
			} completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
				self.scrollView.image = image;
			}];
		}
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



