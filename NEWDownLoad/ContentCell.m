//
//  ContentCell.m
//  NEWDownLoad
//
//  Created by David on 13-3-28.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "ContentCell.h"

@implementation ContentCell
@synthesize image = _image;
@synthesize title = _title;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_image release];
    [_title release];
    [super dealloc];
}
@end
