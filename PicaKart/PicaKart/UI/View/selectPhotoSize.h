//
//  selectPhotoSize.h
//  PicaKart
//
//  Created by Avinash Sevlani on 17/11/14.
//  Copyright (c) 2014 amstark. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol selectSizeDelegate <NSObject>

- (void)selectedSize:(id)selectedItemObj;

@end

@interface selectPhotoSize : UITableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)NSDictionary* selectedItem;
- (void)setSizeArray:(NSArray*)itmeArray;
@property (nonatomic,weak)id<selectSizeDelegate> delegateRefrence;
@end
