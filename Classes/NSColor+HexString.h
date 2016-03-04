//
//  NSColor+HexString.h
//  OMColorSense
//
//  Created by chenjian14 on 16/3/4.
//
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface NSColor (HexString)

+ (NSString *)formatHexString:(NSString *)targetString;
+ (NSColor *)colorFromARGBHexString:(NSString *)hexString;
+ (NSColor *)colorFromRGBAHexString:(NSString *)hexString;
- (NSString *)argbHexString;
- (NSString *)rgbHexString;

@end