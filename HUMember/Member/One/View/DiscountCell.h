//
//  DiscountCell.h
//  HUMember
//
//  Created by HRT on 16/6/21.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DiscountDelegate <NSObject>

@optional
-(void)didSelectUrl:(NSString *)urlStr withType:(NSNumber *)type withId:(NSNumber *)ID withTitle:(NSString *)title;

@end


@interface DiscountCell : UITableViewCell

/**
 *  接收set方式传参
 */
@property(nonatomic, strong) NSMutableArray *discountArray;

@property(nonatomic, assign) id<DiscountDelegate> delegate;

@end
