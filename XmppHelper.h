//
//  XmppHelper.h
//  sample_singleview
//
//  Created by Evan Lin on 2014/11/11.
//  Copyright (c) 2014年 EvanLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XmppHelper : NSObject
- (NSData * ) dataFromHexString : (NSString *) s_t;
- (Byte )numFromChar : (char ) c;
- (int) bigEndianStringToInteger : (NSString*) big_endian_string;
- (int) littleEndianStringToInteger : (NSString*) little_endian_string;
@end
