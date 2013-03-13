//
//  GlobalVar.m
//  OJEX
//
//  Created by alham fikri on 1/30/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import "GlobalVar.h"

@implementation GlobalVar
@synthesize user,userid,userProfile,isConnecting;

static GlobalVar* instance;

//singleton method
+(GlobalVar *)getInstance {
    if (instance == nil) instance = [[GlobalVar alloc] init];
    return instance;
}


@end
