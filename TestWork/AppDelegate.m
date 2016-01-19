//
//  AppDelegate.m
//  TestWork
//
//  Created by Stepan Chegrenev on 16.01.16.
//  Copyright © 2016 Stepan Chegrenev. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "SongViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) UINavigationController* navigationController; // Объявляю навигационный контроллер
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ViewController* vc = [[ViewController alloc] initWithNibName:nil bundle:nil];   // Инициализация vc
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:vc]; // Инициализация навигации
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.navigationController; // Установка навигационного контроллера как главного
    self.window.backgroundColor = [UIColor whiteColor]; // Установка белого фона
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
