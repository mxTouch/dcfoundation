//
//  MPFoundationBridge.h
//  MPFoundation
//
//  Created by Igor Danich on 19.01.16.
//  Copyright © 2016 Mediapark. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString* MPFoundationMakeStringMD5(NSString* string);

NSString* MPFoundationMakeStringSHA1(NSString* string);

NSString* MPFoundationMakeDataSHA1(NSData* data);
