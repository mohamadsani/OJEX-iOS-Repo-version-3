//
//  Transaction.h
//  OJEX
//
//  Created by alham fikri on 1/29/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coordinate.h"

@interface Transaction : NSObject

@property int transactionId;
@property int userId;
@property int providerId;
@property Coordinate* source;
@property Coordinate* destination;
@property int paymentMethod;
@property float price;
@property bool privacy;

@end
