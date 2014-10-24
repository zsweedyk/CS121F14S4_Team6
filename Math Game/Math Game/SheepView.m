//
//  UIView+SheepView.m
//  Math Game
//
//  Created by Hugo Ho on 10/17/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "SheepView.h"
#import "SheepModel.h"

@interface SheepView ()
{
    CGPoint _pos;
    CGFloat _sheepHeight;
    CGFloat _sheepWidth;
    CGFloat _sheepXCoord;
    CGFloat _sheepYCoord;
    BOOL _gameOngoing;
    char _currentOperator;
    NSString* _currentValue;
    
}

@end


@implementation SheepView : UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    _gameOngoing = YES;
    
    CGRect innerFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:innerFrame];

    _sheep.image = [UIImage imageNamed:@"Sheep"];
    _sheep = [[UIImageView alloc]init];

    _sheepWidth = 100;
    _sheepHeight = 60;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    singleTap.numberOfTapsRequired = 1;
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:singleTap];

    [self addSubview:imageView];
    [self addSubview:_sheep];
    
    return self;
}

- (UIImage*) getImageWithString:(NSString*)text for:(char)input
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

- (void) moveSheepFrom:(CGPoint)start to:(CGPoint)end whileGame:(BOOL)gameOngoing
{
    _gameOngoing = gameOngoing;
    
    _sheep = [[UIImageView alloc] initWithFrame:CGRectMake(start.x, start.y, _sheepWidth, _sheepHeight)];
    _sheep.image = [UIImage imageNamed:@"Sheep"];
    
    _sheep = [[UIImageView alloc] initWithFrame:CGRectMake(start.x, start.y, _sheepWidth, _sheepHeight)];
    _sheep.image = [UIImage imageNamed:@"Sheep"];
    
    _pos = CGPointMake(-1.0,0.0);
    
    // Timer will not repeat if _gameOngoing is false. This halts the stream of sheep.
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(onTimer) userInfo:nil repeats:_gameOngoing];
    
}

- (void) displayValue:(NSString*)value
{
    _currentValue = value;
    [self getImageWithString:value for:'V'];
}

- (void) displayOperator:(char)oper
{
    _currentOperator = oper;
    NSString* stringOperator = [NSString stringWithFormat:@"%c" , oper];
    [self getImageWithString:stringOperator for:'O'];
}

- (void) onTimer
{
    _sheepXCoord = _sheep.center.x +_pos.x;
    _sheepYCoord = _sheep.center.y + _pos.y;
    _sheep.center = CGPointMake(_sheepXCoord, _sheepYCoord);
    if (_sheep.center.x == -50) {
        [self removeFromSuperview];
        [self.customSheepViewDelegate generateNewSheep];
    }
    
    [self addSubview:_sheep];
}

- (void) tapDetected:(UIGestureRecognizer *)gestureRecognizer
{
    CGRect sensitiveSpot = CGRectMake(_sheepXCoord - (_sheepWidth/2), _sheepYCoord - (_sheepHeight/2), _sheepWidth, _sheepHeight);
    CGPoint p = [gestureRecognizer locationInView:self];

    if (CGRectContainsPoint(sensitiveSpot, p)) {
        [self removeFromSuperview];
        [self.customSheepViewDelegate applySheep:self withOper:_currentOperator andValue:_currentValue];
    }
}

@end
