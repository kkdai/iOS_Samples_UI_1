//
//  XmppHelper.m
//  sample_singleview
//
//  Created by Evan Lin on 2014/11/11.
//  Copyright (c) 2014年 EvanLin. All rights reserved.
//

#import "XmppHelper.h"

@implementation XmppHelper
- (Byte )numFromChar : (char ) c
{
    if ( c >='0' && c <= '9')
    {
        return c - '0';
    }else if (c >='A' && c <='Z') {
        return c - 'A' + 10;
    }else if (c >='a' && c <= 'z') {
        return c - 'a' + 10;
    }
    return -1;
    
}

- (NSData * ) dataFromHexString : (NSString *)s_t
{
    s_t = [s_t stringByReplacingOccurrencesOfString:@" "  withString: @""];
    if ([s_t length]%2 !=0)    {
        return nil;
    }
    Byte * retBytes = malloc(sizeof(char) * [s_t length]);
    
    Byte * ori = retBytes;
    
    for ( int i = 0 ; i < [s_t length]; ) {
        char highBit = [s_t characterAtIndex:i ++];
        char lowBit = [s_t characterAtIndex:i ++];
        
        //to byte
        Byte a = [self numFromChar:highBit];
        Byte b = [self numFromChar:lowBit];
        
        *(retBytes ++)= (a<<4) | b;
    }
    
    NSData * data = [NSData dataWithBytes:ori length:[s_t length]/2];
    return data;
}

- (int) bigEndianStringToInteger :(NSString*) big_endian_string
{
    if ([big_endian_string length] % 2 != 0) {
        assert(true);
        return 0;
    }
    
    unsigned result = 0;
    NSString *type_string = [big_endian_string length] > 0 ? big_endian_string: @"0" ;
    NSScanner *scanner = [NSScanner scannerWithString:type_string];
    [scanner setScanLocation:0];
    [scanner scanHexInt:&result];
    return result;
}

- (int) littleEndianStringToInteger : (NSString*) little_endian_string
{
    if ([little_endian_string length] % 2 != 0) {
        assert(true);
        return 0;
    }
    
    NSString * big_endian_string = @"";
    for (int i = 0; i < [little_endian_string length] /2 ; i++) {
        NSRange name_range = NSMakeRange(i*2, 2);
        NSString *type_U = [little_endian_string substringWithRange:name_range];
        big_endian_string = [NSString stringWithFormat:@"%@%@", type_U, big_endian_string];
    }
    
    return [self bigEndianStringToInteger:big_endian_string];
}
@end
