//
//  PageContentViewController.h
//  CoOntacts
//
//  Created by Weuller Marcos on 14/09/16.
//  Copyright © 2016 Weuller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *label_Instruction;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UILabel *label_Content;

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property UIImage *localImage;

@property NSUInteger pageIndex;

@property NSString *titleText;

@property NSString *contentText;


@end
