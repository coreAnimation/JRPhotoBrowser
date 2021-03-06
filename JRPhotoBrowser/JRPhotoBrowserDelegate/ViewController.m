//
//  ViewController.m
//  JRPhotoBrowser
//
//  Created by 王潇 on 2017/12/1.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import "ViewController.h"
#import "JRPhotoBrowser.h"
#import "JRImageModel.h"

@interface ViewController ()

@property (nonatomic, strong) UIScrollView 	*scrollView;

@property (nonatomic, strong) UIView *imgView;

@property (nonatomic, strong) UIView *vvv2;

@property (nonatomic, strong) NSArray	*imgList;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.automaticallyAdjustsScrollViewInsets = NO;
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.imgList = @[@"image0",
					 @"image1",
					 @"image2",
					 @"image3",
					 @"image4",
					 @"image5",
					 @"image6",
					 @"image7",
					 @"image8",
					 @"image9",
					 @"image10",
					 @"image11",
					 @"image12",];

	CGFloat width = [UIScreen mainScreen].bounds.size.width;
	CGFloat height = [UIScreen mainScreen].bounds.size.height;
	self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, width, height - 64 - 49)];
	[self.view addSubview:self.scrollView];
	self.scrollView.backgroundColor = [UIColor redColor];
	
	[self setupView];
}

- (void)setupView {
	
	NSInteger numb = self.imgList.count;
	NSInteger count = 2;
	CGFloat width = [UIScreen mainScreen].bounds.size.width;
	CGFloat margin = 20;
	CGFloat margin2 = 10;
	CGFloat w = (width - margin * 2 - (count - 1) * margin2) / count;
	
	
	for (NSInteger i=0; i<numb; i++) {
	
		NSInteger line = i / count;
		NSInteger c = i % count;
		
		CGFloat x = margin + (margin2 + w) * c ;
		CGFloat y = margin + (margin2 + w) * line;
		
		UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, w)];
		imgView.contentMode = UIViewContentModeScaleAspectFill;
		imgView.clipsToBounds = YES;
		
		imgView.tag = i;
		[self.scrollView addSubview:imgView];
		imgView.image = [UIImage imageNamed:self.imgList[i]];
		
		imgView.userInteractionEnabled = YES;
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
																			  action:@selector(openVC:)];
		[imgView addGestureRecognizer:tap];
	}
	
	self.scrollView.contentSize = CGSizeMake(width, margin * 2
											 + (margin2 + w) * ceilf(numb / (CGFloat)count) - margin2);
}

- (void)openVC:(UITapGestureRecognizer *)gesture {
	UIImageView *sender = (UIImageView *)gesture.view;

	/// 1.
	NSMutableArray *models = [NSMutableArray arrayWithCapacity:self.imgList.count];
	
	///
	for (NSString *name in self.imgList) {
		JRImageModel *model = [JRImageModel new];
		model.imageName = name;
		model.thumbImage = [UIImage imageNamed:model.imageName];
		[models addObject:model];
	}
	
	/// 2.
	JRPhotoBrowser *vc = [JRPhotoBrowser photoBrowserWithView:sender
													imageList:models
														index:sender.tag];
	
	vc.horizontalPadding = 20;
//	vc.scrollTopCloseAble = NO;
	[self presentViewController:vc animated:YES completion:nil];
	
	
	
}

@end
