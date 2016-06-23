//
//  RushCell.h
//  HUMember
//
//  Created by HRT on 16/6/12.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RushDealsModel.h"

@protocol RushDelegate <NSObject>

@optional
-(void)didSelectRushIndex:(NSInteger )index;

@end

@interface RushCell : UITableViewCell

@property(nonatomic, strong) NSMutableArray *rushData;


@property(nonatomic, assign) id<RushDelegate> delegate;

@end
