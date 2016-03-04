//
//  NSColor+HexString.m
//  OMColorSense
//
//  Created by chenjian14 on 16/3/4.
//
//

#import "NSColor+HexString.h"

@implementation NSColor (HexString)

+ (NSString *)formatHexString:(NSString *)targetString {
    if ([targetString hasPrefix:@"#"]) {
        return [targetString stringByReplacingOccurrencesOfString:@"#" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 1)];
    } else if([targetString hasPrefix:@"0x"]) {
        return [targetString stringByReplacingOccurrencesOfString:@"0x" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 2)];
    }
    return targetString;
}

+ (NSColor *)colorFromARGBHexString:(NSString *)hexString {
    NSString *dealedHexString = [self formatHexString:hexString];
    NSString *matchRegex6 = @"^[0-9a-fA-F]{6}$";
    NSString *matchRegex8 = @"^[0-9a-fA-F]{8}$";
    NSPredicate *predicate6 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", matchRegex6];
    NSPredicate *predicate8 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", matchRegex8];
    if (![predicate6 evaluateWithObject:dealedHexString] && ![predicate8 evaluateWithObject:dealedHexString]) {
        return nil;
    }
    NSUInteger r = 0, g = 0, b = 0, a = 255;
    if (dealedHexString.length == 8) {
        unsigned result = 0;
        NSScanner *scanner = [NSScanner scannerWithString:[dealedHexString substringWithRange:NSMakeRange(0, 2)]];
        [scanner scanHexInt:&result];
        a = result;
        dealedHexString = [dealedHexString substringWithRange:NSMakeRange(2, 6)];
    }
    if (dealedHexString.length == 6) {
        unsigned result = 0;
        NSScanner *scanner = [NSScanner scannerWithString:dealedHexString];
        [scanner scanHexInt:&result];
        r = (result >> 16) & 0xFF;
        g = (result >> 8) & 0xFF;
        b = result & 0xFF;
    }
    return [NSColor colorWithCalibratedRed:((CGFloat)r) / 255.0 green:((CGFloat)g) / 255.0 blue:((CGFloat)b) / 255.0 alpha:((CGFloat)a) / 255.0];
}

+ (NSColor *)colorFromRGBAHexString:(NSString *)hexString {
    NSString *dealedHexString = [self formatHexString:hexString];
    NSString *matchRegex6 = @"^[0-9a-fA-F]{6}$";
    NSString *matchRegex8 = @"^[0-9a-fA-F]{8}$";
    NSPredicate *predicate6 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", matchRegex6];
    NSPredicate *predicate8 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", matchRegex8];
    if (![predicate6 evaluateWithObject:dealedHexString] && ![predicate8 evaluateWithObject:dealedHexString]) {
        return nil;
    }
    NSUInteger r = 0, g = 0, b = 0, a = 255;
    if (dealedHexString.length == 8) {
        unsigned result = 0;
        NSScanner *scanner = [NSScanner scannerWithString:[dealedHexString substringWithRange:NSMakeRange(6, 2)]];
        [scanner scanHexInt:&result];
        a = result;
        dealedHexString = [dealedHexString substringWithRange:NSMakeRange(0, 6)];
    }
    if (hexString.length == 6) {
        unsigned result = 0;
        NSScanner *scanner = [NSScanner scannerWithString:hexString];
        [scanner scanHexInt:&result];
        r = (result >> 16) & 0xFF;
        g = (result >> 8) & 0xFF;
        b = result & 0xFF;
    }
    return [NSColor colorWithRed:((CGFloat)r) / 255.0 green:((CGFloat)g) / 255.0 blue:((CGFloat)b) / 255.0 alpha:((CGFloat)a) / 255.0];
}

- (NSString *)rgbHexString {
    CGFloat red = self.redComponent; CGFloat green = self.greenComponent; CGFloat blue = self.blueComponent;
    return [NSString stringWithFormat:@"0x%02lX%02lX%02lX", (long)round(red * 255.0) & 0xFF, (long)round(green * 255.0) & 0xFF, (long)round(blue * 255.0) & 0xFF];
}

- (NSString *)argbHexString {
    CGFloat alpha = self.alphaComponent; CGFloat red = self.redComponent; CGFloat green = self.greenComponent; CGFloat blue = self.blueComponent;
    return [NSString stringWithFormat:@"0x%02lX%02lX%02lX%02lX", (long)round(alpha * 255.0) & 0xFF, (long)round(red * 255.0) & 0xFF, (long)round(green * 255.0) & 0xFF, (long)round(blue * 255.0) & 0xFF];
}

@end