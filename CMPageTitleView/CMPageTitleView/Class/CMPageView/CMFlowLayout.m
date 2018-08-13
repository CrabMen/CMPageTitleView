//
//  CMFlowLayout.m
//  CMCustomTitleBar
//
//  Created by CrabMan on 16/5/3.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import "CMFlowLayout.h"

@implementation CMFlowLayout

-(void)prepareLayout {
    [super prepareLayout];
    
    
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    if (self.collectionView.bounds.size.height) {
        
        self.itemSize = self.collectionView.bounds.size;
    }
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
}
@end
