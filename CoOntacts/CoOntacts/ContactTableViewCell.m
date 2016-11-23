//
//  ContactTableViewCell.m
//  CoOntacts
//
//  Created by Weuller Marcos on 15/11/16.
//  Copyright © 2016 Weuller. All rights reserved.
//

#import "ContactTableViewCell.h"

@implementation ContactTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.contactImage.layer.cornerRadius = self.contactImage.frame.size.height * 0.01;
//    self.contactImage.layer.cornerRadius = 10;
    self.contactImage.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
