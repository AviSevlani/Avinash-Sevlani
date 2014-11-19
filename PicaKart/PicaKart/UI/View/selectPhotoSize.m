//
//  selectPhotoSize.m
//  PicaKart
//
//  Created by Avinash Sevlani on 17/11/14.
//  Copyright (c) 2014 amstark. All rights reserved.
//

#import "selectPhotoSize.h"


@implementation selectPhotoSize
{
    NSArray* sizeArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        
    }
    return self;
}

#pragma tableView Datasource

- (void)setSizeArray:(NSArray*)itmeArray
{
    sizeArray = itmeArray;
    [self reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [sizeArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = [[sizeArray objectAtIndex:indexPath.row] objectForKey:@"Name"];
    if ([self.selectedItem isEqual:[sizeArray objectAtIndex:indexPath.row]])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
         cell.accessoryType = UITableViewCellAccessoryNone;
    }
 
    return cell;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
