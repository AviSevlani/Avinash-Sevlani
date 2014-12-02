//
//  BaseViewController.m
//  PicaKart
//
//  Created by Avinash Sevlani on 12/11/14.
//  Copyright (c) 2014 amstark. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


- (void)setTitleView
{
    UIView* titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 40)];
    UIImageView* imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"navigationLogo"]];
    imageview.frame = CGRectMake(0,2, imageview.frame.size.width, imageview.frame.size.height);
    [titleView addSubview:imageview];
    
    UILabel* titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageview.frame.size.width + 4,0,80, 40)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    titleLabel.text = @"PicaKart";
    titleLabel.textColor = [UIColor whiteColor];
    [titleView addSubview:titleLabel];
    
    self.navigationItem.titleView = titleView;
    
    
 //   self.navigationItem.titleView =
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleView];
    // Do any additional setup after loading the view.
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
