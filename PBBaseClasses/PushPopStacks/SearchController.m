//
//  SearchController.m
//  FLKBaseClasses
//
//  Created by nanhujiaju on 2017/4/19.
//  Copyright © 2017年 nanhu. All rights reserved.
//

#import "SearchController.h"
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import <Masonry.h>
#import "PBConstant.h"

@interface SearchController () <UISearchBarDelegate>

//search function
@property (nonatomic, strong) UISearchBar *mSearchBar;

//move mas constant layout
@property (nonatomic, assign) BOOL whetherInitMasConstraint;
//介于导航条与searchBar中间的20像素的"弹簧"约束
@property (nonatomic, strong) UIView *mNaviBarOffsetView;
@property (nonatomic, strong) MASConstraint *mNaviBarOffsetCst;
@property (nonatomic, strong) MASConstraint *mNaviBarConstraint;

@end

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //init back navigation bar item
    //left
    UIBarButtonItem *spacer = [self barSpacer];
    UIBarButtonItem *backBarItem = [self backBarButtonItem:nil withIconUnicode:@"\U0000e6e2"];
    //[self.navigationBar pushNavigationItem:leftItem animated:true];
    UINavigationItem *title = [[UINavigationItem alloc] initWithTitle:@"search Ctr"];
    title.leftBarButtonItems = @[spacer, backBarItem];
    [self.navigationBar pushNavigationItem:title animated:true];
    
    //介于navigationBar 与 searchBar之间的"弹簧"
    self.mNaviBarOffsetView = [[UIView alloc] init];
    self.mNaviBarOffsetView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mNaviBarOffsetView];
    
    //searchBar
    UIColor *barTintColor = [UIColor pb_colorWithHexString:@"#6DB1F5"];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    searchBar.delegate = self;
    searchBar.barStyle = UIBarStyleDefault;
    searchBar.backgroundColor = [UIColor pb_colorWithHexString:@"#E6E6E6"];
    searchBar.placeholder = @"搜索";
    //searchBar.showsCancelButton = true;
    [searchBar setBarTintColor:barTintColor];//cancel btn color
    //change cursor color
    NSArray * cls = @[[UISearchBar class]];
    [[UITextField appearanceWhenContainedInInstancesOfClasses:cls] setTintColor:barTintColor];
    //delete black line up/down
    searchBar.backgroundImage = [UIImage new];
    [self.view addSubview:searchBar];
    self.mSearchBar = searchBar;
    
    self.whetherInitMasConstraint = false;
    
    weakify(self)
    
    [self.navigationBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        strongify(self)
        make.top.equalTo(self.statusStretch.mas_bottom).priority(UILayoutPriorityDefaultHigh);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(PB_NAVIBAR_HEIGHT - PB_STATUSBAR_HEIGHT));
        if (!self.mNaviBarConstraint) {
            self.mNaviBarConstraint = make.top.equalTo(self.view).offset(-PB_NAVIBAR_HEIGHT + PB_STATUSBAR_HEIGHT).priority(UILayoutPriorityRequired);
        }
        
    }];
    [self.mNaviBarOffsetView mas_makeConstraints:^(MASConstraintMaker *make) {
        strongify(self)
        make.top.equalTo(self.navigationBar.mas_bottom);
        //make.top.equalTo(self.view).offset(PB_NAVIBAR_HEIGHT);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(0)).priority(UILayoutPriorityDefaultHigh);
        if (!self.mNaviBarOffsetCst) {
            self.mNaviBarOffsetCst = make.height.equalTo(PB_STATUSBAR_HEIGHT).priority(UILayoutPriorityRequired);
        }
    }];
    [self.mSearchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        strongify(self)
        make.top.equalTo(self.mNaviBarOffsetView.mas_bottom)/*.priority(UILayoutPriorityDefaultHigh)*/;
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(PB_CUSTOM_SEARCHBAR_HEIGHT));
    }];
    
    //init setup mas constraints
    if (!self.whetherInitMasConstraint) {
        self.whetherInitMasConstraint = true;
        [self.mNaviBarConstraint deactivate];
        [self.mNaviBarOffsetCst deactivate];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)endEditingMode {
    NSLog(@"sub class called!");
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self.mNaviBarOffsetCst activate];
    [self.mNaviBarConstraint activate];
    
    //[self.mSearchRetConstraint deactivate];
    [UIView animateWithDuration:PBANIMATE_DURATION animations:^{
        [self.view layoutIfNeeded];
    }];
    [searchBar setShowsCancelButton:true animated:true];
    
    //[self.mSearchRetCover contactGrabbleTextDidChange:nil];
    
    return true;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self.mNaviBarOffsetCst deactivate];
    [self.mNaviBarConstraint deactivate];
    //[self.mSearchRetConstraint activate];
    [UIView animateWithDuration:PBANIMATE_DURATION animations:^{
        [self.view layoutIfNeeded];
    }];
    [searchBar setShowsCancelButton:false animated:true];
    
    //[self.mSearchRetCover stopGrabble];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return true;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"searchBar text did changed to :%@", searchText);
    //[self.mSearchRetCover contactGrabbleTextDidChange:searchText];
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
