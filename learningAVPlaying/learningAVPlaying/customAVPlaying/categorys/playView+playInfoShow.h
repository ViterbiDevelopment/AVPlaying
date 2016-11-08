//
//  playView+playInfoShow.h
//  learningAVPlaying
//
//  Created by 掌上先机 on 16/11/8.
//  Copyright © 2016年 wangchao. All rights reserved.
//

#import "playView.h"

@interface playView (playInfoShow)


@property(nonatomic,strong)UILabel *infoLable;


-(void)showInfoLableWithTextSecond:(float)second;


-(void)dissMissInfoLable;

@end
