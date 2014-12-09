//
//  PaymentViewController.h
//  PicaKart
//
//  Created by Avinash Sevlani on 02/12/14.
//  Copyright (c) 2014 amstark. All rights reserved.
//

#import "BaseViewController.h"

@interface PaymentViewController : BaseViewController

@property (nonatomic, weak)IBOutlet UIView* couponView;
@property (nonatomic, weak)IBOutlet UIView* paymentTypeView;
@property (nonatomic, weak)IBOutlet UIImageView* cashOnDeliveryImageView;
@property (nonatomic, weak)IBOutlet UIImageView* paypalImageView;
@property (nonatomic, strong)NSDictionary* selectedAddressDict;

@property (nonatomic, weak)IBOutlet UIView* paymentDetails;
@property (nonatomic, weak)IBOutlet UILabel* paymentDate;
@property (nonatomic, weak)IBOutlet UILabel* paymentStatus;
@property (nonatomic, weak)IBOutlet UILabel* paymentAmount;



@end
