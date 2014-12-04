//
//  AddresTableViewCell.h
//  PicaKart
//
//  Created by Avinash Sevlani on 23/11/14.
//  Copyright (c) 2014 amstark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddresTableViewCell : UITableViewCell
@property (nonatomic, weak)IBOutlet UILabel* nameLabel;
@property (nonatomic, weak)IBOutlet UILabel* addressLabel;
@property (nonatomic, weak)IBOutlet UILabel* zipCodeLabel;
@property (nonatomic, weak)IBOutlet UILabel* landmarkLabel;

+ (AddresTableViewCell*) cellForAddress:(NSMutableDictionary*)addressDict inTableView:(UITableView*)tableView;

+ (CGFloat)heightForCell;

@end
