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

@interface ConfirmOrderViewController ()<UITableViewDataSource,UITableViewDelegate,photoOrderDelegate,UIImagePickerControllerDelegate>
{
    NSMutableArray* imageOrderArray;
    UIBarButtonItem* doneButton;
    NSMutableArray* availableItemArray;
    UIView* grayView;
    NSDictionary* selectedDict;
}

@end

@implementation ConfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     AppDelegate* appDelgate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
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
   
}




- (IBAction)selectPhototSize
{
    if (!grayView)
    {
        grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        grayView.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.5];
    }
    
    selectPhotoSize *photoSizeTableView = [[selectPhotoSize alloc]initWithFrame:CGRectMake(0, 0, 160, 240)];
    photoSizeTableView.backgroundColor = [UIColor whiteColor];
    [grayView addSubview:photoSizeTableView];
     [self.view addSubview:grayView];
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
