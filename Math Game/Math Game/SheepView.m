//
//  UIView+SheepView.m
//  Math Game
//
//  Created by Hugo Ho on 10/17/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "SheepView.h"
#import "SheepModel.h"

@interface SheepView (){
    
    CGPoint pos;
    
    CGFloat sheepHeight;
    CGFloat sheepWidth;
    
    //SheepModel* _sheepModel;
}

@end


@implementation SheepView : UIView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    //_sheepModel = [[SheepModel alloc]init];
    
    CGRect innerFrame = CGRectMake(0,0, frame.size.width, frame.size.height);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:innerFrame];

    _sheep.image = [UIImage imageNamed:@"Sheep"];
    _sheep = [[UIImageView alloc]init];

    sheepWidth = 100;
    sheepHeight = 60;
    

    [self addSubview:imageView];
    [self addSubview:_sheep];

    return self;
}

-(UIImage*) getImageWithString:(NSString*)text for:(char)input
{
    CGPoint point;
    
    UIGraphicsBeginImageContext(_sheep.image.size);
    [_sheep.image drawInRect:CGRectMake(0,0,_sheep.image.size.width,_sheep.image.size.height)];
    UITextView *myText = [[UITextView alloc] init];
    myText.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:50];
    myText.textColor = [UIColor blackColor];
    myText.text = text;
    myText.backgroundColor = [UIColor clearColor];
    
    if (input == 'V'){
        point = CGPointMake(_sheep.image.size.width/2.15, _sheep.image.size.height/3);
    }
    else if (input == 'O'){
        point = CGPointMake(_sheep.image.size.width/4, _sheep.image.size.height/3.5);
    }
    
    myText.frame = CGRectMake(point.x, point.y, _sheep.image.size.width, _sheep.image.size.height);
    [[UIColor whiteColor] set];
    NSDictionary *att = @{NSFontAttributeName:myText.font};
    [myText.text drawInRect:myText.frame withAttributes:att];
    
    _sheep.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return _sheep.image;
}

- (void) moveSheepFrom:(CGPoint)start to:(CGPoint)end
{
    _sheep = [[UIImageView alloc] initWithFrame:CGRectMake(start.x, start.y, sheepWidth, sheepHeight)];
    _sheep.image = [UIImage imageNamed:@"Sheep"];
    
    pos = CGPointMake(-1.0,0.0);
    
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
}

- (void) displayValue:(NSString*)value
{
    [self getImageWithString:value for:'V'];
}

- (void) displayOperator:(char)oper
{
    NSString* stringOperator = [NSString stringWithFormat:@"%c" , oper];
    [self getImageWithString:stringOperator for:'O'];

}

- (void) onTimer {
    _sheep.center = CGPointMake(_sheep.center.x+pos.x,_sheep.center.y+pos.y);
    if (_sheep.center.x < -50)
        _sheep.center = CGPointMake(_sheep.center.x+860, _sheep.center.y);
    [self addSubview:_sheep];
}

@end
