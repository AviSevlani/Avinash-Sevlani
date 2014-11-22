//
//  ConfirmOrderViewController.h
//  PicaKart
//
//  Created by Avinash Sevlani on 12/11/14.
//  Copyright (c) 2014 amstark. All rights reserved.
//

#import "BaseViewController.h"

@interface ConfirmOrderViewController : BaseViewController
@property (nonatomic, weak)IBOutlet UITableView* tableView;
@property (nonatomic, assign)int selectedCategory;
@property (nonatomic, weak)IBOutlet UILabel* photoSize;

// Order Details
@property (nonatomic, weak)IBOutlet UILabel* printType;
@property (nonatomic, weak)IBOutlet UILabel* totalPrints;
@property (nonatomic, weak)IBOutlet UILabel* deliveryCharges;
@property (nonatomic, weak)IBOutlet UILabel* totalAmount;
@property (nonatomic, weak)IBOutlet UILabel* address;
@property (nonatomic, weak)IBOutlet UIView* orderDetailView;
@property (nonatomic, weak)IBOutlet UIButton* changeAddress;



@end
