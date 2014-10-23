//
//  UIView+SheepView.m
//  Math Game
//
//  Created by Hugo Ho on 10/17/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "SheepView.h"
@import SpriteKit;


@interface SheepView (){
    
    UIImageView* sheep;
    
    UIImage* sheepImage;
    
    CGPoint pos;
    
    CGFloat sheepHeight;
    CGFloat sheepWidth;
}

@end


@implementation SheepView : UIView

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
    [[UIColor whiteColor] set];
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
    [[UIColor whiteColor] set];
    UIFont *font = [UIFont boldSystemFontOfSize:12];
    NSDictionary *att = @{NSFontAttributeName:font};
    [text drawInRect:rect withAttributes:att];
    
    sheep = (UIImageView*)UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}


- (void) moveSheepFrom:(CGPoint)start to:(CGPoint)end
{
    sheepWidth = 100;
    sheepHeight = 60;
    
    sheep = [[UIImageView alloc] initWithFrame:CGRectMake(start.x, start.y, sheepWidth, sheepHeight)];
    sheep.image = [UIImage imageNamed:@"Sheep"];
    
    pos = CGPointMake(-1.0,0.0);
    
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
}


- (void) displayValue:(double)value
{
    //sheepImage = [sheep image];
    NSString* stringValue;
    NSNumber* numberValue = [NSNumber numberWithDouble:value];
    stringValue = [numberValue stringValue];
    
    [self drawText:stringValue inImage:(UIImage*)sheep atPoint:CGPointMake(sheep.center.x,sheep.center.y)];
}


- (void) displayOperator:(NSString*)string
{
    [self drawText:string inImage:(UIImage*)sheep atPoint: CGPointMake(sheep.center.x-20, sheep.center.y)];
}


- (void) onTimer {
    sheep.center = CGPointMake(sheep.center.x+pos.x,sheep.center.y+pos.y);
    if (sheep.center.x < -50)
        sheep.center = CGPointMake(sheep.center.x+860, sheep.center.y);
    
}

@end
