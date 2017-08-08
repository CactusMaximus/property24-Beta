//
//  PropertyResultCell.m
//  p24Beta0.1
//
//  Created by Reverside Software Solutions on 2017/07/21.
//  Copyright © 2017 Reverside Software Solutions. All rights reserved.
//

#import "PropertyResultCell.h"

@implementation PropertyResultCell

@synthesize shortDesc = _shortDesc;
@synthesize price = _price;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
