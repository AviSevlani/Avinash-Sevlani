//
//  NewAddressViewController.m
//  PicaKart
//
//  Created by Avinash Sevlani on 30/11/14.
//  Copyright (c) 2014 amstark. All rights reserved.
//

#import "NewAddressViewController.h"
#import "AFNetworking.h"
#import "Configure.h"
#import "AppDelegate.h"

@interface NewAddressViewController ()<UITextViewDelegate,UIScrollViewDelegate>
{
    NSString* addressString;
}

@end

@implementation NewAddressViewController

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
                         self.scrollView.contentOffset = CGPointMake(0, self.scrollView.contentOffset.y);
                     } completion:^(BOOL finished) {
                         
                     }];
}

#pragma mark - 

- (void)saveNewAddress
{
    
    NSURL *baseURL = [NSURL URLWithString:BASE_URL_STR];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    AppDelegate* appDelgate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    [manager.requestSerializer setValue:appDelgate.memberId forHTTPHeaderField:@"memberid"];
    [manager.requestSerializer setValue:addressString forHTTPHeaderField:@"address"];
    
    
    [manager POST:[NSString stringWithFormat:@"%@/%@",MEMBER_URL,SAVE_ADDRESS_URL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary* dict = (NSDictionary*)responseObject;
        
        NSString* addressId = @"";
        if ([dict objectForKey:@"SaveAddressResult"])
        {
            if ([[dict objectForKey:@"SaveAddressResult"]objectForKey:@"Message"])
            {
                addressId = [[dict objectForKey:@"SaveAddressResult"]objectForKey:@"Message"];
                
                NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                [dict setObject:addressId forKey:@"id"];
                [dict setObject:addressString forKey:@"Address"];
                
                 AppDelegate* appDelgate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
                [appDelgate.userData.addressArray addObject:dict];
                [self.delegateRef selectedAddress:dict];
            }
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

- (IBAction)didTappedSaveButton:(id)sender
{
    if (!self.enterName.text.length)
    {
        [[[UIAlertView alloc]initWithTitle:@"Incomplete Address" message:@"Enter Name" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil]show];
    }
   else if (!self.enterAdressTextView.text.length)
    {
        [[[UIAlertView alloc]initWithTitle:@"Incomplete Address" message:@"Enter Address" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil]show];
    }
//    else if (!self.enterLandmark.text.length)
//    {
//        [[[UIAlertView alloc]initWithTitle:@"Incomplete Address" message:@"Enter Landmark" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil]show];
//    }
    else if (!self.enterZipcode.text.length)
    {
        [[[UIAlertView alloc]initWithTitle:@"Incomplete Address" message:@"Enter Zipcode" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil]show];
    }
    else
    {
        addressString = [NSString stringWithFormat:@"%@,%@,%@,%@",self.enterName.text,self.enterAdressTextView.text,self.enterLandmark.text,self.enterZipcode.text];
        [self saveNewAddress];
    }

    
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (self.enterAdressTextView.text.length)
    {
        self.adressPlaceholder.hidden = YES;
    }
    else
    {
        self.adressPlaceholder.hidden = NO;
    }
}


-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{

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
