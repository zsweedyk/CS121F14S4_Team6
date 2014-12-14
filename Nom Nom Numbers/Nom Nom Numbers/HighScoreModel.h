//
//  HighScoreDB.h
//  Nom Nom Numbers
//
//  Created by Shannon on 11/29/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface HighScoreModel : NSObject

@property (strong, nonatomic) NSString* highScoreDBPath;
@property (nonatomic) sqlite3* highScoreDB;

@property (strong, nonatomic) NSString* targetScoreDBPath;
@property (nonatomic) sqlite3* targetScoreDB;

- (void) checkExists;
- (void) saveScore:(double)currentScore;
- (void) saveTargetScore:(double)currentScore atTime:(double)currentTime;
- (NSMutableArray *) getTopTenForTimed;
- (NSMutableArray *) getTopTenForTarget;

@end