//
//  FIRHeartbeatInfoTest.m
//  FirebaseCore-iOS-Unit-unit
//
//  Created by Vinay Guthal on 10/23/19.
//

#import <FirebaseCore/FIRHeartbeatInfo.h>
#import <GoogleUtilities/GULStorageHeartbeat.h>
#import <XCTest/XCTest.h>

@interface FIRHeartbeatInfoTest : XCTestCase

@property(nonatomic, strong) GULStorageHeartbeat *dataStorage;

@property(nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation FIRHeartbeatInfoTest

- (void)setUp {
  NSString *const kHeartbeatStorageFile = @"HEARTBEAT_INFO_STORAGE";
  self.dataStorage = [[GULStorageHeartbeat alloc]
      initWithFileURL:[FIRHeartbeatInfo filePathURLWithName:kHeartbeatStorageFile]];
  NSDate *pastTime = [NSDate dateWithTimeIntervalSinceNow:-96400];
  [self.dataStorage setHearbeatDate:pastTime forTag:@"fire-iid"];
  [self.dataStorage setHearbeatDate:pastTime forTag:@"GLOBAL"];
}

- (void)testCombinedHeartbeat {
  Heartbeat heartbeatCode = [FIRHeartbeatInfo getHeartbeatCode:@"fire-iid"];
  XCTAssertEqual(heartbeatCode, COMBINED);
}

- (void)testSdkOnlyHeartbeat {
  [self.dataStorage setHearbeatDate:[NSDate date] forTag:@"GLOBAL"];
  Heartbeat heartbeatCode = [FIRHeartbeatInfo getHeartbeatCode:@"fire-iid"];
  XCTAssertEqual(heartbeatCode, SDK);
}

- (void)testGlobalOnlyHeartbeat {
  [self.dataStorage setHearbeatDate:[NSDate date] forTag:@"fire-iid"];
  Heartbeat heartbeatCode = [FIRHeartbeatInfo getHeartbeatCode:@"fire-iid"];
  XCTAssertEqual(heartbeatCode, GLOBAL);
}

- (void)testNoHeartbeat {
  [self.dataStorage setHearbeatDate:[NSDate date] forTag:@"fire-iid"];
  [self.dataStorage setHearbeatDate:[NSDate date] forTag:@"GLOBAL"];
  Heartbeat heartbeatCode = [FIRHeartbeatInfo getHeartbeatCode:@"fire-iid"];
  XCTAssertEqual(heartbeatCode, NONE);
}

@end
