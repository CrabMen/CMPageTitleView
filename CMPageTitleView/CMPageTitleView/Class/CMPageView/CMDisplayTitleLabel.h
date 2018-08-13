//
//  CMDisplayTitleLabel.h
//  CMCustomTitleBar
//
//  Created by CrabMan on 16/5/1.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMDisplayTitleLabel : UILabel

@property (nonatomic,assign) CGFloat progress;
@property (nonatomic,strong) UIColor *fillColor;

@property (nonatomic,assign) BOOL isSelected;
@end
