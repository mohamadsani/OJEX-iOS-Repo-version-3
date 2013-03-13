//
//  GlobalVar.h
//  OJEX
//
//  Created by alham fikri on 1/30/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface GlobalVar : NSObject

@property int userid; //menyimpan userid dari user yang sedang login
@property User* user; //menyimpan objek user yang sedang login
@property User* userProfile; //menyimpan objek user yang sedang ditampilkan di proflie view
@property bool isConnecting; //true jika sedang melakukan request HTTP ke server.
+ (GlobalVar*) getInstance;

@end
