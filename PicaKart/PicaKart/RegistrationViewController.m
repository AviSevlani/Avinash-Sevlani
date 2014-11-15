//
//  RegistrationViewController.m
//  PicaKart
//
//  Created by Avinash Sevlani on 09/11/14.
//  Copyright (c) 2014 amstark. All rights reserved.
//

#import "RegistrationViewController.h"
#import "VerificationViewController.h"
#import "AFNetworking.h"
#import "Configure.h"

@interface RegistrationViewController ()<UITextFieldDelegate>
{
    NSString* verificationCode;
}

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, 416);

}


- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];

}

#pragma mark - Notification Handler

- (void) keyboardWillHide:(NSNotification *)notification
{
    NSDictionary* userInfo = [notification userInfo];
    
    NSNumber* duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
     int keyboardHeight = 0;
    
    
    [UIView animateWithDuration:duration.doubleValue
                     animations:^{
                         self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardHeight, 0);
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void) keyboardWillShow:(NSNotification *)notification
{
    NSDictionary* userInfo = [notification userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSNumber* duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
  int  keyboardHeight = keyboardSize.height;
    
    [UIView animateWithDuration:duration.doubleValue
                     animations:^{
                          self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardHeight, 0);
                     } completion:^(BOOL finished) {
                    
                     }];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    VerificationViewController* verificationVc = segue.destinationViewController;
    verificationVc.verificationCode = verificationCode;
    verificationVc.userName = self.nameTextFlied.text;
    verificationVc.userMobileNo = self.mobileTextFlied.text;
    verificationVc.userEmail  = self.emailAdressTextFlied.text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)sendVerificationCodeClicked:(id)sender
{
    BOOL verified = YES;
    
    if (verified)
    {
        NSURL *baseURL = [NSURL URLWithString:BASE_URL_STR];
        NSDictionary *parameters = @{@"mobile": self.mobileTextFlied.text};
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager POST:[NSString stringWithFormat:@"%@/%@",MEMBER_URL,SEND_VERIFICATION_URL] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSDictionary* dict = (NSDictionary*)responseObject;
            
            verificationCode = [[dict objectForKey:@"SendVerificationResult"] objectForKey:@"Message"];
            
            [self performSegueWithIdentifier:@"verificationSegue" sender:self];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Verification Request"
                                                                message:[error localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }];
    }
  
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendVerificationCodeClicked:nil];
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
