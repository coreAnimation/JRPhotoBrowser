//
//  JRPhotoBrowser.m
//  JRPhotoBrowser
//
//  Created by wxiao on 2017/12/1.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import "JRPhotoBrowser.h"

@interface JRPhotoBrowser ()

/// 动画图片
@property (nonatomic, strong) UIImageView	*placeImageView;

@property (nonatomic, assign) CGRect	sourceFrame;

@property (nonatomic, strong) UIView	*sourceView;

/// 关闭按钮
@property (nonatomic, strong) UIButton	*closeBtn;

@end

@implementation JRPhotoBrowser

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	[self setup];
	return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	[self setup];
	return self;
}

+ (instancetype)photoBrowserWithView:(UIView *)view {

	JRPhotoBrowser *pb = [JRPhotoBrowser new];
	pb.fromView = view;
	pb.sourceView = view;
	return pb;
}

- (void)setFromView:(UIView *)fromView {
	
	self.sourceFrame = [fromView.superview convertRect:fromView.frame toView:self.view];
	self.placeImageView = [[UIImageView alloc] initWithFrame:self.sourceFrame];
	self.placeImageView.contentMode = UIViewContentModeScaleAspectFill;
	self.placeImageView.clipsToBounds = YES;
	if ([fromView isKindOfClass:[UIImageView class]]) {
		self.placeImageView.image = ((UIImageView *)fromView).image;
	}
}

- (void)setup {
	/// 初始化
	self.view.opaque = NO;
	self.modalPresentationCapturesStatusBarAppearance = true;
	self.modalPresentationStyle = UIModalPresentationCustom;
	self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	
	/// 关闭按钮
	self.closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 40, 25)];
	[self.view addSubview:self.closeBtn];
	[self.closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
	[self.closeBtn addTarget:self action:@selector(closeAct) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor cyanColor];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self.view addSubview:self.placeImageView];
	
	CGFloat scal = (self.placeImageView.image.size.width / self.placeImageView.image.size.height);
	
	CGFloat w = [UIScreen mainScreen].bounds.size.width;
	CGFloat h = w / scal;
	CGFloat y = ([UIScreen mainScreen].bounds.size.height - h) * 0.5;
	
	CGRect frame = CGRectMake(0, y, w, h);
	
	[UIView animateWithDuration:.3 animations:^{
		self.placeImageView.frame = frame;
	}];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	[UIView animateWithDuration:0.3 animations:^{
		self.placeImageView.frame = self.sourceFrame;
	}];
}


- (void)closeAct {
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
