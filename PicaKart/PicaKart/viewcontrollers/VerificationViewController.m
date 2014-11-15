//
//  VerificationViewController.m
//  PicaKart
//
//  Created by Avinash Sevlani on 09/11/14.
//  Copyright (c) 2014 amstark. All rights reserved.
//

#import "VerificationViewController.h"
#import "AFNetworking.h"
#import "Configure.h"
#import "AppDelegate.h"

@interface VerificationViewController ()

@end

@implementation VerificationViewController


- (IBAction)verificationCliked:(id)sender
{
    if ([self.verificationCodeTxtField.text isEqualToString:self.verificationCode])
    {
        
        [self registerUser];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Verification Code"
                                                            message:@"Verification code dosen't match"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];

    }
}






- (void)registerUser
{

 
    NSURL *baseURL = [NSURL URLWithString:BASE_URL_STR];
//    NSDictionary *parameters = @{@"name": self.userName,@"email": self.userEmail,@"mobile": self.userMobileNo,@"lab":[NSNumber numberWithInt:lab],@"regType":[NSNumber numberWithInt:regType]};
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager.requestSerializer setValue:self.userName forHTTPHeaderField:@"name"];
    [manager.requestSerializer setValue:self.userEmail forHTTPHeaderField:@"email"];
    [manager.requestSerializer setValue:self.userMobileNo forHTTPHeaderField:@"mobile"];
    [manager.requestSerializer setValue:lab forHTTPHeaderField:@"lab"];
    [manager.requestSerializer setValue:regType forHTTPHeaderField:@"regType"];
    
    
    [manager POST:[NSString stringWithFormat:@"%@/%@",MEMBER_URL,REGISTER_USER_URL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary* dict = (NSDictionary*)responseObject;
        
        NSString* memberId = @"";
        if ([dict objectForKey:@"RegisterResult"])
        {
             if ([[dict objectForKey:@"RegisterResult"]objectForKey:@"Message"])
             {
                 memberId = [[dict objectForKey:@"RegisterResult"]objectForKey:@"Message"];
             }
        }
        
        if (memberId.length)
        {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
            [dictionary setObject:self.userName forKey:@"name"];
            [dictionary setObject:self.userEmail forKey:@"email"];
            [dictionary setObject:self.userMobileNo forKey:@"mobile"];
            [dictionary setObject:memberId forKey:@"memberID"];
            [userDefaults setObject:dictionary forKey:@"userDict"];
            [userDefaults synchronize];
            
            AppDelegate * appDelgate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
            [appDelgate goToDashboard];
        }
        
     

        
//        verificationCode = [[dict objectForKey:@"SendVerificationResult"] objectForKey:@"Message"];
//        
//        [self performSegueWithIdentifier:@"verificationSegue" sender:self];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Verification Request"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.descpLbl.text = [NSString stringWithFormat:@"A 4 digits verification code has been sent on your mobile number (%@). Enter verification code number below and get started with PrintKart.",self.userMobileNo];
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
    self.scrolView.contentSize = CGSizeMake(self.scrolView.frame.size.width, 416);
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


- (void) keyboardWillHide:(NSNotification *)notification
{
    NSDictionary* userInfo = [notification userInfo];
    
    NSNumber* duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    int keyboardHeight = 0;
    
    
    [UIView animateWithDuration:duration.doubleValue
                     animations:^{
                         self.scrolView.contentInset = UIEdgeInsetsMake(0, 0, keyboardHeight, 0);
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
                         self.scrolView.contentInset = UIEdgeInsetsMake(0, 0, keyboardHeight, 0);
                         self.scrolView.contentOffset = CGPointMake(0, self.scrolView.contentOffset.y);
                     } completion:^(BOOL finished) {
                         
                     }];
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

@end
