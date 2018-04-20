//
//  AppDelegate.m
//  NewFeature
//
//  Created by HangDian on 2018/4/20.
//  Copyright © 2018年 HangDian. All rights reserved.
//

#import "AppDelegate.h"
#import "DKMainViewController.h"
#import "DKMoveNewFeatureVC.h"
#import "DKImageNewFeature.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //获取app中的版本号
    NSString *newVersion = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    //获取沙盒文件中保存的版本号
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:@"versionInfo.plist"];
    NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:path];
    NSString *oldVersion = dic[@"version"];
    
    if (![newVersion isEqual:oldVersion]) {
        [self updateWithVersion:newVersion];
        //视频新特性
        DKMoveNewFeatureVC *moveNewFeatureVC = [[DKMoveNewFeatureVC alloc]init];
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.window.rootViewController = moveNewFeatureVC;
        [self.window makeKeyAndVisible];
        //图片新特性
//        NSArray *imageArr = @[@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30"];
//        DKImageNewFeature *imageNewVC =  [[DKImageNewFeature alloc]initWithPicNameArray:imageArr];
//        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//        self.window.rootViewController = imageNewVC;
//        [self.window makeKeyAndVisible];
        
    }else{
        DKMainViewController *mainVC = [[DKMainViewController alloc]init];
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.window.rootViewController = mainVC;
        [self.window makeKeyAndVisible];
    }
    
    return YES;
}

-(void)updateWithVersion:(NSString *)version{
    //获取沙盒中偏好设置的文件路径
    NSString *doucumentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDict = NO;
    BOOL existed = [fileManager fileExistsAtPath:doucumentsPath isDirectory:&isDict];
    //判断这个文件或者目录是否有效 如果没有效就创建一个文件
    if (!existed) {
        [fileManager createDirectoryAtPath:doucumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //写入文件
    NSString *path = [doucumentsPath stringByAppendingString:@"versionInfo.plist"];
    NSDictionary *dic = @{@"version":version};
    BOOL writeSuccess = [dic writeToFile:path atomically:YES];
    if (writeSuccess==YES) {
        NSLog(@"写入成功");
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
