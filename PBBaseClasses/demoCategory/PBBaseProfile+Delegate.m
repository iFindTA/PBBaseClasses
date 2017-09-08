//
//  PBBaseProfile+Delegate.m
//  PBBaseClasses
//
//  Created by nanhujiaju on 2017/9/8.
//  Copyright © 2017年 nanhujiaju. All rights reserved.
//

#import "PBBaseProfile+Delegate.h"
#import <objc/message.h>
#import "PBBaseTabBarProfile+Hidden.h"

@implementation PBBaseProfile (Delegate)

#pragma mark -- getter

- (AppDelegate *)appDelegate {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return delegate;
}

- (PBBaseTabBarProfile *)rootTabBar {
    AppDelegate *delegate = [self appDelegate];
    SEL aSel = NSSelectorFromString(@"rootTabBar");
    if (delegate && [delegate respondsToSelector:aSel]) {
        //FLKBaseTabBarController *tabBarCtr = [delegate rootTabBar];
        PBBaseTabBarProfile* (*msgSend)(id, SEL) = (PBBaseTabBarProfile* (*)(id, SEL))objc_msgSend;
        PBBaseTabBarProfile *tabBarCtr = msgSend(delegate, aSel);
        return tabBarCtr;
    }
    return nil;
}

#pragma mark -- tabBar event

- (void)hideTabBar:(BOOL)hidden animated:(BOOL)animated {
    PBBaseTabBarProfile *tabBarCtr = [self rootTabBar];
    [tabBarCtr setTabBarHidden:hidden animated:animated delaysContentResizing:true completion:nil];
}

- (void)setBadgeValue:(NSInteger)value atIndex:(NSUInteger)idx {
    PBBaseTabBarProfile *tabBarCtr = [self rootTabBar];
    if (value < 0) {
        [tabBarCtr clearBadgeAtIndex:idx];
        return;
    }
    WBadgeStyle style = WBadgeStyleNew;
    if (value == 0) {
        style = WBadgeStyleRedDot;
    }else if (value > 0 && value < 1000){
        style = WBadgeStyleNumber;
    }
    [tabBarCtr updateBadgeStyle:style value:value atIndex:idx];
}

- (void)clearBadgeAtIndex:(NSUInteger)idx {
    PBBaseTabBarProfile *tabBarCtr = [self rootTabBar];
    [tabBarCtr clearBadgeAtIndex:idx];
}

- (void)switchRoot2MainComponent:(BOOL)ismain {
    //TODO:定制化root跳转
}

@end
