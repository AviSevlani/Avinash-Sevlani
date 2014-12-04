//
//  NewAddressViewController.h
//  PicaKart
//
//  Created by Avinash Sevlani on 30/11/14.
//  Copyright (c) 2014 amstark. All rights reserved.
//

#import "BaseViewController.h"
#import "SelectAddressViewController.h"

@interface NewAddressViewController : BaseViewController
@property (nonatomic,weak)IBOutlet UIScrollView* scrollView;
@property (nonatomic,weak)IBOutlet UITextField* enterName;
@property (nonatomic,weak)IBOutlet UITextField* enterZipcode;
@property (nonatomic,weak)IBOutlet UITextField* enterLandmark;
@property (nonatomic,weak)IBOutlet UITextView* enterAdressTextView;
@property (nonatomic,weak)IBOutlet UILabel* adressPlaceholder;
@property (nonatomic,weak) id<changeAddressDelegate> delegateRef;



@end
