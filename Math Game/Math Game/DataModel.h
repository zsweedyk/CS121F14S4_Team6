//
//  NSObject+DataModel.h
//  Math Game
//
//  Created by Hugo Ho on 10/17/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject
{
    double _currentScore;
}

- (void) applySheepChar:(char)operator andValue:(NSString*)givenValue;
- (double) getScore;

@end
