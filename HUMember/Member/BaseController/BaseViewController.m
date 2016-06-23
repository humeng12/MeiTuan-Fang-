//
//  BaseViewController.m
//  HUMember
//
//  Created by HRT on 16/6/12.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
     [super viewDidLoad];

}


-(void)addLeftButton
{
     UIButton * lpLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,50,30)];
     [lpLeftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
     [lpLeftBtn setBackgroundColor:[UIColor clearColor]];
     [lpLeftBtn setImage:[UIImage imageNamed:@"btn_backItem"] forState:UIControlStateNormal];
     UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] init];
     [leftBtn setCustomView:lpLeftBtn];
     self.navigationItem.leftBarButtonItem = leftBtn;
}


-(void)leftBtnClick
{
     [self.navigationController popViewControllerAnimated:YES];
}


-(void)setTitle:(NSString*)title{

     UIView*vc = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width-54*2, 44)];
     vc.backgroundColor=[UIColor clearColor];

     CGSize size = [title sizeWithAttributes:@{
                                               NSFontAttributeName:[UIFont boldSystemFontOfSize:18]
                                               }];

     UILabel *upLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
     upLabel.textColor = [UIColor blackColor];
     upLabel.font = [UIFont boldSystemFontOfSize:18];
     upLabel.backgroundColor = [UIColor clearColor];
     upLabel.textAlignment = NSTextAlignmentCenter;
     upLabel.text = title;

     self.navigationItem.titleView = upLabel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
