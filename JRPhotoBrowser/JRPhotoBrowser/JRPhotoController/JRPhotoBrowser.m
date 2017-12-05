//
//  JRPhotoBrowser.m
//  JRPhotoBrowser
//
//  Created by wxiao on 2017/12/1.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import "JRPhotoBrowser.h"
#import "JRPhotoBrowerHeader.h"
#import "JRImageModel.h"
#import "JRImageViewItem.h"

@interface JRPhotoBrowser () <UICollectionViewDataSource, UICollectionViewDelegate>

/// 动画图片
@property (nonatomic, strong) UIImageView	*placeImageView;
/// frame
@property (nonatomic, assign) CGRect	sourceFrame;
/// 关闭按钮
@property (nonatomic, strong) UIButton	*closeBtn;

@property (nonatomic, strong) NSArray	*imageList;
@property (nonatomic, strong) NSArray<JRImageModel *> *imageModels;

@property (nonatomic, assign) NSInteger	currentIndex;

///
@property (nonatomic, strong) UICollectionView	*collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout	*layout;

@property (nonatomic, strong) UILabel		*pageNumber;

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

+ (instancetype)photoBrowserWithView:(UIView *)view
						   imageList:(NSArray *)imgList
							   index:(NSInteger)index {
	
	JRPhotoBrowser *pb = [JRPhotoBrowser photoBrowserWithView:view];
	
	pb.currentIndex = index;
	pb.imageList = imgList;
	
	[pb setupContenter];
	
	return pb;
}

- (void)setImageList:(NSArray *)imageList {
	_imageList = imageList;
	
	NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:imageList.count];
	
	for (NSString *name in imageList) {
		
		JRImageModel *model = [JRImageModel new];
		model.imageName = name;
		[mArray addObject:model];
	}
	self.imageModels = mArray;
}

///
- (void)setupContenter {
	
	/// collectionView
	self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
											 collectionViewLayout:self.layout];
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	self.collectionView.pagingEnabled = YES;
	self.collectionView.backgroundColor = [UIColor whiteColor];
	[self.collectionView registerClass:[JRImageViewItem class] forCellWithReuseIdentifier:@"item"];
	[self.view insertSubview:self.collectionView belowSubview:self.closeBtn];
	
	/// Page
	self.pageNumber = ({
		UILabel *label 		= [[UILabel alloc] initWithFrame:CGRectMake(20, SCREEN_H - 50, 50, 20)];
		label.font 			= [UIFont systemFontOfSize:11];
		label.textColor 	= [UIColor redColor];
		label.textAlignment = NSTextAlignmentLeft;
		label.backgroundColor = [UIColor yellowColor];
		[self.view addSubview:label];
		label;
	});
	
	self.pageNumber.text = [NSString stringWithFormat:@"%zd/%zd", self.currentIndex, self.imageList.count];
	self.collectionView.alpha = 0;
	
//	// 3. 手势
//	// 3.1 单击手势
//	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
//																		  action:@selector(closeAct)];
////	tap.delegate = self;
//	[self.view addGestureRecognizer:tap];
//	// 3.2 双击手势
//	UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self
//																		   action:@selector(doubleTap:)];
//	tap2.delegate = self;
//	tap2.numberOfTapsRequired = 2;
//	// 指定双击失败触发单击
//	[tap requireGestureRecognizerToFail: tap2];
//	[self addGestureRecognizer:tap2];
//	// 3.2 长按手势
//	UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc] initWithTarget:self
//																						action:@selector(longPress:)];
//	press.minimumPressDuration = 0.8; //定义按的时间
//	press.numberOfTouchesRequired = 1;
//	press.delegate = self;
//	[self addGestureRecognizer:press];
}


#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.imageModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
				  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	JRImageViewItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item"
																		   forIndexPath:indexPath];
	cell.model = self.imageModels[indexPath.row];
	return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	CGFloat x = scrollView.contentOffset.x;
	
	NSInteger index = (x + SCREEN_W * 0.5) / SCREEN_W;
	
	self.pageNumber.text = [NSString stringWithFormat:@"%zd/%zd", index, self.imageList.count];
}

- (void)collectionView:(UICollectionView *)collectionView
	   willDisplayCell:(UICollectionViewCell *)cell
	forItemAtIndexPath:(NSIndexPath *)indexPath {
	
}

- (void)collectionView:(UICollectionView *)collectionView
  				didEndDisplayingCell:(UICollectionViewCell *)cell
				forItemAtIndexPath:(NSIndexPath *)indexPath {
	JRImageViewItem *item = (JRImageViewItem *)cell;
	[item resetScrollViewZoom];
}

/// 初始化 开启动画
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
	self.closeBtn.backgroundColor = [UIColor orangeColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self.view addSubview:self.placeImageView];
	
	CGFloat scal = (self.placeImageView.image.size.width / self.placeImageView.image.size.height);
	
	CGFloat w = [UIScreen mainScreen].bounds.size.width;
	CGFloat h = w / scal;
	CGFloat y = ([UIScreen mainScreen].bounds.size.height - h) * 0.5;
	
	
	if (y < 0) { y = 0; }
	CGRect frame = CGRectMake(0, y, w, h);
	
	[UIView animateWithDuration:.3 animations:^{
		self.placeImageView.frame = frame;
	}completion:^(BOOL finished) {
		self.collectionView.alpha = 1;
	}];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	if ([self.collectionView numberOfItemsInSection:0] > self.currentIndex) {
		
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
		
		[self.collectionView scrollToItemAtIndexPath:indexPath
									atScrollPosition:UICollectionViewScrollPositionNone
											animated:NO];
	}
	
	self.placeImageView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[UIView animateWithDuration:0.3 animations:^{
		self.placeImageView.frame = self.sourceFrame;
	}];
}

- (void)closeAct {
	self.placeImageView.image = [self.imageModels[self.currentIndex] thumbImage];
	self.placeImageView.hidden = NO;
	[UIView animateWithDuration:0.3 animations:^{
		self.placeImageView.frame = self.sourceFrame;
	}];
	[self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -
- (UICollectionViewFlowLayout *)layout {
	if (_layout) {
		return _layout;
	}
	
	_layout = [[UICollectionViewFlowLayout alloc] init];
	_layout.itemSize = [UIScreen mainScreen].bounds.size;
	_layout.minimumLineSpacing = 0;
	_layout.minimumInteritemSpacing = 0;
	_layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
	
	return _layout;
}

@end