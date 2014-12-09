//
//  HighScoreDB.m
//  Nom Nom Numbers
//
//  Created by Shannon on 11/29/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.c
//
//  Referred to Computer Science Tutorials

#import "HighScoreModel.h"
#import <sqlite3.h>

@implementation HighScoreModel

- (id) init
{
    [self checkExists];
    return self;
}

- (void) checkExists
{
    NSString* docsDir;
    NSArray* dirPaths;
    
    // Get directory of documents
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    // Build database path for Timed Mode
    _highScoreDBPath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"highScores.db"]];
    
    // Build database path for Target Mode
    _targetScoreDBPath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"targetScores.db"]];
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    // If the database file doesn't already exist, create it
    if ([fileManager fileExistsAtPath:_highScoreDBPath] == NO) {
        const char* dbPath = [_highScoreDBPath UTF8String];
        
        if (sqlite3_open(dbPath, &_highScoreDB) == SQLITE_OK) {
            char* errorMessage;
            const char* createDBFileSQL = "CREATE TABLE IF NOT EXISTS highScores (id INTEGER PRIMARY KEY, score REAL)";
            
            if (sqlite3_exec(_highScoreDB, createDBFileSQL, NULL, NULL, &errorMessage) != SQLITE_OK) {
                NSLog(@"Failed to create table");
            }
            
            sqlite3_close(_highScoreDB);
            
        } else {
            NSLog(@"Failed to open or create table");
        }
    } if ([fileManager fileExistsAtPath:_targetScoreDBPath] == NO) {
        const char* dbPath = [_targetScoreDBPath UTF8String];
        
        if (sqlite3_open(dbPath, &_targetScoreDB) == SQLITE_OK) {
            char* errorMessage;
            const char* createDBFileSQL = "CREATE TABLE IF NOT EXISTS targetScores (id INTEGER PRIMARY KEY, time REAL, score REAL)";
            
            if (sqlite3_exec(_targetScoreDB, createDBFileSQL, NULL, NULL, &errorMessage) != SQLITE_OK) {
                NSLog(@"Failed to create table");
            }
            
            sqlite3_close(_targetScoreDB);
            
        } else {
            NSLog(@"Failed to open or create table");
        }
    }
}

- (void) saveScore:(double)currentScore
{
    sqlite3_stmt* statementInSQL;
    const char* dbPath = [_highScoreDBPath UTF8String];
    
    if (sqlite3_open(dbPath, &_highScoreDB) == SQLITE_OK) {
        NSString* insertScoreSQL = [NSString stringWithFormat:@"INSERT INTO highScores (score) VALUES ('%f')", currentScore];
        const char* insertSQLStatement = [insertScoreSQL UTF8String];
        
        if (sqlite3_prepare_v2(_highScoreDB, insertSQLStatement, -1, &statementInSQL, nil) == SQLITE_OK) {
        
            if (sqlite3_step(statementInSQL) == SQLITE_DONE) {
                // Added score to DB
            } else {
                NSLog(@"Failed to add score to database...");
            }
    
            sqlite3_finalize(statementInSQL);
        }
        
    }
    
    sqlite3_close(_highScoreDB);
}

- (void) saveTargetScore:(double)currentScore atTime:(double)currentTime
{
    sqlite3_stmt* statementInSQL;
    const char* dbPath = [_targetScoreDBPath UTF8String];
    
    if (sqlite3_open(dbPath, &_targetScoreDB) == SQLITE_OK) {
        NSString* insertScoreSQL = [NSString stringWithFormat:@"INSERT INTO targetScores (time, score) VALUES ('%f', '%f')", currentTime, currentScore];
        const char* insertSQLStatement = [insertScoreSQL UTF8String];
        
        if (sqlite3_prepare_v2(_targetScoreDB, insertSQLStatement, -1, &statementInSQL, nil) == SQLITE_OK) {
            
            if (sqlite3_step(statementInSQL) == SQLITE_DONE) {
                // Added score and time to DB
            } else {
                NSLog(@"Failed to add score to database...");
            }
            
            sqlite3_finalize(statementInSQL);
        }
        
    }
    
    sqlite3_close(_targetScoreDB);
}

- (NSMutableArray *) getTopTenForTimed
{
    NSMutableArray* arrayOfScores = [[NSMutableArray alloc] init];
    
    sqlite3_stmt* statementInSQL;
    const char* dbPath = [_highScoreDBPath UTF8String];
    
    if (sqlite3_open(dbPath, &_highScoreDB) == SQLITE_OK) {
        NSString *getTopTenSQL = @"SELECT score FROM highScores ORDER BY score DESC LIMIT 10";
        const char* querySQLStatement = [getTopTenSQL UTF8String];
        
        if (sqlite3_prepare_v2(_highScoreDB, querySQLStatement, -1, &statementInSQL, nil) == SQLITE_OK) {
            
            while (sqlite3_step(statementInSQL) == SQLITE_ROW) {
                NSString* score = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statementInSQL, 0)];
                
                [arrayOfScores addObject:score];
            }
            
            sqlite3_finalize(statementInSQL);
            
        } else {
            NSLog(@"No data found!");
        }
    }
    
    sqlite3_close(_highScoreDB);
    return arrayOfScores;
}

- (NSMutableArray *) getTopTenForTarget
{
    NSMutableArray* arrayOfScores = [[NSMutableArray alloc] init];
    
    sqlite3_stmt* statementInSQL;
    const char* dbPath = [_targetScoreDBPath UTF8String];
    
    if (sqlite3_open(dbPath, &_targetScoreDB) == SQLITE_OK) {
        NSString *getTopTenSQL = @"SELECT time, score FROM targetScores ORDER BY score DESC LIMIT 10";
        const char* querySQLStatement = [getTopTenSQL UTF8String];
        
        if (sqlite3_prepare_v2(_targetScoreDB, querySQLStatement, -1, &statementInSQL, nil) == SQLITE_OK) {
            while (sqlite3_step(statementInSQL) == SQLITE_ROW) {
                NSMutableArray* currentScore = [[NSMutableArray alloc] init];
                NSString* time = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statementInSQL, 0)];
                NSString* score = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statementInSQL, 1)];

                [currentScore addObject:time];
                [currentScore addObject:score];
                [arrayOfScores addObject:currentScore];
            }
            
            sqlite3_finalize(statementInSQL);
            
        } else {
            NSLog(@"No data found");
        }
    }
    
    sqlite3_close(_targetScoreDB);
    return arrayOfScores;
}

@end