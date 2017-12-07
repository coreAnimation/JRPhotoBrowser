//
//  JRTestController.m
//  JRPhotoBrowser
//
//  Created by wxiao on 2017/12/5.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import "JRTestController.h"
#import "JRPhotoBrowerHeader.h"
#import "JRPhotoBrowser.h"
#import "JRImageModel.h"

@interface JRTestController ()

@property (nonatomic, strong) NSArray	*imgList;

@property (nonatomic, strong) UIScrollView	*scrollView;

@end

@implementation JRTestController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64,
												SCREEN_W, SCREEN_H - 64 - 49)];
	[self.view addSubview:self.scrollView];

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
		NSDictionary *dic = self.imgList[i];
		imgView.image = [UIImage imageNamed:dic[@"name"]];
		
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
	//	JRPhotoBrowser *vc = [JRPhotoBrowser photoBrowserWithView:sender];
	
	NSMutableArray *models = [NSMutableArray arrayWithCapacity:self.imgList.count];
	
	///
	for (NSDictionary *dict in self.imgList) {
		JRImageModel *model = [JRImageModel new];
		model.imageName = dict[@"name"];
		model.urlString = dict[@"url"];
		model.thumbImage = [UIImage imageNamed:model.imageName];
		[models addObject:model];
	}
	
	/// 2.
	JRPhotoBrowser *vc = [JRPhotoBrowser photoBrowserWithView:sender
													imageList:models//self.imgList
														index:sender.tag];
	
	
	[self presentViewController:vc animated:YES completion:nil];
	
	
	
}

- (NSArray *)imgList {
	if (_imgList) {
		return _imgList;
	}
	
	_imgList = @[
				 @{
					@"name" : @"m0",
					@"url"  : @"https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2498939097.jpg",
				   },
				 @{
					 @"name" : @"m1",
					 @"url"  : @"https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2503066429.jpg",
					 },
				 @{
					 @"name" : @"m2",
					 @"url"  : @"https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2502989170.jpg",
					 },
				 @{
					 @"name" : @"m3",
					 @"url"  : @"https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2500806009.jpg",
					 },
				 @{
					 @"name" : @"m4",
					 @"url"  : @"https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2500806009.jpg",
					 },
				 @{
					 @"name" : @"m5",
					 @"url"  : @"https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2502853643.jpg",
					 },
				 
				 @{
					 @"name" : @"m6",
					 @"url"  : @"https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2502557574.jpg",
					 },
				 ];
	
	return _imgList;
}


@end
