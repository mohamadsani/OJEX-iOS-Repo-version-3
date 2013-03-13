//
//  TimelineItem.h
//  OJEX
//
//  Created by alham fikri on 1/29/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Coordinate.h"

@interface TimelineItem : NSObject


@property User* user;
@property Coordinate* source;
@property Coordinate* destination;
@property NSDate* timestamp;
@property int priceInPoint;
@property int priceInRupiah;
@property NSString* via;

- (void) createDataWithJSON:(NSDictionary*) data;
@end
