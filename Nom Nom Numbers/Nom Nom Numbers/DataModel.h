//
//  DataModel.h
//  Nom Nom Numbers
//
//  Created by Shannon on 10/25/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DataModel;
@protocol sendScoreDelegate

- (void)sendScore:(double)score;

@end

@interface DataModel : NSObject

@property(nonatomic, weak) id<sendScoreDelegate> customDelegate;

@property (nonatomic) double _currentScore;
@property (nonatomic) int _targetScore;

- (void) applySheepChar:(char)operator andValue:(NSString *)givenValue;
- (double) getScore;
- (void) setTargetScore:(int)score;
- (int) getTargetScore;
- (void) resetScore;
- (double) calculateTargetScoreAtTime:(double)time;

@end