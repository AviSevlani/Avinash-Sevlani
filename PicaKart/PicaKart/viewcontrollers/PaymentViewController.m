//
//  PaymentViewController.m
//  PicaKart
//
//  Created by Avinash Sevlani on 02/12/14.
//  Copyright (c) 2014 amstark. All rights reserved.
//

#import "PaymentViewController.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "Configure.h"

@interface PaymentViewController ()

@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.paypalImageView.highlighted = YES;
    AppDelegate* appDelgate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    self.paymentDetails.hidden = YES;
    if (appDelgate.userData.isCouponAvailable)
    {
        self.paymentTypeView.hidden = YES;
    }
    else if(appDelgate.userData.isCodAvailable)
    {
        self.couponView.hidden = YES;
    }
    else
    {
        self.paymentTypeView.hidden = YES;
        self.couponView.hidden = YES;
        self.paymentDetails.hidden = NO;
    }
    
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)checkCodAvailable
{
    NSURL *baseURL = [NSURL URLWithString:BASE_URL_STR];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //AppDelegate* appDelgate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    NSArray* stringArray = [[self.selectedAddressDict objectForKey:@"Address"] componentsSeparatedByString:@","];
    
    [manager.requestSerializer setValue:[stringArray lastObject] forHTTPHeaderField:@"zip"];
    [manager.requestSerializer setValue:vendorId forHTTPHeaderField:@"vendorId"];
    
    
    [manager POST:[NSString stringWithFormat:@"%@/%@",MEMBER_URL,COD_AVAILABLE_URL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject objectForKey:@"codAvailableResult"]){
            
            if ([[responseObject objectForKey:@"codAvailableResult"] objectForKey:@"Message"])
            {
                if ([[[responseObject objectForKey:@"codAvailableResult"] objectForKey:@"Message"] isEqualToString:@"COD unavailable"])
                {
                    [self codNotAvailable];
                }
                else
                {
                    self.couponView.hidden = YES;
                    self.paymentTypeView.hidden = YES;
                }
            }
            else
            {
                [self codNotAvailable];
            }
        }
        else
        {
            [self codNotAvailable];
        }
        
           } failure:^(NSURLSessionDataTask *task, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Verification Request"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];

}


#pragma mark - Actions

- (void)codNotAvailable
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"COD Not Available"
                                                        message:@"Cash on Delivery Facility is not Available For Selected Address"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
    
    self.couponView.hidden = YES;
    self.paymentTypeView.hidden = NO;
   // self.paymentDetails.hidden = NO;

}


- (IBAction)couponSkipButtonClicked:(id)sender
{
//    self.couponView.hidden = YES;
//    self.paymentTypeView.hidden = NO;
    
    AppDelegate* appDelgate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    if (!appDelgate.userData.isCodAvailable)
    {
        
    }
    else
    {
        [self checkCodAvailable];
    }
}

- (IBAction)couponValidateButtonClicked:(id)sender
{
//    self.couponView.hidden = YES;
//    self.paymentTypeView.hidden = NO;
    
    AppDelegate* appDelgate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    if (!appDelgate.userData.isCodAvailable)
    {
        
    }
    else
    {
        [self checkCodAvailable];
    }

}


- (IBAction)payPalButtonClicked:(id)sender
{
    self.paypalImageView.highlighted = YES;
    self.cashOnDeliveryImageView.highlighted = NO;
}
- (IBAction)cashOnDeliveryCliked:(id)sender
{
    self.paypalImageView.highlighted = NO;
    self.cashOnDeliveryImageView.highlighted = YES;
}

- (IBAction)paymentModeContinueClicked:(id)sender
{
    self.couponView.hidden = YES;
    self.paymentTypeView.hidden = YES;
    self.paymentDetails.hidden = NO;
}

@end
