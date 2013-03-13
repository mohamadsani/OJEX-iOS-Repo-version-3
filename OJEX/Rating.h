//
//  Rating.h
//  OJEX
//
//  Created by alham fikri on 1/29/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rating : NSObject
@property float rate;
@property int reviewerId;
@property int providerId;
@property NSString* comment;

@end
