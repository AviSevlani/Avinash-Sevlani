//
//  PhotoTableViewCell.m
//  PicaKart
//
//  Created by Avinash Sevlani on 12/11/14.
//  Copyright (c) 2014 amstark. All rights reserved.
//

#import "PhotoTableViewCell.h"

@implementation PhotoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(PhotoTableViewCell*) cellForImageOrder:(NSMutableDictionary*)imageOrderDict inTableView:(UITableView*)tableView withDelegate:(id<photoOrderDelegate>)delegate
{
     PhotoTableViewCell* cell = (PhotoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"PhotoTableViewCell"];
    if(cell)
    {
        cell.imageOrderDict = imageOrderDict;
    }
    else
    {
        cell = [[self alloc] initWithimageOrderDict:imageOrderDict reuseIdentifier:@"PhotoTableViewCell" withDelgate:delegate];
    }
    cell.delegate = delegate;
    
    return cell;
}


- (id)initWithimageOrderDict:(NSMutableDictionary*)imageOrder reuseIdentifier:(NSString *)reuseIdentifier withDelgate:(id)delegate
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if( self )
        
    {
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.photoImage.image = [self.imageOrderDict objectForKey:@"image"];
    self.quantityTextField.text = [self.imageOrderDict objectForKey:@"noOfOrder"];
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   
    [self.imageOrderDict setObject:[self.quantityTextField.text stringByReplacingCharactersInRange:range withString:string] forKey:@"noOfOrder"];
    
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(IBAction)deleteButtonClicked:(id)sender
{
    [self.delegate deleteImageOrder:self.imageOrderDict];
}

@end
