//
//  SqliteTest.m
//  XCFMSqliteTests
//
//  Created by caijinzhu on 2017/12/8.
//  Copyright © 2017年 caijinzhu. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "SqliteHelper.h"

@interface SqliteTest : XCTestCase



@end

@implementation SqliteTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testSqliteExample{
    
    NSString *sql = @"create table  if not exists t_person(id integer primary key autoincrement not null,name text not null, age integer, score real)";
    BOOL result = [SqliteHelper execSql:sql onUser:nil];
    
    XCTAssertEqual(result, YES);
    
}

- (void)testQuery{
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
