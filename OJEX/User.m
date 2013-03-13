//
//  User.m
//  OJEX
//
//  Created by alham fikri on 1/16/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize name,userId,password,isPremium,status,email,lastUpdate,avatar,avatarURL,isPrivate,lastLocation,source,destination,profile;

- (void) createDataWithJSON:(NSDictionary *)data
{
    self.name = [data objectForKey:@"name"];
    self.email = [data objectForKey:@"email"];
    self.userId = [data objectForKey:@"userId"];
    self.username = @"";
    //self.username = [data objectForKey:@"username"];
    self.password = [data objectForKey:@"password"];
    self.isPremium = [[data objectForKey:@"isPremium"] boolValue];
    self.profile = [[UserProfile alloc] init];
    
    self.profile.bio = [NSString stringWithFormat:@"%@",[data objectForKey:@"bio"]];
    
    
    self.profile.deliver = [[data objectForKey:@"deliverCounter"] intValue];
    self.profile.phoneNumber = [data objectForKey:@"phoneNumber"];
    self.profile.motorDesc = [data objectForKey:@"motorDesc"];
    
   // self.name = [json objectForKey:@"name"];
}

@end

