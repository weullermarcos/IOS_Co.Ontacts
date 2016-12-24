//
//  SecondViewController.m
//  CoOntacts
//
//  Created by ALUNO on 10/08/16.
//  Copyright © 2016 Weuller. All rights reserved.
//

#import "SecondViewController.h"
#import "AppDelegate.h"
#import "Contato+CoreDataClass.h"

@interface SecondViewController () <UITextFieldDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self applyBackgroudColor];
    
    [self.txtLogin setDelegate:self];
    [self.txtPassword setDelegate:self];
    
}


- (void) applyBackgroudColor{
    
    // Create the colors
    //255 165 000
    UIColor *bottomColor = [UIColor colorWithRed:255.0/255.0 green:200.0/255.0 blue:50.0/255.0 alpha:1.0];
    
    //255 140 000
    UIColor *topColor = [UIColor colorWithRed:255.0/255.0 green:100.0/255.0 blue:0.0/255.0 alpha:1.0];
    
    
    // Create the gradient
    CAGradientLayer *theViewGradient = [CAGradientLayer layer];
    theViewGradient.colors = [NSArray arrayWithObjects: (id)bottomColor.CGColor, (id)topColor.CGColor, nil];
    theViewGradient.frame = self.view.bounds;
    
    //Add gradient to view
    [self.view.layer insertSublayer:theViewGradient atIndex:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)LoginAction:(id)sender {
    
    if([self.txtLogin.text isEqual: @"weuller"] && [self.txtPassword.text isEqual: @"123"]){
    
        //Inserir usuários na base local
        //[self insereDadosCarga];
        
        //Direciona para a proxima tela
        [self performSegueWithIdentifier:@"segueLoginSuccess" sender:self];
        
    }
    else{
        

        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Alerta"
                                      message:@"Os dados de acesso estão incorretos utilize login: weuller senha: 123"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {}];
        
        [alert addAction:ok];
        
    }
    
}


- (IBAction)TouchDown:(id)sender{
    
    [_txtLogin resignFirstResponder];
    [_txtPassword resignFirstResponder];
    
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.txtLogin) {
        
        [self.txtPassword becomeFirstResponder]; //isso faz o teclado aparecer, com foco no campo de senha
    }
    
    if (textField == self.txtPassword) {
        
        [textField resignFirstResponder]; //isso faz o teclado se esconder
    }
    
    return YES;
}



@end
