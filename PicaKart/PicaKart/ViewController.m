//
//  ViewController.m
//  PicaKart
//
//  Created by Avinash Sevlani on 08/11/14.
//  Copyright (c) 2014 amstark. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "Configure.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getUserMetaData];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)getUserMetaData
{
    
    AppDelegate * appDelgate = (AppDelegate*)[[UIApplication sharedApplication]delegate];

    
    NSURL *baseURL = [NSURL URLWithString:BASE_URL_STR];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:appDelgate.memberId forHTTPHeaderField:@"memberId"];
        [manager.requestSerializer setValue:lab forHTTPHeaderField:@"vendorId"];
       [manager.requestSerializer setValue:sha forHTTPHeaderField:@"sha"];
    
    
    [manager POST:[NSString stringWithFormat:@"%@/%@",MEMBER_URL,USER_METADATA_URL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary* dict = (NSDictionary*)responseObject;
        
      //  verificationCode = [[dict objectForKey:@"SendVerificationResult"] objectForKey:@"Message"];
        
        //[self performSegueWithIdentifier:@"verificationSegue" sender:self];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error MetaData Request"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];

}

- (IBAction)photoPrintsClicked:(id)sender
{
    [self performSegueWithIdentifier:@"printSegue" sender:self];
}

- (IBAction)tShirtPrintsClicked:(id)sender
{
    [self performSegueWithIdentifier:@"printSegue" sender:self];
}

- (IBAction)mugPrintsClicked:(id)sender
{
    [self performSegueWithIdentifier:@"printSegue" sender:self];
}

- (IBAction)photoBookClicked:(id)sender
{
    [self performSegueWithIdentifier:@"printSegue" sender:self];
}

@end
