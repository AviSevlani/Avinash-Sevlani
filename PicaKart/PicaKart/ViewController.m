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
#import "UserMetaData.h"
#import "ConfirmOrderViewController.h"

@interface ViewController ()
{
    AppDelegate * appDelgate;
    int selectedButton;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getUserMetaData];
    appDelgate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - prepare for segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ConfirmOrderViewController* vc = (ConfirmOrderViewController *)segue.destinationViewController;
    vc.selectedCategory = selectedButton;
}


#pragma mark - Hits

- (void)getUserMetaData
{
    
   
    
    NSURL *baseURL = [NSURL URLWithString:BASE_URL_STR];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:appDelgate.memberId forHTTPHeaderField:@"memberId"];
        [manager.requestSerializer setValue:lab forHTTPHeaderField:@"vendorId"];
       [manager.requestSerializer setValue:sha forHTTPHeaderField:@"sha"];
    
    
    [manager POST:[NSString stringWithFormat:@"%@/%@",MEMBER_URL,USER_METADATA_URL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
         NSDictionary* dict = (NSDictionary*)responseObject;
        
        
        if ([dict objectForKey:@"MetaDataResult"])
        {
            if (!appDelgate.userData)
            {
                [appDelgate initializeUserMetadat];
            }
            [appDelgate parseMetadat:[dict objectForKey:@"MetaDataResult"]];
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error MetaData Request"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];

}

#pragma mark - Actions

- (IBAction)photoPrintsClicked:(id)sender
{
    if (appDelgate.userData.photoPrintsArray && [appDelgate.userData.photoPrintsArray count])
    {
                selectedButton = 0;
         [self performSegueWithIdentifier:@"printSegue" sender:self];
        
    }
    else
    {
        
    }
   
}

- (IBAction)tShirtPrintsClicked:(id)sender
{
    if (appDelgate.userData.tShirtPrintsArray && [appDelgate.userData.tShirtPrintsArray count])
    {
        selectedButton = 1;
        [self performSegueWithIdentifier:@"printSegue" sender:self];
    }
    else
    {
        
    }
    
}

- (IBAction)mugPrintsClicked:(id)sender
{
    if (appDelgate.userData.mugPrintsArray && [appDelgate.userData.mugPrintsArray count])
    {
                        selectedButton = 2;
        [self performSegueWithIdentifier:@"printSegue" sender:self];
    }
    else
    {
        
    }
    
}

- (IBAction)photoBookClicked:(id)sender
{
    if (appDelgate.userData.photoBookPrintsArray && [appDelgate.userData.photoBookPrintsArray count])
    {
                        selectedButton = 3;
        [self performSegueWithIdentifier:@"printSegue" sender:self];
    }
    else
    {
        
    }
    
}

@end
