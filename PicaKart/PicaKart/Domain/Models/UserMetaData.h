//
//  UserMetaData.h
//  PicaKart
//
//  Created by Avinash Sevlani on 16/11/14.
//  Copyright (c) 2014 amstark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserMetaData : NSObject
@property (nonatomic, retain)NSArray* addressArray;
@property (nonatomic, assign)float codCharge;
@property (nonatomic, assign)BOOL isCodAvailable;
@property (nonatomic, assign)BOOL isCouponAvailable;
@property (nonatomic, retain)NSArray* photoPrintsArray;
@property (nonatomic, retain)NSArray* tShirtPrintsArray;
@property (nonatomic, retain)NSArray* mugPrintsArray;
@property (nonatomic, retain)NSArray* photoBookPrintsArray;


@end
