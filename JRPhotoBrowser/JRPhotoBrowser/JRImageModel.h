//
//  JRImageModel.h
//  JRPhotoBrowser
//
//  Created by 王潇 on 2017/12/4.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRImageModel : NSObject

@property (nonatomic, strong) UIImage	*thumbImage;

@property (nonatomic, strong) UIImage	*largeImage;

@property (nonatomic, strong) NSString	*imageName;

@property (nonatomic, strong) NSString	*urlString;

@property (nonatomic, strong) NSURL		*imageUrl;

@property (nonatomic, assign) CGFloat	progress;

@end
