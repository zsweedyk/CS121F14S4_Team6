//
//  DragonView.m
//  Math Game
//
//  Created by Dani Demas on 10/22/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "DragonView.h"

@implementation DragonView

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    CGRect innerFrame = CGRectMake(0,0, frame.size.width, frame.size.height);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:innerFrame];
    imageView.image = [UIImage imageNamed:@"dragon"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self addSubview:imageView];
    
    return self;
}

@end
