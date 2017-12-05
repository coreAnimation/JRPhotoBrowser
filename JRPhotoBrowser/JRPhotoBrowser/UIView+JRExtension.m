//
//  UIView+JRExtension.m
//  ZHCircle
//
//  Created by wxiao on 2017/11/22.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import "UIView+JRExtension.h"

@implementation UIView (JRExtension)


- (CGFloat)max_x {
	CGFloat x = self.frame.origin.x;
	CGFloat width = self.frame.size.width;
	return x + width;
}

- (void)setMax_x:(CGFloat)max_x {
	
}

- (CGFloat)max_y {
	CGFloat y = self.frame.origin.y;
	CGFloat height = self.frame.size.height;
	return y + height;
}

- (void)setMax_y:(CGFloat)max_y {
	
}

- (CGFloat)y {
	return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
	CGRect frame = self.frame;
	frame.origin.y = y;
	self.frame = frame;
}




- (CGFloat)centerX {
	return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
	self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
	return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
	self.center = CGPointMake(self.center.x, centerY);
}

@end
