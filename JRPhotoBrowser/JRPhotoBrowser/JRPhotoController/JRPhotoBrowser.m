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
#import "JRZoomingScrollView.h"

@interface JRPhotoBrowser () <UICollectionViewDataSource, UICollectionViewDelegate,
								JRImageViewItemDelegate, UIGestureRecognizerDelegate>

/// 动画图片
@property (nonatomic, strong) UIImageView	*placeImageView;
/// frame
@property (nonatomic, assign) CGRect	sourceFrame;
/// 关闭按钮
@property (nonatomic, strong) UIButton	*closeBtn;

//@property (nonatomic, strong) NSArray	*imageList;
@property (nonatomic, strong) NSArray<JRImageModel *> *imageModels;

@property (nonatomic, assign) NSInteger	currentIndex;

///
@property (nonatomic, strong) JRCollectionView	*collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout	*layout;

@property (nonatomic, strong) UILabel		*pageNumber;

@property (nonatomic, assign) CGFloat		offSetY;

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
//	pb.imageList = imgList;
	pb.imageModels = imgList;
	[pb setupContenter];
	return pb;
}

//- (void)setImageList:(NSArray *)imageList {
//	_imageList = imageList;
//	
//	NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:imageList.count];
//	
//	for (NSString *name in imageList) {
//		
//		JRImageModel *model = [JRImageModel new];
//		model.imageName = name;
//		[mArray addObject:model];
//	}
//	self.imageModels = mArray;
//}

///
- (void)setupContenter {
	
	/// collectionView
	self.collectionView = [[JRCollectionView alloc] initWithFrame:self.view.bounds
											 collectionViewLayout:self.layout];
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	self.collectionView.pagingEnabled = YES;
	self.collectionView.backgroundColor = [UIColor clearColor];
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
	
	self.pageNumber.text = [NSString stringWithFormat:@"%zd/%zd",
							self.currentIndex, self.imageModels.count];
	
	self.collectionView.alpha = 0;
	
	// 拖动
	UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self
																		  action:@selector(panAction:)];
	[self.view addGestureRecognizer:pan];
}

/// 拖拽方法
- (void)panAction:(UIPanGestureRecognizer *)gesture {
	
	JRImageViewItem *item = self.collectionView.visibleCells.firstObject;
	
	CGPoint point = [gesture locationInView:self.view];
	CGFloat offSetY = point.y;
	switch (gesture.state) {
		case UIGestureRecognizerStateBegan:
			self.offSetY = offSetY;
			break;
			
		case UIGestureRecognizerStateChanged: {
			CGFloat add = offSetY - self.offSetY;
			self.offSetY = offSetY;
			
			if ( add > 0 && CGPointEqualToPoint(item.scrollView.contentOffset, CGPointZero)) {
				self.collectionView.y = self.collectionView.y + add;
			}
			
			if (add < 0 && item.scrollView.contentSize.height - 1 <= item.scrollView.frame.size.height + item.scrollView.contentOffset.y) {
				self.collectionView.y = self.collectionView.y + add;
			}
		}
			break;
			
		case UIGestureRecognizerStateFailed:
		case UIGestureRecognizerStateEnded:
		case UIGestureRecognizerStateCancelled: {
			CGFloat centerY = self.collectionView.centerY;
			[self operationWithCenterY:centerY];
		}
			break;
		default:
			break;
	}
}

- (void)operationWithCenterY:(CGFloat)centerY {
	CGFloat half = SCREEN_H * 0.333;
	if (half < centerY && centerY < half * 2) {
		[UIView animateWithDuration:0.2 animations:^{
			self.collectionView.y = 0;
		}];
	} else {
		if (self.collectionView.y > 0) {
			[UIView animateWithDuration:0.3 animations:^{
				self.collectionView.y = SCREEN_H;
			} completion:^(BOOL finished) {
				[self dismissViewControllerAnimated:NO completion:nil];
			}];
		} else {
			[UIView animateWithDuration:0.3 animations:^{
				self.collectionView.y = -SCREEN_H;
			} completion:^(BOOL finished) {
				[self dismissViewControllerAnimated:NO completion:nil];
			}];
		}
		
	}
}


#pragma mark - Controller Method
/// 隐藏状态栏
- (BOOL)prefersStatusBarHidden {
	return YES;
}

#pragma mark - JRImageViewItemDelegate
- (void)closePhotoBrowerViewController {
	[self closeAct];
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView
	 numberOfItemsInSection:(NSInteger)section {
	return self.imageModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
				  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	JRImageViewItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item"
																		   forIndexPath:indexPath];
	cell.delegate = self;
	cell.model = self.imageModels[indexPath.row];
	return cell;
}

///
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	CGFloat x = scrollView.contentOffset.x;
	
	NSInteger index = (x + SCREEN_W * 0.5) / SCREEN_W;
	
	self.pageNumber.text = [NSString stringWithFormat:@"%zd/%zd",
							index, self.imageModels.count];
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
	self.view.backgroundColor = [UIColor blackColor];
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
	
	self.view.userInteractionEnabled = NO;
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
