//
//  AppDelegate.m
//  HUMember
//
//  Created by HRT on 16/6/12.
//  Copyright © 2016年 HRT. All rights reserved.
//

#import "AppDelegate.h"
#import "CYLTabBarController.h"
#import "HomeViewController.h"
#import "MerchantViewController.h"
#import "MineViewController.h"
#import "MoreViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate ()<CLLocationManagerDelegate>
{
     //定位
     CLLocationManager *_locationManager;//用于获取位置
     CLLocation *_checkLocation;//用于保存位置信息
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     // Override point for customization after application launch.

     self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
     self.window.backgroundColor = [UIColor whiteColor];


     [self setupLocationManager];

     //创建CYLTabBarController的对象
     CYLTabBarController *CYLtabVC = [[CYLTabBarController alloc]init];

     //设置CYLTabBarController对象的标签栏属性按钮
     CYLtabVC.tabBarItemsAttributes = [self createTabBarItemsAttributes];

     //设置CYLTabBarController对象的标签栏子控制器数组
     CYLtabVC.viewControllers = [self createTabBarViewControllers];

     //设置CYLTabBarController的对象的根控制器
     [self.window setRootViewController:CYLtabVC];

      [self initAdvView];


     return YES;
}



//创建标签栏子控制器数组
-(NSArray *)createTabBarViewControllers{

     HomeViewController *homeVC = [[HomeViewController alloc] init];
     UINavigationController *homeNaV = [[UINavigationController alloc]initWithRootViewController:homeVC];

     MerchantViewController *messageVC = [[MerchantViewController alloc] init];
     UINavigationController *messageNaV = [[UINavigationController alloc]initWithRootViewController:messageVC];

     MineViewController *foundVC = [[MineViewController alloc]init];
     UINavigationController *foundNaV = [[UINavigationController alloc]initWithRootViewController:foundVC];

     MoreViewController *mineVC = [[MoreViewController alloc]init];
     UINavigationController *mineNaV = [[UINavigationController alloc]initWithRootViewController:mineVC];

     return @[homeNaV,messageNaV,foundNaV,mineNaV];
}

//创建标签栏按钮item数组
-(NSArray *)createTabBarItemsAttributes{

     NSDictionary *dict1 = @{
                             CYLTabBarItemTitle : @"团购",
                             CYLTabBarItemImage : @"icon_tabbar_homepage",
                             CYLTabBarItemSelectedImage : @"icon_tabbar_homepage_selected",
                             };
     NSDictionary *dict2 = @{
                             CYLTabBarItemTitle : @"商家",
                             CYLTabBarItemImage : @"icon_tabbar_merchant_normal",
                             CYLTabBarItemSelectedImage : @"icon_tabbar_merchant_selected",
                             };
     NSDictionary *dict3 = @{
                             CYLTabBarItemTitle : @"我的",
                             CYLTabBarItemImage : @"icon_tabbar_mine",
                             CYLTabBarItemSelectedImage : @"icon_tabbar_mine_selected",
                             };
     NSDictionary *dict4 = @{
                             CYLTabBarItemTitle : @"更多",
                             CYLTabBarItemImage : @"icon_tabbar_misc",
                             CYLTabBarItemSelectedImage : @"icon_tabbar_misc_selected",
                             };
     return @[ dict1, dict2, dict3, dict4];
}


- (void)applicationWillResignActive:(UIApplication *)application {
     // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
     // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
     // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
     // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
     // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



-(void)setupLocationManager{

     _latitude = LATITUDE_DEFAULT;
     _longitude = LONGITUDE_DEFAULT;
     _locationManager = [[CLLocationManager alloc] init];

     if ([CLLocationManager locationServicesEnabled]) {

          _locationManager.delegate = self;
          // distanceFilter是距离过滤器，为了减少对定位装置的轮询次数，位置的改变不会每次都去通知委托，而是在移动了足够的距离时才通知委托程序
          // 它的单位是米，这里设置为至少移动1000再通知委托处理更新;
          _locationManager.distanceFilter = 200.0;
          // kCLLocationAccuracyBest:设备使用电池供电时候最高的精度
          _locationManager.desiredAccuracy = kCLLocationAccuracyBest;


          //ios8+以上要授权，并且在plist文件中添加NSLocationWhenInUseUsageDescription，NSLocationAlwaysUsageDescription，值可以为空
          if (IOS_VERSION >=8.0) {//ios8+，不加这个则不会弹框
               [_locationManager requestWhenInUseAuthorization];//使用中授权
               [_locationManager requestAlwaysAuthorization];
          }
          [_locationManager startUpdatingLocation];
     }else{

     }
}


//舍弃了
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
     NSLog(@"didUpdateToLocation----");
     _checkLocation = newLocation;
}

//ios 6.0sdk以上
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
     NSLog(@"didUpdateToLocation+++");
     //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
     CLLocation *cl = [locations lastObject];
     _latitude = cl.coordinate.latitude;
     _longitude = cl.coordinate.longitude;
     NSLog(@"纬度--%f",_latitude);
     NSLog(@"经度--%f",_longitude);
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
     NSLog(@"定位失败");
}



-(void)initAdvView{

     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
     NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"loading.png"]];

     NSFileManager *fileManager = [NSFileManager defaultManager];
     BOOL isDir = FALSE;
     BOOL isExit = [fileManager fileExistsAtPath:filePath isDirectory:&isDir];
     if (isExit) {
          NSLog(@"存在");
          _advImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
          //        [_advImage setImage:[UIImage imageNamed:@"loading.png"]];
          [_advImage setImage:[UIImage imageWithContentsOfFile:filePath]];
          [self.window addSubview:_advImage];
          
          [self performSelector:@selector(removeAdvImage) withObject:nil afterDelay:3];


          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
               //加载启动广告并保存到本地沙盒，因为保存的图片较大，每次运行都要保存，所以注掉了
               //            [self getLoadingImage];
          });
     }else{

          _advImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
          [_advImage setImage:[UIImage imageNamed:@"loading.png"]];
          [self.window addSubview:_advImage];
          [self performSelector:@selector(removeAdvImage) withObject:nil afterDelay:3];

          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                           [self getLoadingImage];
          });
     }
}


-(void)removeAdvImage{

     [UIView animateWithDuration:0.3f animations:^{
          _advImage.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
          _advImage.alpha = 0.f;
     } completion:^(BOOL finished) {
          [_advImage removeFromSuperview];
     }];
}


//获取启动广告图片，采用后台推送时执行请求
-(void)getLoadingImage{
     //分辨率
     CGFloat scale_screen = [UIScreen mainScreen].scale;
     NSLog(@"%.0f    %.0f",screen_width*scale_screen,screen_height*scale_screen);
     int scaleW = (int)screen_width*scale_screen;
     int scaleH = (int)screen_height*scale_screen;

     NSString *urlStr = [NSString stringWithFormat:@"http://api.meituan.com/config/v1/loading/check.json?app_name=group&app_version=5.7&ci=1&city_id=1&client=iphone&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-15-15-51824&platform=iphone&resolution=%d%@%d&userid=104108621&utm_campaign=AgroupBgroupD100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoquxincelue0630__b__b1___ab_i550poi_xxyl__b__leftflow___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_pindaoshenyang__a__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__a__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGhomepage&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7",scaleW,@"%2A",scaleH];


     [HYBNetworking getWithUrl:urlStr refreshCache:YES success:^(id response) {

          NSLog(@"获取启动广告图片成功");
          NSMutableArray *dataArray = [response objectForKey:@"data"];
          NSLog(@"dataArray:%@",dataArray);
          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
               if (dataArray.count>0) {
                    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dataArray[0] objectForKey:@"imageUrl"]]];
                    UIImage *image = [UIImage imageWithData:data];

                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);

                    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"loading.png"]];   // 保存文件的名称
                    //    BOOL result = [UIImagePNGRepresentation() writeToFile: filePath    atomically:YES]; // 保存成功会返回YES
                    NSLog(@"paths:%@    %@",paths,filePath);
                    [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
                    
               }
          });

     } fail:^(NSError *error) {


     }];

}


@end
