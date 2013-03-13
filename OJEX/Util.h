//
//  Util.h
//  OJEX
//
//  Created by alham fikri on 1/15/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Util : UIViewController<NSURLConnectionDataDelegate,UIActionSheetDelegate>

@property (retain, nonatomic) NSMutableData *receivedData;

+ (void) showLoading;
+ (void) hideLoading;
+ (void) showErrorWithMessage:(NSString*)x;
+ (void) showMessage:(NSString*)x;
+ (void) slideFrame:(UIViewController*) x toUp:(BOOL) direction;
+ (void) slideFrame:(UIViewController*) x toUp:(BOOL) direction withHeight:(int) h;
+ (float) rupiahToPoint:(float) rupiah;
@end
