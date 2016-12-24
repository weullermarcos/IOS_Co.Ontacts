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

- (IBAction)LoginAction:(id)sender;


- (IBAction)TouchDown:(id)sender;


@end
