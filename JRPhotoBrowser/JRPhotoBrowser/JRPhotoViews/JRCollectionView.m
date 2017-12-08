//
//  JRCollectionView.m
//  JRPhotoBrowser
//
//  Created by 王潇 on 2017/12/5.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import "JRCollectionView.h"

@interface JRCollectionView () <UIGestureRecognizerDelegate>

@end

@implementation JRCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
//	self.panGestureRecognizer.delegate = self;
	return self;
}

/// 手势冲突
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
//shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//
//
////	if ([otherGestureRecognizer.view isEqual:self]) {
////		return NO;
////		NSLog(@"---------111AAA");
////	} else {
////		NSLog(@"---------222BBBB");
////
////	}
//
//	NSLog(@"%@ \n%@\n\n\n\n", gestureRecognizer.view, otherGestureRecognizer.view);
//
//	return YES;
//}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//	NSLog(@"--- %@", touch.view);
//	NSLog(@"=== %@", touch.view);
//
//	return YES;
//}
//
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//	NSLog(@"--- %@", gestureRecognizer.view);
//	NSLog(@"=== %@", gestureRecognizer.view);
//
//	return YES;
//}

- (void)setFrame:(CGRect)frame {
	[super setFrame:frame];
	CGFloat h = fabs(frame.origin.y);

	CGFloat alpha = h / 300.0;
	self.superview.backgroundColor = [UIColor colorWithWhite:0 alpha:1 - alpha];
	
}

@end
