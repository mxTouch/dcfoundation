//
//  MPFoundationBridge.h
//  MPFoundation
//
//  Created by Igor Danich on 19.01.16.
//  Copyright © 2016 dclife. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString* DCFoundationMakeStringMD5(NSString* string);

NSString* DCFoundationMakeStringSHA1(NSString* string);

NSString* DCFoundationMakeDataSHA1(NSData* data);
