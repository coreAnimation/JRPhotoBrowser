//
//  JRPhotoBrowser.m
//  JRPhotoBrowser
//
//  Created by wxiao on 2017/12/1.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import "JRPhotoBrowser.h"

@interface JRPhotoBrowser ()

@property (nonatomic, strong) UIView	*fromView;

@property (nonatomic, assign) CGRect	sourceFrame;

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
	return pb;
}

- (void)setFromView:(UIView *)fromView {
	self.sourceFrame = fromView.frame;
	_fromView = [[UIView alloc] initWithFrame:fromView.frame];
	_fromView.backgroundColor = [UIColor redColor];
}

- (void)setup {
	self.view.opaque = NO;
	self.modalPresentationCapturesStatusBarAppearance = true;
	self.modalPresentationStyle = UIModalPresentationCustom;
	self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor cyanColor];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self.view addSubview:self.fromView];
	
	CGFloat w = [UIScreen mainScreen].bounds.size.width;
	CGFloat h = [UIScreen mainScreen].bounds.size.height;
	CGFloat y = (h - w) * 0.5;
	
	CGRect frame = CGRectMake(0, y, w, w);
	
	[UIView animateWithDuration:0.3 animations:^{
		self.fromView.frame = frame;
	}];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	[UIView animateWithDuration:0.3 animations:^{
		self.fromView.frame = self.sourceFrame;
	}];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
