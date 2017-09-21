//
//  ViewController.m
//  PBBaseClasses
//
//  Created by nanhujiaju on 2017/9/8.
//  Copyright © 2017年 nanhujiaju. All rights reserved.
//

#import "ViewController.h"
#import "HiddenController.h"
#import "PBIndicateButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"iPhone X";
    
    //init back navigation bar item
    //left
    UIBarButtonItem *spacer = [self barSpacer];
    UIBarButtonItem *backBarItem = [self backBarButtonItem:nil withIconUnicode:@"\U0000e6e2"];
    UINavigationItem *title = [[UINavigationItem alloc] initWithTitle:@"屯儿里的人"];
    title.leftBarButtonItems = @[spacer, backBarItem];
    [self.navigationBar pushNavigationItem:title animated:true];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 200, 200, 50);
    [btn setTitle:@"push" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    NSLog(@"db name:%@", PB_STORAGE_DB_NAME);
    
    self.view.backgroundColor = [UIColor pb_randomColor];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushEvent {
    HiddenController *hidden = [[HiddenController alloc] init];
    [self.navigationController pushViewController:hidden animated:true];
}

- (IBAction)authorizeEvent:(PBIndicateButton *)sender {
    
    [sender makeActivity:true];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [sender makeActivity:false];
    });
    
    
    
}


@end
