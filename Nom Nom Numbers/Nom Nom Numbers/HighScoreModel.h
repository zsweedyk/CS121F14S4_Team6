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

- (void) checkExists;
- (void) saveScore:(double)currentScore;
- (NSMutableArray *) getTopTen;

@end