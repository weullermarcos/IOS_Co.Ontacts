//
//  PageContentViewController.h
//  CoOntacts
//
//  Created by Hoff Silva on 14/09/16.
//  Copyright © 2016 Weuller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *label_Instruction;
@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *contentText;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UILabel *label_Content;


@end
