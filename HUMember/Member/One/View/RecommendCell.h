//
//  RecommendCell.h
//  HUMember
//
//  Created by HRT on 16/6/21.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"

#import "DisDealModel.h"//折扣model

@interface RecommendCell : UITableViewCell

@property(nonatomic, strong) UIImageView *shopImage;
@property(nonatomic, strong) UILabel *shopNameLabel;
@property(nonatomic, strong) UILabel *shopInfoLabel;
@property(nonatomic, strong) UILabel *priceLabel;
@property(nonatomic, strong) UILabel *soldedLabel;


@property(nonatomic, strong) RecommendModel *recommendData;

@property(nonatomic, strong) DisDealModel *dealData;

@end
