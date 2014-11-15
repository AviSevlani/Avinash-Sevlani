//
//  RegistrationViewController.h
//  PicaKart
//
//  Created by Avinash Sevlani on 09/11/14.
//  Copyright (c) 2014 amstark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface RegistrationViewController : BaseViewController
@property (nonatomic, weak) IBOutlet UITextField* nameTextFlied;
@property (nonatomic, weak) IBOutlet UITextField* mobileTextFlied;
@property (nonatomic, weak) IBOutlet UITextField* emailAdressTextFlied;
@property (nonatomic, weak) IBOutlet UIScrollView* scrollView;



@end
