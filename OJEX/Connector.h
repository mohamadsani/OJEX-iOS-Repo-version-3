//
//  Connector.h
//  OJEX
//
//  Created by alham fikri on 2/5/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

/*
 Class ini bersifat Plug n Play, jadi bisa di copy ke project2 lain kedepannya
 Fungsi utama class ini: Melakukan HTTP POST request 

 created by: Alham Fikri Aji
 version: 1.1 (5/2/2013)
 
 HOW TO USE THIS CLASS UTILITY:
 
 Class ini bersifat Singleton, jangan gunakan init, tapi gunakan built-in method getInstance
 
 Untuk melakukan request HTTP Post, gunakan method [HTTPPostURL] dengan parameter:<URL request, sender, keys, data, dan selector,withLoading>
 > URL adalah URL dari HTTP Post
 > untuk sender , selalu masukkan 'self' (unless you know what you doing)
 > keys adalah NSMutableArray yang berisi list of string dari parameter2
 > data adalah NSMutableArray yang berisi list of string dari nilai tiap parameter2. Perhatikan jumlah keys dan data HARUS sama, sbg contohnya, keys = {"username","password","usia"}, data = {"chamatz","tampan123","18"}
 > selector adalah sebuah fungsi yang ingin dipanggil ketika HTTP Post telah selesai melakukan request
 > isi withLoading dengan YES jika ingin menampilkan tampilan loading, atau NO jika tidak ingin menampilkan tampilan loading
 
 Untuk mendapatkan hasil request, perhatikan variabel berikut:
 > recievedJSON berisi string berformat JSON yang merupakan hasil kembalian dari request terakhir
 > recievedStatus berisi hasil dari request terakhir, apakah sukses, failed, atau canceled. Gunakan enum
 
 Contoh pemakaian secara kasar:
  1. Membuat instance:
    
    Connector* c = [Connector getInstance];
 
  2. melakukan HTTPPost:
      
    [c HTTPPostURL:@"www.isengaja.com/postdong"
         withSender:self 
         withKeys: [[NSMutableArray alloc] initWithObjects:@"username",@"password" nil]
         withData: [[NSMutableArray alloc] initWithObjects:@"chamatz",@"tampan", nil]
         callWhenDone: @selector(fungsiSelesai)
         withLoading: YES
        ];
 
    3. membuat fungsi cather untuk menerima hasil request
       
    -(void) fungsiSelesai {
            if ([c receivedStatus] == REQUEST_SUCCESS)
                NSLog(@"hasil kembaliannya adalah %@", [c receivedJSON] );
        }
 
 */


#import <Foundation/Foundation.h>

@interface Connector : NSObject<NSURLConnectionDataDelegate, UIAlertViewDelegate>
enum {
    REQUEST_SUCCESS = 0,
    REQUEST_FAILED = 1,
    REQUEST_CANCELED = 2
};
typedef NSUInteger RequestRespond;

@property (retain, nonatomic) NSURLConnection *connection;
@property (retain, nonatomic) NSMutableData *receivedData;
@property (retain,nonatomic) NSString* receivedJSON;
@property RequestRespond receivedStatus;

+ (Connector*) getInstance;
- (void) HTTPPostURL:(NSString*) url withSender:(id) send withKeys:(NSMutableArray*) key andData:(NSMutableArray*) data callWhenDone:(SEL) sel withLoading:(bool) loading;

@end
