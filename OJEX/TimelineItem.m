//
//  TimelineItem.m
//  OJEX
//
//  Created by alham fikri on 1/29/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import "TimelineItem.h"

@implementation TimelineItem
@synthesize via,user,source,destination,timestamp,priceInPoint,priceInRupiah;

- (void) createDataWithJSON:(NSDictionary*) data {
    self.user = [[User alloc] init];
    self.user.name = [data objectForKey:@"name"];
    
    self.user.status = UserDriver;
    if ([[data objectForKey:@"status"] isEqualToString:@"P"])
        self.user.status = UserPassanger;
    
    self.priceInPoint = [[data objectForKey:@"priceInPoint"] intValue];
    self.priceInRupiah = [[data objectForKey:@"priceInRupiah"] intValue];
    self.via = [data objectForKey:@"via"];
    self.user.userId = [data objectForKey:@"userId"];
    
    self.source.latitude = [data objectForKey:@"source_latitude"];
    self.source.longitude = [data objectForKey:@"source_longitude"];
    self.destination.latitude = [data objectForKey:@"destination_latitude"];
    self.destination.longitude = [data objectForKey:@"destination_longitude"];

    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-DD HH:mm:ss"];
    
    self.timestamp = [formatter dateFromString:[data objectForKey:@"departTime"]];

}

@end
