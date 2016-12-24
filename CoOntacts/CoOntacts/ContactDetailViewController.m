//
//  ContactDetailViewController.m
//  CoOntacts
//
//  Created by Weuller Marcos on 17/12/16.
//  Copyright © 2016 Weuller. All rights reserved.
//

#import "ContactDetailViewController.h"
#import "ContactMapViewController.h"

@interface ContactDetailViewController ()

@end

@implementation ContactDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"Contato";
    
    [self.contactName setText:self.contact.nome];
    [self.contactPhone setText:self.contact.telefone];
    [self.contactEmail setText:self.contact.email];
    [self.contactDescriptioon setText:self.contact.descricao];


    UIImage *image = [UIImage imageWithData:self.contact.imagem];
    
    //Seta a imagem recuperada
    [self.contactImage setImage:image];
    
    
}

- (IBAction)showContactInMap:(id)sender {
    
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"ContactMapSegue"])
    {
        
        ContactMapViewController *detailVC = segue.destinationViewController;

        detailVC.contact = self.contact;
        
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
