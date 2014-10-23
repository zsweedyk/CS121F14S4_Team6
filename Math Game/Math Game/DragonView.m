//
//  DragonView.m
//  Math Game
//
//  Created by Dani Demas on 10/22/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "DragonView.h"

@implementation DragonView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:@"dragon"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self addSubview:imageView];
    
    return self;
}

@end
