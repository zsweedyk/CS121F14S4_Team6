//
//  UIView+SheepView.m
//  Math Game
//
//  Created by Hugo Ho on 10/17/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "SheepView.h"
#import "SheepModel.h"
@import SpriteKit;


@interface SheepView (){
    
    //UIImageView* sheep;
    
    UIImage* sheepImage;
    
    CGPoint pos;
    
    CGFloat sheepHeight;
    CGFloat sheepWidth;
}

@end


@implementation SheepView : UIView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    CGRect innerFrame = CGRectMake(0,0, frame.size.width, frame.size.height);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:innerFrame];

    /*
    sheepWidth = 100;
    sheepHeight = 60;
    
    sheep = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, sheepWidth, sheepHeight)];
    sheep.image = [UIImage imageNamed:@"Sheep"];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self addSubview:imageView];
    */
    
    UIImage *sheepImage1 = [UIImage imageNamed:@"Sheep"];
    //sheepImage1.
   // _sheep = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 60)];
    _sheep = [[UIImageView alloc]init];
    sheepImage = sheepImage1;
    [self addSubview:imageView];
    [self addSubview:_sheep];
    //[self moveSheepFrom:CGPointMake(400,400) to:CGPointMake(0.0,0.0)];
    
    return self;
}

-(UIImageView*) myLoadImage:(NSString*)named at:(CGPoint)location
{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:named]];
    CGRect frame = imgView.frame;
    frame.origin.x = location.x;
    frame.origin.y = location.y;
    return imgView;
}


+(UIImage*) drawText1:(NSString*) text
              inImage:(UIImage*)  image
              atPoint:(CGPoint)   point
{
    
    UIFont *font = [UIFont boldSystemFontOfSize:12];
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(point.x, point.y, image.size.width, image.size.height);
    [[UIColor blackColor] set];
    NSDictionary *att = @{NSFontAttributeName:font};
    [text drawInRect:rect withAttributes:att];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(void) drawText:(NSString*) text
             inImage:(UIImage*)  image
             atPoint:(CGPoint)   point
{
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(point.x, point.y, image.size.width, image.size.height);
    [[UIColor blackColor] set];
    UIFont *font = [UIFont boldSystemFontOfSize:12];
    NSDictionary *att = @{NSFontAttributeName:font};
    [text drawInRect:rect withAttributes:att];
    
    _sheep = (UIImageView*)UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}


- (void) moveSheepFrom:(CGPoint)start to:(CGPoint)end
{
    sheepWidth = 100;
    sheepHeight = 60;
    
    _sheep = [[UIImageView alloc] initWithFrame:CGRectMake(start.x, start.y, sheepWidth, sheepHeight)];
    sheepImage = [UIImage imageNamed:@"Sheep"];
    
    _sheep.image = sheepImage;
    
    pos = CGPointMake(-1.0,0.0);
    
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
}


- (void) displayValue:(double)value
{
    //sheepImage = [sheep image];
    NSString* stringValue;
    NSNumber* numberValue = [NSNumber numberWithDouble:value];
    stringValue = [numberValue stringValue];
    
    [self drawText:stringValue inImage:sheepImage atPoint:CGPointMake(_sheep.center.x,_sheep.center.y)];
}


- (void) displayOperator:(NSString*)string
{
    [self drawText:string inImage:sheepImage atPoint: CGPointMake(_sheep.center.x-20, _sheep.center.y)];
}


- (void) onTimer {
    _sheep.center = CGPointMake(_sheep.center.x+pos.x,_sheep.center.y+pos.y);
    if (_sheep.center.x < -50)
        _sheep.center = CGPointMake(_sheep.center.x+860, _sheep.center.y);
    [self addSubview:_sheep];
}

@end
