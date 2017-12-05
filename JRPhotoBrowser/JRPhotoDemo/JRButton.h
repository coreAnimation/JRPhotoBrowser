//
//  JRButton.h
//  JRPhotoBrowser
//
//  Created by wxiao on 2017/12/5.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

//UIControlStateNormal       = 0,
//UIControlStateHighlighted  = 1 << 0,                  // used when UIControl isHighlighted is set
//UIControlStateDisabled     = 1 << 1,
//UIControlStateSelected     = 1 << 2,                  // flag usable by app (see below)
//UIControlStateFocused NS_ENUM_AVAILABLE_IOS(9_0) = 1 << 3, // Applicable only when the screen supports focus
//UIControlStateApplication  = 0x00FF0000,              // additional flags available for application use
//UIControlStateReserved     = 0xFF000000               // flags reserved for internal framework use


@interface JRButton : UIControl

@property (nonatomic, strong) UIColor	*normalColor;

@property (nonatomic, strong) UIColor	*highlightedColor;

@property (nonatomic, strong) UIColor	*selectedColor;

//@property (nonatomic, strong) UIColor	*

@end
