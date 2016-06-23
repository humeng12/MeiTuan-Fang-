//
//  AppDelegate.h
//  HUMember
//
//  Created by HRT on 16/6/12.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;

@property(nonatomic, strong) UIImageView *advImage;

@end

