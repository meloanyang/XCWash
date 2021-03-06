//
//  XCBaseSideViewController.h
//  XCWash
//
//  Created by 吴伟庆 on 15/3/11.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface XCBaseSideViewController : UIViewController


#pragma mark - MBHUDProgress and NSTime
-(void)initMBHudWithTitle:(NSString *)title;

-(void)initMBHudBecauseNetWorkUnavailable;

-(void)stopMBHudAndNSTimerWithmsg:(NSString *)msg finsh:(void (^)(void))finshBlock;

-(void)displaySomeInfoWithInfo:(NSString *)infoStr finsh:(void (^)(void))finshBlock;


@end
