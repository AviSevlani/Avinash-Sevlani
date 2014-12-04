//
//  SelectAddressViewController.h
//  PicaKart
//
//  Created by Avinash Sevlani on 22/11/14.
//  Copyright (c) 2014 amstark. All rights reserved.
//

#import "BaseViewController.h"

@protocol changeAddressDelegate <NSObject>

- (void) selectedAddress:(NSDictionary*)selectedAddressDict;

@end


@interface SelectAddressViewController : BaseViewController
@property (nonatomic,weak) id<changeAddressDelegate> delegateRef;

- (IBAction)addNewAddress:(id)sender;
@end
