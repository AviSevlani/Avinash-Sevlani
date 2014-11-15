//
//  PhotoTableViewCell.h
//  PicaKart
//
//  Created by Avinash Sevlani on 12/11/14.
//  Copyright (c) 2014 amstark. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol photoOrderDelegate <NSObject>

- (void)deleteImageOrder:(NSMutableDictionary*)imageOrder;

@end

@interface PhotoTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (nonatomic, weak)IBOutlet UIImageView* photoImage;
@property (nonatomic, weak)IBOutlet UITextField* quantityTextField;
@property (nonatomic, retain)NSMutableDictionary* imageOrderDict;
@property (nonatomic, weak)id<photoOrderDelegate> delegate;

+ (PhotoTableViewCell*) cellForImageOrder:(NSMutableDictionary*)imageOrderDict inTableView:(UITableView*)tableView withDelegate:(id<photoOrderDelegate>)delegate;


@end
