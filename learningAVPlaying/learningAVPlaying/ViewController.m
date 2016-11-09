//
//  ViewController.m
//  learningAVPlaying
//
//  Created by 掌上先机 on 16/10/31.
//  Copyright © 2016年 wangchao. All rights reserved.
//

#import "ViewController.h"
#import "playView.h"
#import "progressView.h"
#import "Masonry.h"




#define KSCreenW  [UIScreen mainScreen].bounds.size.width
#define KSCreenH  [UIScreen mainScreen].bounds.size.height


@interface ViewController ()

@property (strong, nonatomic)playView *myPlayView;

@property(assign,nonatomic)BOOL isHalfScreen;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    _isHalfScreen = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _myPlayView = [[playView alloc] initWithFrame:CGRectMake(0, 0, KSCreenW, KSCreenH-300)];
    
    
    [self.view addSubview:_myPlayView];
    
    
    progressView * view = _myPlayView.playProgress;
    
    [view.screenFullButton addTarget:self action:@selector(fullScreenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
   
    

}


-(void)fullScreenBtnClick:(UIButton *)sender{
    
    
    if ([sender.currentTitle isEqualToString:@"全屏"]) {
        
        _isHalfScreen=true;
        
        
        [[UIDevice currentDevice]setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait]  forKey:@"orientation"];//这句话是防止手动先把设备置为横屏,导致下面的语句失效.
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
        [UIView animateWithDuration:0.5 animations:^{
            
            _myPlayView.frame = self.view.bounds;
            
            _myPlayView.playerLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            

            
        } completion:^(BOOL finished) {
            
            _isHalfScreen = false;
            
            [sender setTitle:@"小屏" forState:UIControlStateNormal];
            
            
        }];

    }
    else{
    
        __weak ViewController * weakSelf = self;
        
        
        [[UIDevice currentDevice]setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeRight]  forKey:@"orientation"];//这句话是防止手动先把设备置为横屏,导致下面的语句失效.
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
        [UIView animateWithDuration:0.5 animations:^{
       
            _myPlayView.frame = CGRectMake(0, 0, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height-300);
            _myPlayView.playerLayer.frame = CGRectMake(0, 0, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height-300);
            
            
        } completion:^(BOOL finished) {
            
            [sender setTitle:@"全屏" forState:UIControlStateNormal];
            
        }];
    
        
    
    }
    

    
}


-(UIInterfaceOrientationMask)supportedInterfaceOrientations{

    if (_isHalfScreen) {
        
        return UIInterfaceOrientationMaskLandscape;
    }

    return UIInterfaceOrientationMaskPortrait;

}







@end
