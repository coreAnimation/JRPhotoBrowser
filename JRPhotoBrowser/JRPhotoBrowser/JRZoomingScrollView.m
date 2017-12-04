//
//  JRZoomingScrollView.m
//  JRPhotoBrowser
//
//  Created by 王潇 on 2017/12/4.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import "JRZoomingScrollView.h"

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
	
	self.delegate = self;
}

@end
