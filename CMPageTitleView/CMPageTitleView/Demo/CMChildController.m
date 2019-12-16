//
//  CMChildController.m
//  CMPageTitleView
//
//  Created by 郭强 on 2019/12/14.
//  Copyright © 2019 CrabMan. All rights reserved.
//

#import "CMChildController.h"

@interface CMChildController ()

@end

@implementation CMChildController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad --- %@",self.title);

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
