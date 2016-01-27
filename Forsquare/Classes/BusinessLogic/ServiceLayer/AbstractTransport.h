//
//  AbstractTransport.h
//  EventGridManager
//
//  Created by Anton Kovalchuk on 07.01.15.
//  Copyright (c) 2015 Entech Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbstractTransport : NSObject
- (NSURLSession *) defaultSession;
- (void) alertError;
- (void) alertErrorWithMessage:(NSString *)message;

- (NSURLSessionDataTask *) getRequestWithAPIversion:(NSString *)APIversion
                           method:(NSString *)method
                   showErrorAlert:(BOOL)showErrorAlert
                     completionOK:(void(^)(id answerJSON))callbackOK
                  completionError:(void(^)(void))callbackError
                 completionAnyway:(void(^)(void))callbackAnyway;

- (void) postRequestWithAPIversion:(NSString *)APIversion
                            method:(NSString *)method
                        httpMethod:(NSString *)httpMethod
                        jsonParams:(NSDictionary *)jsonParams
                    showErrorAlert:(BOOL)showErrorAlert
                      completionOK:(void(^)(id answerJSON))callbackOK
                   completionError:(void(^)(void))callbackError
                  completionAnyway:(void(^)(void))callbackAnyway;

- (void) uploadRequestWithAPIversion:(NSString *)APIversion
                              method:(NSString *)method
                          httpMethod:(NSString *)httpMethod
                                data:(NSData *)data
                      showErrorAlert:(BOOL)showErrorAlert
                        completionOK:(void(^)(id answerJSON))callbackOK
                     completionError:(void(^)(void))callbackError
                    completionAnyway:(void(^)(void))callbackAnyway;
@end
