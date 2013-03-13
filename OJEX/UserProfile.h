//
//  UserProfile.h
//  OJEX
//
//  Created by alham fikri on 1/29/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserProfile : NSObject

@property int userId;
@property float rate;
@property NSString* phoneNumber;
@property NSString* bio;
@property NSString* motorDesc;
@property UIImage* motorImage;
@property int deliver;
@property NSString* licenseNumber;
@property NSString* alamat;

@end
