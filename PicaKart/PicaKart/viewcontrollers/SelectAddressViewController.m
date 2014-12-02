//
//  SelectAddressViewController.m
//  PicaKart
//
//  Created by Avinash Sevlani on 22/11/14.
//  Copyright (c) 2014 amstark. All rights reserved.
//

#import "SelectAddressViewController.h"
#import "AddresTableViewCell.h"

@interface SelectAddressViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* addressArray;
}

@end

@implementation SelectAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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


#pragma mark - Actions

- (IBAction)addNewAddress:(id)sender
{
    //
    [self performSegueWithIdentifier:@"newAdressSegue" sender:self];
}


#pragma tableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [addressArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [AddresTableViewCell cellForAddress:[addressArray objectAtIndex:indexPath.row] inTableView:tableView];
}


@end
