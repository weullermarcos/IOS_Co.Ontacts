//
//  ContactDetailViewController.h
//  CoOntacts
//
//  Created by Weuller Marcos on 17/12/16.
//  Copyright © 2016 Weuller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato+CoreDataClass.h"

@interface ContactDetailViewController : UIViewController

@property(nonatomic) Contato *contact;

@property (weak, nonatomic) IBOutlet UIImageView *contactImage;

@property (weak, nonatomic) IBOutlet UITextField *contactName;

@property (weak, nonatomic) IBOutlet UITextField *contactPhone;

@property (weak, nonatomic) IBOutlet UITextField *contactEmail;

@property (weak, nonatomic) IBOutlet UITextField *contactDescriptioon;


- (IBAction)showContactInMap:(id)sender;


@end
