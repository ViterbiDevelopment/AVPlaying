//
//  ViewController.m
//  learningAVPlaying
//
//  Created by 掌上先机 on 16/10/31.
//  Copyright © 2016年 wangchao. All rights reserved.
//

#import "ViewController.h"

#import "playView.h"

#define KSCreenW  [UIScreen mainScreen].bounds.size.width
#define KSCreenH  [UIScreen mainScreen].bounds.size.height



@interface ViewController ()

@property (strong, nonatomic)  playView *myPlayView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _myPlayView = [[playView alloc] initWithFrame:CGRectMake(0, 0, KSCreenW, 300)];
    
    [self.view addSubview:_myPlayView];
    

  
    


}








@end
