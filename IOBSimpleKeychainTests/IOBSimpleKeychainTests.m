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

- (void)testWhenPuttingDataThenKeyMustNotBeNil {
    XCTAssertFalse([self.testObject putString:@"str" atKey:@""]);
}

- (void)testWhenPuttingDataThenKeyMustHaveSomeValue {
    
    XCTAssertFalse([self.testObject putData:[@"data" dataUsingEncoding:NSASCIIStringEncoding] atKey:@""]);
}

- (void)testPuttingNilDataDoesNotCrash {
    XCTAssertFalse([self.testObject putData:nil atKey:@"foo"]);
}

- (void)testPuttingStringDataDoesNotCrash {
    XCTAssertFalse([self.testObject putString:nil atKey:@"foo"]);
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
