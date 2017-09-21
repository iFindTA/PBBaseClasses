//
//  HiddenController.m
//  FLKBaseClasses
//
//  Created by nanhu on 2016/11/24.
//  Copyright © 2016年 nanhu. All rights reserved.
//

#import "HiddenController.h"
#import "PopController.h"
#import "PresentController.h"
#import "SearchController.h"

@interface HiddenController ()

@end

@implementation HiddenController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //init back navigation bar item
    //left
//    UIBarButtonItem *spacer = [self barSpacer];
//    UIBarButtonItem *backBarItem = [self backBarButtonItem:nil withIconUnicode:@"\U0000e6e2"];
//    UINavigationItem *title = [[UINavigationItem alloc] initWithTitle:@"Hidden Ctr"];
//    title.leftBarButtonItems = @[spacer, backBarItem];
//    [self.navigationBar pushNavigationItem:title animated:true];
    [self hiddenNavigationBar];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 200, 200, 50);
    [btn setTitle:@"push" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 400, 200, 50);
    [btn setTitle:@"search" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushSearchEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    img.backgroundColor = [UIColor yellowColor];
    [self.view insertSubview:img belowSubview:self.navigationBar];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 300, 200, 50);
    [btn setTitle:@"present" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(presentEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)pushEvent {
    PopController *hidden = [[PopController alloc] init];
    [self.navigationController pushViewController:hidden animated:true];
}

- (void)pushSearchEvent {
    SearchController *search = [[SearchController alloc] init];
    [self.navigationController pushViewController:search animated:true];
}

- (void)presentEvent {
    PresentController *present = [[PresentController alloc] init];
    [self presentViewController:present animated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
