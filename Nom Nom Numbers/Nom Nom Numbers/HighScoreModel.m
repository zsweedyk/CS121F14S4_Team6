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

- (void) checkExists
{
    NSString* docsDir;
    NSArray* dirPaths;
    
    // Get directory of documents
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    // Build database path
    _highScoreDBPath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"highScores.db"]];
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    // If the database file doesn't already exist, create it
    if ([fileManager fileExistsAtPath:_highScoreDBPath] == NO) {
        const char* dbPath = [_highScoreDBPath UTF8String];
        
        if (sqlite3_open(dbPath, &_highScoreDB) == SQLITE_OK) {
            char* errorMessage;
            const char* createDBFileSQL = "CREATE TABLE IF NOT EXISTS highScores (ID INTEGER PRIMARY KEY AUTOINCREMENT, SCORE REAL)";
            
            if (sqlite3_exec(_highScoreDB, createDBFileSQL, NULL, NULL, &errorMessage) != SQLITE_OK) {
                NSLog(@"Failed to create table");
            }
            
            sqlite3_close(_highScoreDB);
            
        } else {
            NSLog(@"Failed to open or create table");
        }
    }
}

- (IBAction) saveScore:(double)currentScore
{
    sqlite3_stmt* statementInSQL;
    const char* dbPath = [_highScoreDBPath UTF8String];
    
    if (sqlite3_open(dbPath, &_highScoreDB) == SQLITE_OK) {
        NSString* insertScoreSQL = [NSString stringWithFormat:@"INSERT INTO highScores (score) VALUES (\"%f\")]", currentScore];
        const char* insertSQLStatement = [insertScoreSQL UTF8String];
        sqlite3_prepare_v2(_highScoreDB, insertSQLStatement, -1, &statementInSQL, NULL);
        
        if (sqlite3_step(statementInSQL) == SQLITE_DONE) {
            NSLog(@"Added score of %f to database!", currentScore);
        } else {
            NSLog(@"Failed to add score to database...");
        }
        
        sqlite3_finalize(statementInSQL);
        sqlite3_close(_highScoreDB);
    }
}

- (NSMutableArray *) getTopTen
{
    NSMutableArray* arrayOfScores = [[NSMutableArray alloc] init];
    
    sqlite3_stmt* statementInSQL;
    const char* dbPath = [_highScoreDBPath UTF8String];
    
    if (sqlite3_open(dbPath, &_highScoreDB) == SQLITE_OK) {
        NSString *getTopTenSQL = @"SELECT score FROM highScores ORDER BY score DESC LIMIT 10";
        const char* querySQLStatement = [getTopTenSQL UTF8String];
        
        if (sqlite3_prepare_v2(_highScoreDB, querySQLStatement, -1, &statementInSQL, NULL) == SQLITE_OK) {
            
            while (sqlite3_step(statementInSQL) == SQLITE_ROW) {
                NSString* score = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statementInSQL, 0)];
                NSLog(@"Score is %@", score);
                
                [arrayOfScores addObject:score];
            }
            
            sqlite3_finalize(statementInSQL);
            
        } else {
            NSLog(@"No data found");
        }
    }
    
    sqlite3_finalize(statementInSQL);
    sqlite3_close(_highScoreDB);
    return arrayOfScores;
}

@end