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
    NSString * ulrString = @"http://zyvideo1.oss-cn-qingdao.aliyuncs.com/zyvd/7c/de/04ec95f4fd42d9d01f63b9683ad0";
    
    _myPlayView = [[playView alloc] initWithFrameAndUrl:CGRectMake(0, 0, KSCreenW, KSCreenH-300) url:ulrString];
    [self.view addSubview:_myPlayView];
    progressView * view = _myPlayView.playProgress;
    
    [view.screenFullButton addTarget:self action:@selector(fullScreenBtnClick:) forControlEvents:UIControlEventTouchUpInside];

}


-(void)fullScreenBtnClick:(UIButton *)sender{
  
    if ([sender.currentTitle isEqualToString:@"全屏"]) {
      
        [UIView animateWithDuration:0.5 animations:^{
            
            self.myPlayView.frame = CGRectMake(0, 0, KSCreenH, KSCreenW);
            self.myPlayView.center = self.view.center;
            CGAffineTransform form = CGAffineTransformIdentity;
            self.myPlayView.transform = CGAffineTransformRotate(form, M_PI_2);
          
        } completion:^(BOOL finished) {
          
            [sender setTitle:@"小屏" forState:UIControlStateNormal];
        }];
      
    }
    else{
  
        [UIView animateWithDuration:0.5 animations:^{
            
            CGAffineTransform form = CGAffineTransformIdentity;
            self.myPlayView.transform = CGAffineTransformRotate(form, 0);
            self.myPlayView.frame = CGRectMake(0, 0, KSCreenW , KSCreenH - 300);
         
        } completion:^(BOOL finished) {
          [sender setTitle:@"全屏" forState:UIControlStateNormal];
        }];
    }
}


@end
