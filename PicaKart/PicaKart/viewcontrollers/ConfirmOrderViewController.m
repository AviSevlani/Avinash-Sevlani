//
//  ConfirmOrderViewController.m
//  PicaKart
//
//  Created by Avinash Sevlani on 12/11/14.
//  Copyright (c) 2014 amstark. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "PhotoTableViewCell.h"
#import "AppDelegate.h"
#import "UserMetaData.h"
#import "selectPhotoSize.h"
#import "UIView+Autolayout.h"
#import "UIView+Position.h"

@interface ConfirmOrderViewController ()<UITableViewDataSource,UITableViewDelegate,photoOrderDelegate,UIImagePickerControllerDelegate,selectSizeDelegate>
{
    NSMutableArray* imageOrderArray;
    UIBarButtonItem* doneButton;
    NSMutableArray* availableItemArray;
    UIView* grayView;
    NSDictionary* selectedDict;
    UserMetaData*   userMetaData;
}

@end

@implementation ConfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.orderDetailView.alpha = 0.0;
    
     AppDelegate* appDelgate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    userMetaData = appDelgate.userData;
    
    self.photoSize.text = @"Select Size";
    self.photoSize.layer.borderColor = self.photoSize.textColor.CGColor;
    self.photoSize.layer.borderWidth = 1.0;
    
    imageOrderArray  = [[NSMutableArray alloc]init];
    availableItemArray = [[NSMutableArray alloc]init];
    switch (self.selectedCategory)
    {
        case 0:
        {
            [availableItemArray addObjectsFromArray:appDelgate.userData.photoPrintsArray];
        }
            
            break;
        case 1:
        {
         [availableItemArray addObjectsFromArray:appDelgate.userData.tShirtPrintsArray];
        }
            
            break;
        case 2:
        {
            [availableItemArray addObjectsFromArray:appDelgate.userData.mugPrintsArray];
        }
            
            break;
        case 3:
        {
            [availableItemArray addObjectsFromArray:appDelgate.userData.photoBookPrintsArray];
        }
            break;
            
        default:
            break;
    }
    
    // Do any additional setup after loading the view.
}


- (void)viewDidAppear:(BOOL)animated
{
    CGRect tempRect = self.orderDetailView.frame;
    tempRect.origin.x = self.view.frame.size.width;
    self.orderDetailView.frame = tempRect;

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

#pragma tableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [imageOrderArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return [PhotoTableViewCell cellForImageOrder:[imageOrderArray objectAtIndex:indexPath.row] inTableView:tableView withDelegate:self];
}


#pragma mark - Actions
- (IBAction)addPhotoClicked:(id)sender
{
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = (id)self;
    [self presentViewController:picker animated:YES completion:nil];
    [picker.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

- (IBAction)proceedClicked:(id)sender
{
    if (![imageOrderArray count])
    {
        [[[UIAlertView alloc]initWithTitle:@"No Photo Added" message:@"Please Add photos in order To procede" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
    else if (!selectedDict)
    {
        [[[UIAlertView alloc]initWithTitle:@"No Photo Size Selected" message:@"Please select photos Size To procede" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
    else
    {
        self.totalPrints.text = [NSString stringWithFormat:@"%lu",(unsigned long)[imageOrderArray count]];
        self.deliveryCharges.text = [NSString stringWithFormat:@"%0.2f",userMetaData.codCharge];
        float totalCharge = [[selectedDict objectForKey:@"Price"]floatValue] * [imageOrderArray count];
        totalCharge += userMetaData.codCharge;
        self.totalAmount.text = [NSString stringWithFormat:@"%0.2f",totalCharge];
        
        switch (self.selectedCategory)
        {
            case 0:
            {
                self.printType.text = @"Photo Prints";
            }
                
                break;
            case 1:
            {
               self.printType.text = @"T-shirt Prints";
            }
                
                break;
            case 2:
            {
               self.printType.text = @"Mug Prints";
            }
                
                break;
            case 3:
            {
                self.printType.text = @"Photobook";
            }
                break;
                
            default:
                break;
        }
      
        if ([userMetaData.addressArray count])
        {
            self.address.text = [userMetaData.addressArray objectAtIndex:0];
        }
        else
        {
            [self.changeAddress setTitle:@"Add" forState:UIControlStateNormal];
        }
      
        
        CGRect tempRect = self.orderDetailView.frame;
        tempRect.origin.x = 0;
       

        self.orderDetailView.alpha = 0.8;
        [UIView animateWithDuration:0.6 animations:^{
             self.orderDetailView.alpha = 1.0;
             self.orderDetailView.frame = tempRect;
        }];
       
        
    }
}

- (IBAction)addToCartClicked:(id)sender
{
    
}

- (IBAction)printNowClicked:(id)sender
{
    
}

- (IBAction)changeAddressClicked:(id)sender
{
    
}


- (IBAction)selectPhototSize
{
    if (!grayView)
    {
        grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        grayView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.6];
    }
    
    selectPhotoSize *photoSizeTableView = [[selectPhotoSize alloc]initWithFrame:CGRectMake(0, 0, 160, 180)];
    photoSizeTableView.selectedItem = selectedDict;
    photoSizeTableView.delegateRefrence = self;
    photoSizeTableView.backgroundColor = [UIColor whiteColor];
    photoSizeTableView.layer.cornerRadius = 4.0;
    photoSizeTableView.layer.masksToBounds = YES;
    [grayView addSubview:photoSizeTableView];
    if (![grayView superview])
    {
        [self.view addSubview:grayView];
    }
    
    [photoSizeTableView setSizeArray:availableItemArray];
    [photoSizeTableView centerInParent];
 
    
   
    
    

}

#pragma mark - photoOrderDelegate
- (void)deleteImageOrder:(NSMutableDictionary*)imageOrder
{
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:[imageOrderArray indexOfObject:imageOrder] inSection:0];
    [imageOrderArray removeObject:imageOrder];
    
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark -  selectSizeDelegate
- (void)selectedSize:(id)selectedItemObj
{
    selectedDict = selectedItemObj;
    self.photoSize.text = [selectedDict objectForKey:@"Name"];
    [grayView removeFromSuperview];
}

#pragma mark UIImagePickerControllerDelegate

- (void) saveImage:(UIImage*)image
{
    if( image )
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    UIImage* editedImage = (UIImage*)[info objectForKey:UIImagePickerControllerEditedImage];
    UIImage* originalImage = (UIImage*)[info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSURL* imageUrl = (NSURL*)[info objectForKey:UIImagePickerControllerReferenceURL];
    NSString *imageString = [imageUrl absoluteString];
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"imageId like %@",imageString];
   NSArray* filteredArray = [imageOrderArray filteredArrayUsingPredicate:predicate];
    
    
    if (![filteredArray count])
    {
        UIImage* profileImage = editedImage ? editedImage : originalImage;
        NSMutableDictionary* imageOrderDict = [[NSMutableDictionary alloc]init];
        [imageOrderDict setObject:profileImage forKey:@"image"];
        [imageOrderDict setObject:@"1" forKey:@"noOfOrder"];
        [imageOrderDict setObject:imageString forKey:@"imageId"];
        [imageOrderArray addObject:imageOrderDict];
        
        
        [[[UIAlertView alloc]initWithTitle:@"Photo Added" message:@"Photo selected has been added" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
    else
    {
        [[[UIAlertView alloc]initWithTitle:@"Already Added" message:@"Photo you have selected has been already added" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        
    }
    
}

//Done button on top
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    //NSLog(@"Inside navigationController ...");
    
    
    if (!doneButton)
    {
        doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                      style:UIBarButtonItemStyleDone
                                                     target:self action:@selector(saveImagesDone:)];
    }
    
    viewController.navigationItem.rightBarButtonItem = doneButton;
}

- (IBAction)saveImagesDone:(id)sender
{
    //NSLog(@"saveImagesDone ...");
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}





@end
