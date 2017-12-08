//
//  ThirdViewController.m
//  JRPhotoBrowser
//
//  Created by 王潇 on 2017/12/8.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor yellowColor];
	
	UIView *sView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 150, 150)];
	[self.view addSubview:sView];
	
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 100, 100)];
	view.backgroundColor 	= [UIColor greenColor];
	view.layer.shadowColor 	= [UIColor redColor].CGColor;
	view.layer.shadowOffset = CGSizeMake(2, 2);
	view.layer.shadowRadius = 4;
	view.layer.shadowOpacity = 1.2;
	view.layer.cornerRadius = 4;
	[sView addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
