//
//  ItemDetailViewController.m
//  Homepwner
//
//  Created by Luis Carbuccia on 8/23/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "ImageStore.h"

@interface ItemDetailViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *serialTextField;
@property (strong, nonatomic) IBOutlet UITextField *valueTextField;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;

@end

@implementation ItemDetailViewController

#pragma mark - View...

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Do any additional setup after loading the view.
    self.nameTextField.text = self.item.name;
    self.serialTextField.text = self.item.serialNumber;
    self.valueTextField.text = [NSString stringWithFormat:@"$%i", self.item.value];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    self.dateLabel.text = [formatter stringFromDate:self.item.dateOfCreation];
    
    // get image for corresponding key from the image store
    NSString *imageKey = self.item.key;
    UIImage *imageToDisplay = [[ImageStore sharedStore] imageForKey:imageKey];
    
    // use that image to put on the in the imageView
    self.imageView.image = imageToDisplay;
}

#pragma mark - IBAction Methods

- (IBAction)cameraButtonPressed:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // if the device has a camera, take a picture. Otherwise, just from photo library
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    
    // place image picker on the screen
    [self presentViewController:imagePicker
                       animated:YES
                     completion:nil];
}

#pragma mark - Delegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Get picked image from infor dictionary
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // store the image in the ImageStore for this key
    [[ImageStore sharedStore] setImage:image forKey:self.item.key];
    
    // put that image onto the screen in our image view
    self.imageView.image = image;
    
    // Take image picker off the screen
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
