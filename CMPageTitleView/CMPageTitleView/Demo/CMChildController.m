//
//  CMChildController.m
//  CMPageTitleView
//
//  Created by 郭强 on 2019/12/14.
//  Copyright © 2019 CrabMan. All rights reserved.
//

#import "CMChildController.h"
#import <Masonry.h>
@interface CMChildController ()

@property(nonatomic,weak) UIButton *button;


@end

@implementation CMChildController

- (UIButton *)button {
    if (!_button) {
        UIButton *button = [UIButton new];
        [button setTitle:@"跳转到详情" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.layer.cornerRadius = 4;
        button.backgroundColor = [UIColor lightGrayColor];
        [button addTarget:self action:@selector(buttonnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        _button = button;
        [self.view addSubview:_button];
    }
    return _button;

}

- (void)buttonnClickAction:(UIButton *)sender {
    
   UIViewController *detailVC = [UIViewController new];
    detailVC.title = @"详情页";
    detailVC.view.backgroundColor = UIColor.redColor;
    [self.parentViewController.navigationController pushViewController:detailVC animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad --- %@",self.title);
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
        make.center.equalTo(self.view);
    }];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear --- %@",self.title);
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear --- %@",self.title);

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewDidAppear --- %@",self.title);
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"viewDidDisappear --- %@",self.title);

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
