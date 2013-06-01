//
//  AppDelegate.m
//  Issue
//
//  Created by 임상진 on 13. 6. 1..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import "AppDelegate.h"
#import "ITNavigationController.h"
#import "ITFeedViewController.h"
#import "ITLoginViewController.h"
#import "ITUtil.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    ITFeedViewController *currentFeed = [[ITFeedViewController alloc] init];
    currentFeed.title = @"현재 피드";
    ITNavigationController *currentFeedNav = [[ITNavigationController alloc] initWithRootViewController:currentFeed];
    [viewControllers addObject:currentFeedNav];
    
    ITFeedViewController *prevFeed = [[ITFeedViewController alloc] init];
    prevFeed.title = @"지난 피드";
    ITNavigationController *prevFeedNav = [[ITNavigationController alloc] initWithRootViewController:prevFeed];
    [viewControllers addObject:prevFeedNav];
    
    UIViewController *setting = [[UIViewController alloc] init];
    setting.title = @"설정";
    ITNavigationController *settingNav = [[ITNavigationController alloc] initWithRootViewController:setting];
    [viewControllers addObject:settingNav];
    
    UITabBarController *tab = [[UITabBarController alloc] init];
    tab.viewControllers = viewControllers;
    tab.tabBar.tintColor = [UIColor whiteColor];
    [self.window setRootViewController:tab];
    
    if(![ITUtil loadSessionCookie]){
        ITLoginViewController *loginView = [[ITLoginViewController alloc] init];
        [self.window.rootViewController presentViewController:loginView animated:NO completion:nil];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
