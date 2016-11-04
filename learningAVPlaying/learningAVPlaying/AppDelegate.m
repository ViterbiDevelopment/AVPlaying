//
//  AppDelegate.m
//  learningAVPlaying
//
//  Created by 掌上先机 on 16/10/31.
//  Copyright © 2016年 wangchao. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    ViewController * vc = [[ViewController alloc] init];
    
    self.window.rootViewController = vc;
    
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}



@end
