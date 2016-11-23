//
//  PageContentViewController.m
//  CoOntacts
//
//  Created by Hoff Silva on 14/09/16.
//  Copyright © 2016 Weuller. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.label_Instruction.text = self.titleText;
    
    if(self.pageIndex == 2){
        
        self.loginButton.hidden = false;
    }
    else{
        
        self.loginButton.hidden = true;
    }
    
    [self applyBackgroudColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
