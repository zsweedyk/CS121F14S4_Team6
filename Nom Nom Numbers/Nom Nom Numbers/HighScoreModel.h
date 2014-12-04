//
//  HighScoreModel.h
//  Nom Nom Numbers
//
//  Created by Hugo Ho on 11/23/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HighScoreModel : NSObject

- (bool) updateHighScores:(double)newScore forMode:(NSString *)mode;
- (NSArray *) getTimedHighScores;

@end
