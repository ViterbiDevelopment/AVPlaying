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
    
    //这是一个注释'
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    _myPlayView = [[playView alloc] initWithFrame:CGRectMake(0, 0, KSCreenW, KSCreenH-300)];
    
    NSString * ulrString = @"http://v.jxvdy.com/sendfile/w5bgP3A8JgiQQo5l0hvoNGE2H16WbN09X-ONHPq3P3C1BISgf7C-qVs6_c8oaw3zKScO78I--b0BGFBRxlpw13sf2e54QA";
    
    _myPlayView = [[playView alloc] initWithFrameAndUrl:CGRectMake(0, 0, KSCreenW, KSCreenH-300) url:ulrString];
    
  //  _myPlayView.backgroundColor = uicolor.red
    
    [self.view addSubview:_myPlayView];
    
    // qwqwwwddwdw
    
    progressView * view = _myPlayView.playProgress;
    
    [view.screenFullButton addTarget:self action:@selector(fullScreenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
   
    

}


-(void)fullScreenBtnClick:(UIButton *)sender{
    
    
    if ([sender.currentTitle isEqualToString:@"全屏"]) {
        
        __weak typeof(self) weakSelf = self;
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            weakSelf.myPlayView.frame = CGRectMake(0, 0, KSCreenH, KSCreenW);
            
            weakSelf.myPlayView.center = self.view.center;
            CGAffineTransform form = CGAffineTransformIdentity;
            
            weakSelf.myPlayView.transform = CGAffineTransformRotate(form, M_PI_2);
            
        
            
        } completion:^(BOOL finished) {
            
            
            [sender setTitle:@"小屏" forState:UIControlStateNormal];
            
        }];
        
        
    }
    else{
    //
        
        __weak typeof(self) weakSelf = self;
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            CGAffineTransform form = CGAffineTransformIdentity;
            
            weakSelf.myPlayView.transform = CGAffineTransformRotate(form, 0);
            
            weakSelf.myPlayView.frame = CGRectMake(0, 0, KSCreenW , KSCreenH - 300);
   
            
            
        } completion:^(BOOL finished) {
            
            
            [sender setTitle:@"全屏" forState:UIControlStateNormal];
            
        }];
        

    
    }
    

    
}


//-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
//
//    if (_isHalfScreen) {
//        
//        return UIInterfaceOrientationMaskLandscape;
//    }
//
//    return UIInterfaceOrientationMaskPortrait;
//
//}
//






@end
