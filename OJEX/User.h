//
//  User.h
//  OJEX
//
//  Created by alham fikri on 1/16/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coordinate.h"
#import "UserProfile.h"

@interface User : NSObject
enum {
    UserDriver = 0,
    UserPassanger = 1,
    UserSelf = 2
};
typedef NSUInteger UserStatusType;

@property NSString* name;
@property NSString* username;
@property NSString* email;
@property NSString* userId;
@property NSString* password;
@property bool isPremium;
@property UserStatusType status;
@property NSDate* lastUpdate;
@property Coordinate* lastLocation;
@property NSString* avatarURL;
@property UIImage* avatar;
@property bool isPrivate;
@property NSString* source;
@property NSString* destination;
@property UserProfile* profile;

- (void) createDataWithJSON:(NSDictionary*) data;
@end
