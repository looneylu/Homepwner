//
//  AddItemViewController.m
//  Homepwner
//
//  Created by Luis Carbuccia on 8/25/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "AddItemViewController.h"


@interface AddItemViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *itemNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *serialTextField;
@property (strong, nonatomic) IBOutlet UITextField *valueTextField;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@property (strong, nonatomic) NSDate *date;

@end

@implementation AddItemViewController

#pragma mark - View Controller Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // save button should be disabled when view first appears since fields will be empty
    self.saveButton.enabled = NO;
    
    // make sure text fields respond to delegate methods
    self.itemNameTextField.delegate = self;
    self.serialTextField.delegate = self;
    self.valueTextField.delegate = self;
    
    // create a date of creation
    self.date = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    self.dateLabel.text = [dateFormatter stringFromDate:self.date];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

#pragma mark - IBAction Methods

- (IBAction)saveButtonPressed:(id)sender
{
    // save item details
    self.item.name = self.itemNameTextField.text;
    self.item.serialNumber = self.serialTextField.text;
    self.item.value = [self.valueTextField.text intValue];

    // save date of creation
    self.item.dateOfCreation = self.date;
}

- (IBAction)cancelButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cameraButtonPressed:(id)sender {
}

#pragma mark - Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if ([self.itemNameTextField.text length] > 0 && [self.serialTextField.text length] > 0 && [self.valueTextField.text length] > 0)
        self.saveButton.enabled = YES;
    
    return YES;
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
