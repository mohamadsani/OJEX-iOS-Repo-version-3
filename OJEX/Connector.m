//
//  Connector.m
//  OJEX
//
//  Created by alham fikri on 2/5/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import "Connector.h"
#import "Util.h"
#import "GlobalVar.h"

@implementation Connector
SEL selector;
id sender;
UIAlertView *loadingAlert;
static Connector* instance;

//singleton method
+(Connector *)getInstance {
    if (instance == nil) instance = [[Connector alloc] init];
    return instance;
}

- (void) showLoading
{
    if (loadingAlert == nil){
        loadingAlert = [[UIAlertView alloc] initWithTitle:@"Loading" message:@"please wait..." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    }
    
    [loadingAlert show];
}

- (void) hideLoading
{
    if (loadingAlert == nil){
        loadingAlert = [[UIAlertView alloc] initWithTitle:@"Loading" message:@"please wait..." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    }
    
    [loadingAlert dismissWithClickedButtonIndex:-1 animated:YES];
    
}

//convert to URL Encoded
- (NSString *) URLEncodedString_ch:(NSString*) input {
    NSMutableString * output = [NSMutableString string];
    NSString* source = input;
    int sourceLen = [source length];
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = [source characterAtIndex:i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        }
        else if (thisChar == '@'){
            [output appendString:@"@"];
            
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

- (void) HTTPPostURL:(NSString*) url withSender:(id) send withKeys:(NSMutableArray*) keys andData:(NSMutableArray*) datas callWhenDone:(SEL) sel withLoading:(bool)loading{
    
    [self.connection cancel];
    
    self.receivedStatus = REQUEST_FAILED;
    
    sender = send;
    
    selector = sel;
    if (loading)
        [self showLoading];
    [[GlobalVar getInstance] setIsConnecting:YES];
    
    NSMutableData *data = [[NSMutableData alloc] init];
    self.receivedData = data;
    
    NSString *urlString = url;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *postString = @"";
    
    //generating the postString:
    for (int i=0;i<[keys count];i++) {
        postString = [postString stringByAppendingFormat:@"%@=%@",[self URLEncodedString_ch:[keys objectAtIndex:i]], [self URLEncodedString_ch:[datas objectAtIndex:i]]];
        
        if (i != [keys count] -1) postString = [postString stringByAppendingFormat:@"&"];
    
    }
    
    [request setValue:[NSString
                       stringWithFormat:@"%d", [postString length]]
   forHTTPHeaderField:@"Content-length"];
    
    [request setHTTPBody:[postString
                          dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection* connect= [[NSURLConnection alloc]
                               initWithRequest:request delegate:self];
    self.connection = connect;
    [self.connection start];
}

/*
 this method might be calling more than one times according to incoming data size
 */
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.receivedData appendData:data];
}

/*
 if there is an error occured, this method will be called by connection
 */
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self hideLoading];
    
    NSLog(@"%@" , error);
    
    [Util hideLoading];
    [[GlobalVar getInstance] setIsConnecting:NO];
    self.receivedStatus = REQUEST_FAILED;
    
    
    if (selector != nil)
        [sender performSelector:selector];
    
    
    
}

/*
 if data is successfully received, this method will be called by connection
 */
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [self hideLoading];
    
    //initialize convert the received data to string with UTF8 encoding
    NSString *htmlSTR = [[NSString alloc] initWithData:self.receivedData
                                              encoding:NSUTF8StringEncoding];
    self.receivedJSON = htmlSTR;
    NSLog(@"receiving = %@", htmlSTR);
    //initialize a new webviewcontroller
    //show controller with navigation
    
    [Util hideLoading];
    [[GlobalVar getInstance] setIsConnecting:NO];
    self.receivedStatus = REQUEST_SUCCESS;
    
    if (selector != nil)
        [sender performSelector:selector];
    
   
    
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the Cancel buttons
    if (buttonIndex == 0)
    {
        self.receivedStatus = REQUEST_CANCELED;
        [self.connection cancel];
        
        NSMutableData *data = [[NSMutableData alloc] init];
        self.receivedData = data;

    }

}

@end
