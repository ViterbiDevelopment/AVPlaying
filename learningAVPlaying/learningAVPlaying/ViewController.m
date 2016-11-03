//
//  ViewController.m
//  learningAVPlaying
//
//  Created by 掌上先机 on 16/10/31.
//  Copyright © 2016年 wangchao. All rights reserved.
//

#import "ViewController.h"

#import "playView.h"



@interface ViewController ()

@property (strong, nonatomic) IBOutlet playView *myPlayView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    

  
    
  


}


- (IBAction)starPlaying:(UIButton *)sender {
    
    [_myPlayView play];
    
    
}


- (IBAction)pause:(UIButton *)sender {
    
    [_myPlayView pause];
    
    
}



@end
