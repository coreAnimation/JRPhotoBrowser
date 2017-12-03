//
//  JRPhotoBrowser.m
//  JRPhotoBrowser
//
//  Created by wxiao on 2017/12/1.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import "JRPhotoBrowser.h"

@interface JRPhotoBrowser ()

@property (nonatomic, strong) UIImageView	*placeImageView;

@property (nonatomic, assign) CGRect	sourceFrame;

@property (nonatomic, strong) UIView	*sourceView;

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
	
	[self.view addSubview:self.placeImageView];
	
	CGFloat scal = (self.placeImageView.image.size.width / self.placeImageView.image.size.height);
	
	CGFloat w = [UIScreen mainScreen].bounds.size.width;
	CGFloat h = w / scal;
	CGFloat y = ([UIScreen mainScreen].bounds.size.height - h) * 0.5;
	
	CGRect frame = CGRectMake(0, y, w, h);
	
	[UIView animateWithDuration:3.3 animations:^{
		self.placeImageView.frame = frame;
	}];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	[UIView animateWithDuration:0.3 animations:^{
		self.placeImageView.frame = self.sourceFrame;
	}];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
