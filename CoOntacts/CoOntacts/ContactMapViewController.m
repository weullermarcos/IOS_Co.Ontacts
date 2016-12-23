//
//  ContactMapViewController.m
//  CoOntacts
//
//  Created by Weuller Marcos on 23/12/16.
//  Copyright © 2016 Weuller. All rights reserved.
//

#import "ContactMapViewController.h"
@import MapKit;
@import CoreLocation;

@interface ContactMapViewController ()

@end

@implementation ContactMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setTitle:@"Mapa"];
    
}


-(void) viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    

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
