//
//  AbstractTransport.m
//  EventGridManager
//
//  Created by Anton Kovalchuk on 07.01.15.
//  Copyright (c) 2015 Entech Solutions. All rights reserved.
//

#import "AbstractTransport.h"
#import "Constants.h"
#import "ServiceLayer.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface AbstractTransport()  <NSURLSessionDelegate>
//- (NSURLSession *) defaultSession;
@end

@implementation AbstractTransport

- (NSURLSession *) defaultSession
{
    return [NSURLSession sessionWithConfiguration:[self defaultSessionConfiguration]
                                         delegate:self
                                    delegateQueue:[NSOperationQueue mainQueue]];
    
}
/*
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        if([challenge.protectionSpace.host isEqualToString:[Constants instance].host])
        {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
        }
    }
}
*/
- (NSURLSessionConfiguration *)defaultSessionConfiguration
{
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSMutableDictionary *headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Accept"];
    [headers setObject:@"application/json" forKey:@"Content-Type"];
//    [headers setObject:[Constants instance].host forKey:@"Host"];
    

    [sessionConfig setHTTPAdditionalHeaders:headers];
    
    return sessionConfig;
}

- (void) alertError
{
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ERROR", @"error")
                                                             message:@"Network error"
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        [errorAlert show];
}

- (void) alertErrorWithMessage:(NSString *)message
{
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ERROR", @"error")
                                                             message:message
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        [errorAlert show];
}

- (NSURLSessionDataTask *) getRequestWithAPIversion:(NSString *)APIversion
                           method:(NSString *)method
                   showErrorAlert:(BOOL)showErrorAlert
                     completionOK:(void(^)(id answerJSON))callbackOK
                  completionError:(void(^)(void))callbackError
                 completionAnyway:(void(^)(void))callbackAnyway
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    
    NSURLSession *session = [self defaultSession];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[Constants instance].base_url, APIversion, method]];
    NSLog(@"Request: url=%@\nheaders=%@",url,session.configuration.HTTPAdditionalHeaders);
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSInteger code = [httpResponse statusCode];
        NSLog(@"Response: statusCode=%ld\n encodingData=%@%@\n",(long)code, [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding], error ? [NSString stringWithFormat:@"\nerror=%@",[error userInfo]] : @"");
          
        NSError *jsonError;
          
        id notesJSON;
        
        @try
        {
            notesJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        }
        @catch (NSException *ex)
        {
            notesJSON = nil;
        }
        
        NSLog(@"notesJSON=%@",notesJSON);
          
        if (!error && code == 200)
        {
            if(!jsonError)
            {
                if([[notesJSON objectForKey:@"isSuccess"] intValue] == 1)
                {
                    callbackOK(notesJSON);
                }
                else
                {
                    if(showErrorAlert)
                    {
                        if([notesJSON objectForKey:@"argumentErrors"] && [[notesJSON objectForKey:@"argumentErrors"] count])
                        {
                            NSMutableString *errorMessage = [[NSMutableString alloc] init];
                            for(NSDictionary *error in [notesJSON objectForKey:@"argumentErrors"])
                            {
                                if([error objectForKey:@"errorMessage"])
                                    [errorMessage appendString:[error objectForKey:@"errorMessage"]];
                            }
                            
                            [self alertErrorWithMessage:errorMessage];
                        }
                        else if([notesJSON objectForKey:@"error"])
                        {
                            if([[notesJSON objectForKey:@"error"] objectForKey:@"errorMessage"])
                                [self alertErrorWithMessage:[[notesJSON objectForKey:@"error"] objectForKey:@"errorMessage"]];
                            else
                                [self alertError];
                        }
                        else
                        {
                            [self alertError];
                        }
                    }
                    callbackError();
                }
            }
            else
            {
                if(showErrorAlert)
                    [self alertError];
                callbackError();
            }
        }
        else
        {
            if(showErrorAlert)
                [self alertError];
            callbackError();
        }
        callbackAnyway();
        
        CFTimeInterval elapsed = CFAbsoluteTimeGetCurrent() - start;

        NSLog(@"dataWithContentsOfURL elapsed time: %.3f", elapsed);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
    [postDataTask resume];
    return postDataTask;
}

- (void) postRequestWithAPIversion:(NSString *)APIversion
                            method:(NSString *)method
                        httpMethod:(NSString *)httpMethod
                        jsonParams:(NSDictionary *)jsonParams
                    showErrorAlert:(BOOL)showErrorAlert
                      completionOK:(void(^)(id answerJSON))callbackOK
                   completionError:(void(^)(void))callbackError
                  completionAnyway:(void(^)(void))callbackAnyway
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    
    NSError *error;
    NSData *jsonData;
    
    if ([NSJSONSerialization isValidJSONObject:jsonParams])
    {
        jsonData = [NSJSONSerialization dataWithJSONObject:jsonParams
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
        
        if (error)
        {
            [self alertError];
            callbackError();
            callbackAnyway();
            return;
        }
    }
    else
    {
        [self alertError];
        callbackError();
        callbackAnyway();
        return;
    }

    
    NSString *jsonRequest;
    if (jsonData)
        jsonRequest = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    NSURLSession *session = [self defaultSession];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[Constants instance].base_url, APIversion, method]];
    NSLog(@"Request: url=%@\nheaders=%@\njsonParams=%@",url,session.configuration.HTTPAdditionalHeaders,jsonParams);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:httpMethod];
    [request setHTTPBody:jsonData];
    [request setValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSInteger code = [httpResponse statusCode];
        NSLog(@"Response: statusCode=%ld\n encodingData=%@%@\n",(long)code, [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding], error ? [NSString stringWithFormat:@"\nerror=%@",[error userInfo]] : @"");
          
        NSError *jsonError;
          
        id notesJSON;
        
        @try
        {
            notesJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        }
        @catch (NSException *ex)
        {
            notesJSON = nil;
        }
        NSLog(@"notesJSON=%@",notesJSON);
          
        if (!error && code == 200)
        {
            if(!jsonError)
            {
                if([[notesJSON objectForKey:@"isSuccess"] intValue] == 1)
                {
                    callbackOK(notesJSON);
                }
                else
                {
                    if(showErrorAlert)
                    {
                        if([notesJSON objectForKey:@"argumentErrors"] && [[notesJSON objectForKey:@"argumentErrors"] count])
                        {
                            NSMutableString *errorMessage = [[NSMutableString alloc] init];
                            for(NSDictionary *error in [notesJSON objectForKey:@"argumentErrors"])
                            {
                                if([error objectForKey:@"errorCode"] && [[error objectForKey:@"errorCode"] intValue] == 10200)
                                    [errorMessage appendString:@"The username or password is not correct."];
                                else if([error objectForKey:@"errorMessage"])
                                    [errorMessage appendString:[error objectForKey:@"errorMessage"]];
                            }
                            
                            [self alertErrorWithMessage:errorMessage];
                        }
                        else if([notesJSON objectForKey:@"error"])
                        {
                            if([[notesJSON objectForKey:@"error"] objectForKey:@"errorMessage"])
                                [self alertErrorWithMessage:[[notesJSON objectForKey:@"error"] objectForKey:@"errorMessage"]];
                            else
                                [self alertError];
                        }
                        else
                        {
                            [self alertError];
                        }
                    }
                    callbackError();
                }
            }
            else
            {
                if(showErrorAlert)
                    [self alertError];
                callbackError();
            }
        }
        else
        {
            if(showErrorAlert)
                [self alertError];
            callbackError();
        }
        callbackAnyway();
        
        CFTimeInterval elapsed = CFAbsoluteTimeGetCurrent() - start;
        
        
        NSLog(@"dataWithContentsOfURL elapsed time: %.3f", elapsed);
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
    [postDataTask resume];
}

- (void) uploadRequestWithAPIversion:(NSString *)APIversion
                              method:(NSString *)method
                          httpMethod:(NSString *)httpMethod
                                data:(NSData *)fileData
                      showErrorAlert:(BOOL)showErrorAlert
                        completionOK:(void(^)(id answerJSON))callbackOK
                     completionError:(void(^)(void))callbackError
                    completionAnyway:(void(^)(void))callbackAnyway
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    
    NSURLSession *session = [self defaultSession];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[Constants instance].base_url, APIversion, method]];
    NSLog(@"Request: url=%@\nheaders=%@\n",url,session.configuration.HTTPAdditionalHeaders);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:httpMethod];
    
    NSString *boundary = [self boundaryString];
    [request addValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField:@"Content-Type"];

    NSData *data = [self createBodyWithBoundary:boundary data:fileData filename:@"picture.png"];

    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
          NSInteger code = [httpResponse statusCode];
          NSLog(@"Response: statusCode=%ld\n encodingData=%@%@\n",(long)code, [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding], error ? [NSString stringWithFormat:@"\nerror=%@",[error userInfo]] : @"");
          
          NSError *jsonError;
        
          id notesJSON;
        
          @try
          {
              notesJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
          }
          @catch (NSException *ex)
          {
              notesJSON = nil;
          }
        
          NSLog(@"notesJSON=%@",notesJSON);
          
          if (!error && code == 200)
          {
              if(!jsonError)
              {
                  if([[notesJSON objectForKey:@"isSuccess"] intValue] == 1)
                  {
                      callbackOK(notesJSON);
                  }
                  else
                  {
                      if(showErrorAlert)
                      {
                          if([notesJSON objectForKey:@"argumentErrors"] && [[notesJSON objectForKey:@"argumentErrors"] count])
                          {
                              NSMutableString *errorMessage = [[NSMutableString alloc] init];
                              for(NSDictionary *error in [notesJSON objectForKey:@"argumentErrors"])
                              {
                                  if([error objectForKey:@"errorCode"] && [[error objectForKey:@"errorCode"] intValue] == 10200)
                                      [errorMessage appendString:@"The username or password is not correct."];
                                  else if([error objectForKey:@"errorMessage"])
                                      [errorMessage appendString:[error objectForKey:@"errorMessage"]];
                              }
                              
                              [self alertErrorWithMessage:errorMessage];
                          }
                          else if([notesJSON objectForKey:@"error"])
                          {
                              if([[notesJSON objectForKey:@"error"] objectForKey:@"errorMessage"])
                                  [self alertErrorWithMessage:[[notesJSON objectForKey:@"error"] objectForKey:@"errorMessage"]];
                              else
                                  [self alertError];
                          }
                          else
                          {
                              [self alertError];
                          }
                      }
                      callbackError();
                  }
              }
              else
              {
                  if(showErrorAlert)
                      [self alertError];
                  callbackError();
              }
          }
          else
          {
              if(showErrorAlert)
                  [self alertError];
              callbackError();
          }
          callbackAnyway();
          
          CFTimeInterval elapsed = CFAbsoluteTimeGetCurrent() - start;
          

          
          NSLog(@"dataWithContentsOfURL elapsed time: %.3f", elapsed);
          
          [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
      }];
    [uploadTask resume];
}

- (NSData *) createBodyWithBoundary:(NSString *)boundary data:(NSData*)data filename:(NSString *)filename
{
    NSMutableData *body = [NSMutableData data];
    
    if (data)
    {
        //only send these methods when transferring data as well as username and password
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n", filename] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", [self mimeTypeForPath:filename]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:data];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    /*
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"username\"\r\n\r\n%@\r\n", username] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"password\"\r\n\r\n%@\r\n", password] dataUsingEncoding:NSUTF8StringEncoding]];
    */
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    return body;
}

- (NSString *)boundaryString
{
    NSString *uuidStr = [[NSUUID UUID] UUIDString];
    return [NSString stringWithFormat:@"Boundary-%@", uuidStr];
}

- (NSString *)mimeTypeForPath:(NSString *)path
{
    CFStringRef extension = (__bridge CFStringRef)[path pathExtension];
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, extension, NULL);

    NSString *mimetype = CFBridgingRelease(UTTypeCopyPreferredTagWithClass(UTI, kUTTagClassMIMEType));
    
    CFRelease(UTI);
    
    return mimetype;
}

- (NSString *)prettyPrintedJson:(id)jsonObject
{
    NSData *jsonData;
    
    if ([NSJSONSerialization isValidJSONObject:jsonObject])
    {
        NSError *error;
        jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
        
        if (error)
        {
            return nil;
        }
    }
    else
    {
        jsonData = jsonObject;
    }
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
