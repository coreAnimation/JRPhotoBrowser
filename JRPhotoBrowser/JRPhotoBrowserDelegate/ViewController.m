//
//  ViewController.m
//  JRPhotoBrowser
//
//  Created by 王潇 on 2017/12/1.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import "ViewController.h"
#import "JRPhotoBrowser.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *imgView;

@property (nonatomic, strong) UIView *vvv2;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
	self.imgView.userInteractionEnabled = YES;
	self.imgView.backgroundColor = [UIColor orangeColor];
	[self.view addSubview:self.imgView];
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openVC)];
	[self.imgView addGestureRecognizer:tap];
	
	
	
}

- (void)openVC {
//	JRPhotoBrowser *vc = [JRPhotoBrowser new];
	JRPhotoBrowser *vc = [JRPhotoBrowser photoBrowserWithView:self.imgView];
	[self presentViewController:vc animated:YES completion:nil];
}

@end
