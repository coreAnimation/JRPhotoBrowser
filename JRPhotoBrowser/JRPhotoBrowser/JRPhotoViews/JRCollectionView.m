//
//  JRCollectionView.m
//  JRPhotoBrowser
//
//  Created by 王潇 on 2017/12/5.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import "JRCollectionView.h"

@implementation JRCollectionView

- (void)setFrame:(CGRect)frame {
	[super setFrame:frame];
	CGFloat h = fabs(frame.origin.y);

	CGFloat alpha = h / 300.0;
	self.superview.backgroundColor = [UIColor colorWithWhite:0 alpha:1 - alpha];
	
}

@end
