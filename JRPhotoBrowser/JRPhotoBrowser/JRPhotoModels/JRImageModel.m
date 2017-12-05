//
//  JRImageModel.m
//  JRPhotoBrowser
//
//  Created by 王潇 on 2017/12/4.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import "JRImageModel.h"

@implementation JRImageModel


- (void)setImageName:(NSString *)imageName {
	_imageName = imageName;
	UIImage *image = [UIImage imageNamed:imageName];
	self.thumbImage = image;
}

@end
