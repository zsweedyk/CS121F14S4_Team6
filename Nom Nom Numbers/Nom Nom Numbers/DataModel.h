//
//  DataModel.h
//  Nom Nom Numbers
//
//  Created by Shannon on 10/25/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject
{
    double _currentScore;
}

- (void) applySheepChar:(char)operator andValue:(NSString *)givenValue;
- (double) getScore;

@end