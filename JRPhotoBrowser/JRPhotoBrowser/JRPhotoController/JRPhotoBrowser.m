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
/// 图片模型数组
@property (nonatomic, strong) NSArray<JRImageModel *> *imageModels;
/// 当前显示图片索引
@property (nonatomic, assign) NSInteger	currentIndex;
/// 图片浏览器容器
@property (nonatomic, strong) JRCollectionView	*collectionView;
/// 图片浏览器布局
@property (nonatomic, strong) UICollectionViewFlowLayout	*layout;
/// 页码显示
@property (nonatomic, strong) UILabel		*pageNumber;
/// 收拾位置
@property (nonatomic, assign) CGFloat		offSetY;

@end

@implementation JRPhotoBrowser

#pragma mark - Init Method
/// 初始化
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	[self setup];
	return self;
}

/// 初始化
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	[self setup];
	return self;
}

/// 构造方法
+ (instancetype)photoBrowserWithView:(UIView *)view {
	JRPhotoBrowser *pb = [JRPhotoBrowser new];
	pb.fromView = view;
	return pb;
}

/// 构造方法
+ (instancetype)photoBrowserWithView:(UIView *)view
						   imageList:(NSArray *)imgList
							   index:(NSInteger)index {
	JRPhotoBrowser *pb = [JRPhotoBrowser photoBrowserWithView:view];
	pb.currentIndex = index;
	pb.imageModels = imgList;
	return pb;
}

#pragma mark - 内置方法
///
- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	[self setupCloseButton];
	[self setupContenterView];
	[self setupPageNumberView];
	
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
		self.placeImageView.hidden = YES;
	}];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	//
	//	if ([self.collectionView numberOfItemsInSection:0] > self.currentIndex) {
	//
	//		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
	//
	//		[self.collectionView scrollToItemAtIndexPath:indexPath
	//									atScrollPosition:UICollectionViewScrollPositionNone
	//											animated:NO];
	//	}
	
	//	self.placeImageView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[UIView animateWithDuration:0.3 animations:^{
		self.placeImageView.frame = self.sourceFrame;
	}];
}

#pragma mark - 初始化UI

/// 初始化界面
- (void)setup {
	/// 初始化
	self.horizontalPadding = self.horizontalPadding == 0 ? 10 : self.horizontalPadding;
	self.scrollTopCloseAble = YES;
	self.scrollCloseAble = YES;
	
	self.view.opaque = NO;
	self.modalPresentationCapturesStatusBarAppearance = true;
	self.modalPresentationStyle = UIModalPresentationCustom;
	self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
}

/// 图片浏览器内容
- (void)setupContenterView {
	
	CGRect frame = CGRectMake(-self.horizontalPadding, 0,
							  SCREEN_W + self.horizontalPadding * 2, SCREEN_H);
	/// collectionView
	self.collectionView = [[JRCollectionView alloc] initWithFrame:frame
											 collectionViewLayout:self.layout];
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	self.collectionView.pagingEnabled = YES;
	self.collectionView.backgroundColor = [UIColor clearColor];
	[self.collectionView registerClass:[JRImageViewItem class]
			forCellWithReuseIdentifier:@"item"];
	[self.view insertSubview:self.collectionView belowSubview:self.closeBtn];
	
	
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
	[self.collectionView scrollToItemAtIndexPath:indexPath
								atScrollPosition:UICollectionViewScrollPositionNone
										animated:NO];

	self.collectionView.alpha = 0;
	
	// 拖动
	UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self
																		  action:@selector(panAction:)];
	pan.maximumNumberOfTouches = 1;
	pan.maximumNumberOfTouches = 1;
	pan.delegate = self;
	[self.view addGestureRecognizer:pan];
}

/// 初始化图片页标
- (void)setupPageNumberView {
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
}

/// 初始化 关闭按钮
- (void)setupCloseButton {
	/// 关闭按钮
	self.closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 40, 25)];
	[self.view addSubview:self.closeBtn];
	[self.closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
	[self.closeBtn addTarget:self action:@selector(closeAct) forControlEvents:UIControlEventTouchUpInside];
	self.closeBtn.backgroundColor = [UIColor orangeColor];
}

/// 拖拽方法
- (void)panAction:(UIPanGestureRecognizer *)gesture {
	
	JRImageViewItem *item = self.collectionView.visibleCells.firstObject;
	
	CGPoint point = [gesture locationInView:self.view];
	CGFloat offSetY = point.y;
	switch (gesture.state) {
		case UIGestureRecognizerStateBegan:
			self.offSetY = offSetY;
			self.collectionView.scrollEnabled = NO;
			break;
			
		case UIGestureRecognizerStateChanged: {
			CGFloat add = offSetY - self.offSetY;
			self.offSetY = offSetY;

			/// collectionView 拖拽
			if (!item.scrollView.panIsAble) {
				self.collectionView.y = self.collectionView.y + add;
			} else {
				self.collectionView.y = 0;
			}
			
			CGFloat offset = fabs(self.collectionView.y);
			CGFloat scale = 1 - offset / (SCREEN_H * 0.5);
			NSLog(@"------------- %f - %f", offset, scale);
			
		}
			break;
			
		case UIGestureRecognizerStateFailed:
		case UIGestureRecognizerStateEnded:
		case UIGestureRecognizerStateCancelled: {
			CGFloat centerY = self.collectionView.centerY;
			self.collectionView.scrollEnabled = YES;
			[self operationWithCenterY:centerY];
		}
			break;
		default:
			break;
	}
}

/// 滑动处理
- (void)operationWithCenterY:(CGFloat)centerY {
	CGFloat half = SCREEN_H * 0.3;
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


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
	
	UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
	
	CGPoint velocity = [pan velocityInView:self.view];  //pan.velocity(in: self)
	// 向上滑动时，不响应手势
	if (velocity.y < 0 && self.scrollTopCloseAble == NO) {
		return NO;
	}
	if (!self.scrollCloseAble) {
		return NO;
	}

	return YES;
}

#pragma mark - JRImageViewItemDelegate
/// 关闭浏览器
- (void)closePhotoBrowerViewController {
	[self closeAct];
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate
/// 图片数量
- (NSInteger)collectionView:(UICollectionView *)collectionView
	 numberOfItemsInSection:(NSInteger)section {
	return self.imageModels.count;
}

/// 图片Item
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

///
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

/// 关闭操作
- (void)closeAct {
	
	self.view.userInteractionEnabled = NO;
	self.placeImageView.image = [self.imageModels[self.currentIndex] thumbImage];
	self.placeImageView.hidden = NO;
	[UIView animateWithDuration:0.3 animations:^{
		self.placeImageView.frame = self.sourceFrame;
	}];
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 懒加载
- (UICollectionViewFlowLayout *)layout {
	if (_layout) {
		return _layout;
	}
	
	_layout = [[UICollectionViewFlowLayout alloc] init];
	_layout.itemSize = CGSizeMake(SCREEN_W + self.horizontalPadding * 2, SCREEN_H);
	_layout.minimumLineSpacing = 0;
	_layout.minimumInteritemSpacing = 0;
	_layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
	
	return _layout;
}

@end
