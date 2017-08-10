//
//  MPFoundationBridge.m
//  MPFoundation
//
//  Created by Igor Danich on 19.01.16.
//  Copyright © 2016 dclife. All rights reserved.
//

#import "DCFoundationUtils.h"
#import <CommonCrypto/CommonCrypto.h>

NSString* DCFoundationMakeStringMD5(NSString* string) {
    NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

NSString* DCFoundationMakeStringSHA1(NSString* string) {
    NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

NSString* DCFoundationMakeDataSHA1(NSData* data) {
    NSUInteger bytesCount = data.length;
    if (bytesCount) {
        static char const* kHexChars = "0123456789ABCDEF";
        const unsigned char* dataBuffer = data.bytes;
        char* chars = malloc(sizeof(char)*(bytesCount*2 + 1));
        char* s = chars;
        for (unsigned i = 0; i < bytesCount; ++i) {
            *s++ = kHexChars[((*dataBuffer & 0xF0) >> 4)];
            *s++ = kHexChars[(*dataBuffer & 0x0F)];
            dataBuffer++;
        }
        *s = '\0';
        NSString *hexString = [NSString stringWithUTF8String:chars];
        free(chars);
        return hexString;
    }
    return @"";
}
