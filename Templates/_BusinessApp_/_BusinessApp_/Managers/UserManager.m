//
//  UserManager.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/19/14.
//  Copyright (c) 2015 Gytenis Mikulėnas
//  https://github.com/GitTennis/SuccessFramework
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE. All rights reserved.
//

#import "UserManager.h"
#import "UserObject.h"
#import "SettingsManager.h"
#import "GMObserverList.h"
#import "UserManagerObserver.h"
#import "KeychainManager.h"

// User persistence keys
#define kUserLoggedInPersistenceKey @"LoggedInUser"
#define kUserKeychainTokenKey @"KeychainUserToken"

@interface UserManager () {
    
    GMObserverList *_observers;
}

@end

@implementation UserManager

@synthesize user = _user;
@synthesize networkOperationFactory = _networkOperationFactory;
@synthesize settingsManager = _settingsManager;
@synthesize analyticsManager = _analyticsManager;

#pragma mark - Public -

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        _user = [[UserObject alloc] init];
        _observers = [[GMObserverList alloc] initWithObservedSubject:self];
    }
    return self;
}

#pragma mark - UserManagerProtocol -

#pragma mark User handling

- (instancetype)initWithSettingsManager:(id <SettingsManagerProtocol>)settingsManager networkOperationFactory:(id <NetworkOperationFactoryProtocol>)networkOperationFactory analyticsManager:(id<AnalyticsManagerProtocol>)analyticsManager {
    
    self = [self init];
    if (self) {
        
        _settingsManager = settingsManager;
        _networkOperationFactory = networkOperationFactory;
        _analyticsManager = analyticsManager;
    }
    return self;
}

- (BOOL)isUserLoggedIn {
    
    return _user.token.length > 0;
}

- (NSError *)saveUser {
    
    /*(UICKeyChainStore *keychain = [KeychainManager keychainSharedStoreForApp];
    NSError *error;
    [keychain setString:_user.masterToken forKey:kUserKeychainTokenKey error:&error];
    
    if (error) {
        *savingError = error;
        _user.masterToken = @"";
        DDLogDebug(@"%@", error.localizedDescription);
        return false;
    }
    
    NSDictionary *dict = [_user toDict];
    [_settingsManager setValue:dict forKey:kUserLoggedInPersistenceKey];*/
    
    return nil;
}

- (NSError *)loadUser {
    
    /*NSDictionary *dict = [_settingsManager valueForKey:kUserLoggedInPersistenceKey defaultValueIfNotExists:nil];
    _user = [[UserObject alloc] initWithDict:dict];
    
    UICKeyChainStore *keychain = [KeychainManager keychainSharedStoreForApp];
    NSError *error;
    NSString *token = [keychain stringForKey:kUserKeychainTokenKey error:&error];
    if (token) {
        
        _user.masterToken = token;
        DDLogDebug(@"Loaded user token: %@", token);
    }
    
    if (error) {
        
        *loadingError = error;
    }*/
    
    return nil;
}


- (void)logout {
    
    /*UICKeyChainStore *keychain = [KeychainManager keychainSharedStoreForApp];
    NSError *error;
    [keychain removeItemForKey:kUserKeychainTokenKey error:&error];
    if (error) {
        
        DDLogError(@"%@", error.localizedDescription);
    }
    _user = nil;
    
    [_settingsManager removeValueForKey:kUserLoggedInPersistenceKey];*/
    
    // There should be a webservice which does login and invalides token (if somebody sniffed and stole it). However there's no such webservice and we do logout locally only and so always consider logout as success immediatelly
    [self notifyObserversWithLogoutSuccess:nil];
}

- (void)loginUserWithData:(UserObject *)data callback:(Callback)callback {
    
    __weak typeof(self) weakSelf = self;
    
    Callback wrappedCallback = ^(BOOL success, id result, NSError *error) {
        
        if (success) {
            
            weakSelf.user = (UserObject *)result;
            
            NSError *err = [weakSelf saveUser];
            if (!err) {
                
                [self notifyObserversWithLoginSuccess:weakSelf.user];
                
            } else {
                
                [self notifyObserversWithLoginFail:err.localizedDescription];
            }
            
        } else {
            
            [self notifyObserversWithLoginFail:[error localizedDescription]];
        }
        
        callback(success, result, error);
    };
    
    id<NetworkOperationProtocol> userLoginOperation = [_networkOperationFactory userLoginNetworkOperation];
    [userLoginOperation performWithParams:nil callback:wrappedCallback];
}

- (void)signUpUserWithData:(UserObject *)data callback:(Callback)callback {
    
    __weak typeof(self) weakSelf = self;
    
    Callback wrappedCallback = ^(BOOL success, id result, NSError *error) {
        
        if (success) {
            
            weakSelf.user = (UserObject *)result;
            NSError *err = [weakSelf saveUser];
            if (!err) {
                
                [self notifyObserversWithSignUpSuccess:weakSelf.user];
                
            } else {
                
                [self notifyObserversWithSignUpFail:err.localizedDescription];
            }
            
        } else {
            
            [self notifyObserversWithSignUpFail:[error localizedDescription]];
        }
        
        callback(success, result, error);
    };
    
    id<NetworkOperationProtocol> userSignUpOperation = [_networkOperationFactory userSignUpNetworkOperation];
    [userSignUpOperation performWithParams:nil callback:wrappedCallback];
}

- (void)resetPassword:(UserObject *)data callback:(Callback)callback {
    
    Callback wrappedCallback = ^(BOOL success, id result, NSError *error) {
        
        if (success) {
            
            [self notifyObserversWithPasswordResetSuccess:nil];
            
        } else {
            
            [self notifyObserversWithPasswordResetFail:nil];
        }
        
        callback(success, result, error);
    };
    
    id<NetworkOperationProtocol> userResetPasswordOperation = [_networkOperationFactory userResetPasswordNetworkOperation];
    [userResetPasswordOperation performWithParams:nil callback:wrappedCallback];
}

- (void)getUserProfileWithCallback:(Callback)callback {
    
    __weak typeof(self) weakSelf = self;
    
    Callback wrappedCallback = ^(BOOL success, id result, NSError *error) {
        
        if (success) {
            
            weakSelf.user = (UserObject *)result;
        }
        
        callback(success, result, error);
    };
    
    id<NetworkOperationProtocol> userProfileOperation = [_networkOperationFactory userProfileNetworkOperation];
    [userProfileOperation performWithParams:nil callback:wrappedCallback];
}

#pragma mark User state observer handling

- (void)addServiceObserver:(id<UserManagerObserver>)observer {
    
    [_observers addObserver:observer];
}

- (void)removeServiceObserver:(id<UserManagerObserver>)observer {
    
    [_observers removeObserver:observer];
}

#pragma mark - Private -

#pragma mark UserManagerObserver handling

- (void)notifyObserversWithLoginSuccess:(UserObject *)userObject {
    
    [_observers notifyObserversForSelector:@selector(didLoginUser:) withObject:userObject];
}

- (void)notifyObserversWithLoginFail:(NSString *)errorMessage {
    
    [_observers notifyObserversForSelector:@selector(didFailedToLoginUser:) withObject:errorMessage];
}

- (void)notifyObserversWithSignUpSuccess:(UserObject *)userObject {
    
    [_observers notifyObserversForSelector:@selector(didSignUpUser:) withObject:userObject];
}

- (void)notifyObserversWithSignUpFail:(NSString *)errorMessage {
    
    [_observers notifyObserversForSelector:@selector(didFailedToSignUpUser:) withObject:errorMessage];
}

- (void)notifyObserversWithUpdateSuccess:(UserObject *)userObject {
    
    [_observers notifyObserversForSelector:@selector(didUpdateUser:) withObject:userObject];
}

- (void)notifyObserversWithUpdateFail:(NSString *)errorMessage {
    
    [_observers notifyObserversForSelector:@selector(didFailedToUpdateUser:) withObject:errorMessage];
}

- (void)notifyObserversWithLogoutSuccess:(UserObject *)userObject {
    
    [_observers notifyObserversForSelector:@selector(didLogoutUser:) withObject:nil];
}

- (void)notifyObserversWithLogoutFail:(NSString *)errorMessage {
    
    [_observers notifyObserversForSelector:@selector(didFailedToLogoutUser:) withObject:errorMessage];
}

- (void)notifyObserversWithPasswordResetSuccess:(NSString *)email {
    
    [_observers notifyObserversForSelector:@selector(didResetPassword:) withObject:email];
}

- (void)notifyObserversWithPasswordResetFail:(NSString *)errorMessage {
    
    [_observers notifyObserversForSelector:@selector(didFailedToResetPassword:) withObject:errorMessage];
}

@end
