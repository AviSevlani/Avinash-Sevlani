//
//  AddresTableViewCell.m
//  PicaKart
//
//  Created by Avinash Sevlani on 23/11/14.
//  Copyright (c) 2014 amstark. All rights reserved.
//

#import "AddresTableViewCell.h"


@interface AddresTableViewCell()
{
    
}
@property (nonatomic,strong)NSDictionary*  address;
@end

@implementation AddresTableViewCell



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


+ (AddresTableViewCell*) cellForAddress:(NSMutableDictionary*)addressDict inTableView:(UITableView*)tableView

{
    AddresTableViewCell* cell = (AddresTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"AddresTableViewCell"];
    if(cell)
    {
        cell.address = addressDict;
    }
    else
    {
        cell = [[self alloc] initWithAddressDict:addressDict reuseIdentifier:@"AddresTableViewCell"];
        cell.address = addressDict;
    }
    
    return cell;
}


- (id)initWithAddressDict:(NSMutableDictionary*)addressDict reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if( self )
    {
        self.address = addressDict;
    }
    return self;
}

- (void)layoutSubviews
{
     [super layoutSubviews];
    NSArray* stringArray = [[self.address objectForKey:@"Address"] componentsSeparatedByString:@","];
    if ([stringArray count] > 0)
    {
        self.nameLabel.text = [stringArray objectAtIndex:0];
    }
    if ([stringArray count] > 1)
    {
        self.addressLabel.text = [stringArray objectAtIndex:1];
    }
    if ([stringArray count] > 2)
    {
        self.landmarkLabel.text = [stringArray objectAtIndex:2];
    }
    if ([stringArray count] > 3)
    {
         self.zipCodeLabel.text = [stringArray objectAtIndex:3];
    }
    
}


+ (CGFloat)heightForCell
{
    return 150;
}


@end

