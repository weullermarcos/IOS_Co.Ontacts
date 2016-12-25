//
//  SecondViewController.h
//  CoOntacts
//
//  Created by ALUNO on 10/08/16.
//  Copyright © 2016 Weuller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtLogin;

@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginButtonConstraint;

- (IBAction)LoginAction:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewOthersPeopleConstraint;

- (IBAction)TouchDown:(id)sender;


@end
