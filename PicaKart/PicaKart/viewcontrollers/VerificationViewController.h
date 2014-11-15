//
//  VerificationViewController.h
//  PicaKart
//
//  Created by Avinash Sevlani on 09/11/14.
//  Copyright (c) 2014 amstark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface VerificationViewController : BaseViewController
@property (nonatomic, retain)NSString* userName;
@property (nonatomic, retain)NSString* userMobileNo;
@property (nonatomic, retain)NSString* userEmail;
@property (nonatomic, retain)NSString* verificationCode;
@property (nonatomic, weak)IBOutlet UITextField* verificationCodeTxtField;
@property (nonatomic, weak)IBOutlet UILabel* descpLbl;
@property (nonatomic, weak)IBOutlet UIScrollView* scrolView;
@end
