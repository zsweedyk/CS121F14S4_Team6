//
//  HighScoreModel.m
//  Nom Nom Numbers
//
//  Created by Hugo Ho on 11/23/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "HighScoreModel.h"

@implementation HighScoreModel


{
    NSMutableArray* _timedHighScores;
}

- (id)init {
    
    _timedHighScores = [[NSMutableArray alloc] init];
    
    return self;
}

- (bool) updateHighScores:(double)newScore forMode:(NSString *)mode {
    
//    NSFileManager *filemgr = [NSFileManager defaultManager];
//    NSData *databuffer;
      //NSString* filePath = [[NSBundle mainBundle] pathForResource:@"timedHighScores" ofType:@"txt"];
//    
//    databuffer = [filemgr contentsAtPath:filePath];
//    
//   _timedHighScores = [NSKeyedUnarchiver unarchiveObjectWithData:databuffer];
//    NSLog(@"timed scores count: %d", _timedHighScores.count);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"timedHighScores.txt"];
    
    NSFileManager *filemgr;
    
    filemgr = [NSFileManager defaultManager];   
    
        if ([filemgr fileExistsAtPath:filePath] == YES) {
            NSLog(@"File exists");
        } else {
            NSLog(@"File not found");
        }
    
    
    //_timedHighScores = [NSMutableArray arrayWithContentsOfFile:filePath];
    

    bool newHighScore = false;
    NSNumber* score = [NSNumber numberWithDouble:newScore];
    NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
    
    if (_timedHighScores.count == 10) {
        if ([[_timedHighScores objectAtIndex:9] doubleValue] < newScore) {
            [_timedHighScores replaceObjectAtIndex:9 withObject:score];
            newHighScore = true;
            NSLog(@"in if if");
        }
    } else {
        [_timedHighScores addObject:score];
        newHighScore = true;
        NSLog(@"in else");
    }
    
    
    [_timedHighScores sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
    //NSData* myData = [NSKeyedArchiver archivedDataWithRootObject:_timedHighScores];
    
    NSLog(@"timed high scores: %@", _timedHighScores);
    
    [_timedHighScores writeToFile:filePath atomically:YES];
    
    return newHighScore;
}

- (NSArray *) getTimedHighScores {
    return _timedHighScores;
}
@end
