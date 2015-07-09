#import <XCTest/XCTest.h>

#import "IOBSimpleKeychain.h"

@interface IOBSimpleKeychainTests : XCTestCase

@property (nonatomic) IOBSimpleKeychain *testObject;

@end

@implementation IOBSimpleKeychainTests

- (void)setUp {
    [super setUp];
    self.testObject = [[IOBSimpleKeychain alloc] initWithServiceName:@"com.indexoutofbounds.simplekeychain" sharedKeychainAccessGroup:@"com.indexoutofbounds.shared"];
}

- (void)testServiceNameMustNotBeNil {
    @try {
        self.testObject = [[IOBSimpleKeychain alloc] initWithServiceName:nil];
        XCTFail(@"Expected exception not thrown.");
        
        self.testObject = [[IOBSimpleKeychain alloc] initWithServiceName:nil sharedKeychainAccessGroup:@"foo"];
        XCTFail(@"Expected exception not thrown.");
        
        XCTFail(@"Expected exception not thrown.");
        
    }
    @catch (NSException *exception) {
    }
}


- (void)testServiceNameMustContainSomeValue {
    @try {
        
        self.testObject = [[IOBSimpleKeychain alloc] initWithServiceName:@""];
        XCTFail(@"Expected exception not thrown.");
        
        self.testObject = [[IOBSimpleKeychain alloc] initWithServiceName:@"" sharedKeychainAccessGroup:@"foo"];
        XCTFail(@"Expected exception not thrown.");
        
    }
    @catch (NSException *exception) {
    }
}

- (void)testWhenPuttingStringThenKeyMustNotBeNil {
    XCTAssertFalse([self.testObject putString:@"str" atKey:nil]);
    
    NSError *error = nil;
    XCTAssertFalse([self.testObject putString:@"str" atKey:nil error:&error]);
    
    XCTAssertNotNil(error);
    XCTAssertEqualObjects(error.domain, @"com.indexoutofbounds.iobsimplekeychain");
    XCTAssertEqual(error.code, 0);
    XCTAssertEqualObjects(error.localizedDescription, @"Invalid arguments");
}

- (void)testWhenPuttingDataThenKeyMustNotBeNil {
    NSData *data = [@"data" dataUsingEncoding:NSASCIIStringEncoding];
    XCTAssertFalse([self.testObject putData:data
                                      atKey:nil]);
    
    
    NSError *error = nil;
    XCTAssertFalse([self.testObject putData:data
                                      atKey:nil
                                      error:&error]);
    
    XCTAssertNotNil(error);
    XCTAssertEqualObjects(error.domain, @"com.indexoutofbounds.iobsimplekeychain");
    XCTAssertEqual(error.code, 0);
    XCTAssertEqualObjects(error.localizedDescription, @"Invalid arguments");
}

- (void)testWhenPuttingStringThenKeyMustNotBeEmpty {
    XCTAssertFalse([self.testObject putString:@"str" atKey:@""]);
    
    NSError *error = nil;
    XCTAssertFalse([self.testObject putString:@"str" atKey:@"" error:&error]);
    
    XCTAssertNotNil(error);
    XCTAssertEqualObjects(error.domain, @"com.indexoutofbounds.iobsimplekeychain");
    XCTAssertEqual(error.code, 0);
    XCTAssertEqualObjects(error.localizedDescription, @"Invalid arguments");
}

- (void)testWhenPuttingDataThenKeyMustNotBeEmpty {
    NSData *data = [@"data" dataUsingEncoding:NSASCIIStringEncoding];
    XCTAssertFalse([self.testObject putData:data
                                      atKey:@""]);
    
    
    NSError *error = nil;
    XCTAssertFalse([self.testObject putData:data
                                      atKey:@""
                                      error:&error]);
    
    XCTAssertNotNil(error);
    XCTAssertEqualObjects(error.domain, @"com.indexoutofbounds.iobsimplekeychain");
    XCTAssertEqual(error.code, 0);
    XCTAssertEqualObjects(error.localizedDescription, @"Invalid arguments");
}

- (void)testPuttingNilDataThenDataMustNotBeNil {
    XCTAssertFalse([self.testObject putData:nil atKey:@"foo"]);
    
    NSError *error = nil;
    XCTAssertFalse([self.testObject putData:nil
                                      atKey:@"foo"
                                      error:&error]);
    
    XCTAssertNotNil(error);
    XCTAssertEqualObjects(error.domain, @"com.indexoutofbounds.iobsimplekeychain");
    XCTAssertEqual(error.code, 0);
    XCTAssertEqualObjects(error.localizedDescription, @"Invalid arguments");
}

- (void)testPuttingStringThenStringMustNotBeNil {
    XCTAssertFalse([self.testObject putString:nil atKey:@"foo"]);
    
    NSError *error = nil;
    XCTAssertFalse([self.testObject putString:nil atKey:@"foo" error:&error]);
    
    XCTAssertNotNil(error);
    XCTAssertEqualObjects(error.domain, @"com.indexoutofbounds.iobsimplekeychain");
    XCTAssertEqual(error.code, 0);
    XCTAssertEqualObjects(error.localizedDescription, @"Invalid arguments");
}

- (void)testPuttingNilDataThenDataMustNotBeEmpty {
    NSData *emptyData = [[NSData alloc] init];
    XCTAssertFalse([self.testObject putData:emptyData atKey:@"foo"]);
    
    NSError *error = nil;
    XCTAssertFalse([self.testObject putData:emptyData
                                      atKey:@"foo"
                                      error:&error]);
    
    XCTAssertNotNil(error);
    XCTAssertEqualObjects(error.domain, @"com.indexoutofbounds.iobsimplekeychain");
    XCTAssertEqual(error.code, 0);
    XCTAssertEqualObjects(error.localizedDescription, @"Invalid arguments");
}

- (void)testPuttingStringThenStringMustNotBeEmpty {
    XCTAssertFalse([self.testObject putString:@"" atKey:@"foo"]);
    
    NSError *error = nil;
    XCTAssertFalse([self.testObject putString:@"" atKey:@"foo" error:&error]);
    
    XCTAssertNotNil(error);
    XCTAssertEqualObjects(error.domain, @"com.indexoutofbounds.iobsimplekeychain");
    XCTAssertEqual(error.code, 0);
    XCTAssertEqualObjects(error.localizedDescription, @"Invalid arguments");
}

- (void)testWhenPuttingStringIntoKeychainThenItCanBeRetrieved {
    
    XCTAssertTrue([self.testObject putString:@"foo" atKey:@"bar"]);
    
    XCTAssertEqualObjects(@"foo", [self.testObject stringForKey:@"bar"]);
    XCTAssertTrue([self.testObject removeItemForKey:@"bar"]);
}

- (void)testWhenPuttingDataIntoKeychainThenItCanBeRetrieved {
    NSData *data = [@"foo" dataUsingEncoding:NSASCIIStringEncoding];
    
    XCTAssertTrue([self.testObject putData:data atKey:@"bar"]);
    
    XCTAssertEqualObjects(data, [self.testObject dataForKey:@"bar"]);
    XCTAssertTrue([self.testObject removeItemForKey:@"bar"]);
}

- (void)testWhenRemovingExistingStringItemThenItIsRemoved {
    [self.testObject putString:@"foo" atKey:@"bar"];
    
    XCTAssertTrue([self.testObject removeItemForKey:@"bar"]);
    
    XCTAssertNil([self.testObject stringForKey:@"bar"]);
}


- (void)testWhenRemovingExistingDataItemThenItIsRemoved {
    NSData *data = [@"foo" dataUsingEncoding:NSASCIIStringEncoding];
    [self.testObject putData:data atKey:@"bar"];
    
    XCTAssertTrue([self.testObject removeItemForKey:@"bar"]);
    
    XCTAssertNil([self.testObject dataForKey:@"bar"]);
}
@end
