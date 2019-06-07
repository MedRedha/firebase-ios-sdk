/*
 * Copyright 2019 Google
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// TODO: Add short docs to the undocumented API.
#import <Foundation/Foundation.h>

#import "FIRInstallationsStatus.h"

@class FIRInstallationsStoredAuthToken;

NS_ASSUME_NONNULL_BEGIN

/**
 * The class is supposed to be used by `FIRInstallationsStore` only. It is required to
 * serealize/deserialize the installation data into/from `NSData` to be stored in Keychain.
 *
 * WARNING: Modification of the class properties can lead to incompatibility with the stored data
 * encoded by the previous class versions. Any modification must be evaluated and, if it is really
 * needed, the `storageVersion` must be bumped and proper migration code added.
 */
@interface FIRInstallationsStoredItem : NSObject <NSSecureCoding>

@property(nonatomic, copy, nullable) NSString *firebaseInstallationID;
/// The `refreshToken` is used to authorize the auth token requests.
@property(nonatomic, copy, nullable) NSString *refreshToken;
@property(nonatomic, nullable) FIRInstallationsStoredAuthToken *authToken;
@property(nonatomic) FIRInstallationsStatus registrationStatus;

/// The version of local storage.
@property(nonatomic) NSInteger storageVersion;
@end

NS_ASSUME_NONNULL_END
