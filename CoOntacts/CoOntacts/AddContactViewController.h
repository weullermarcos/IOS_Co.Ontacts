//
//  AddContactViewController.h
//  CoOntacts
//
//  Created by Weuller Marcos on 13/11/16.
//  Copyright © 2016 Weuller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddContactViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *name;

@property (weak, nonatomic) IBOutlet UITextField *phone;

@property (weak, nonatomic) IBOutlet UITextField *email;

@property (weak, nonatomic) IBOutlet UITextField *contactDescription;

@property (weak, nonatomic) IBOutlet UIImageView *userImage;


- (IBAction)uploadImage:(id)sender;

- (IBAction)cancel:(id)sender;

- (IBAction)createUser:(id)sender;


@end
