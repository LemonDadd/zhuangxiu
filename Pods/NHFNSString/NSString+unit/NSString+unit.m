//
//  NSString+unit.m
//  zjproject
//
//  Created by rockontrol on 15/4/15.
//  Copyright (c) 2015年 rockontrol. All rights reserved.
//

#import "NSString+unit.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString(unit)

- (NSString*)hzToUTF8{
    NSString* filePath = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return filePath;
}

- (BOOL)checkPhoneNumInput
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:self];
    BOOL res2 = [regextestcm evaluateWithObject:self];
    BOOL res3 = [regextestcu evaluateWithObject:self];
    BOOL res4 = [regextestct evaluateWithObject:self];
    
    if (res1 || res2 || res3 || res4 )
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(NSString*)stringTrim
{
    if(self == nil)
    {
        return nil;
    }
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

+ (NSString*)getRandomNumber:(NSInteger)from to:(NSInteger)to
{
    NSInteger item = (NSInteger)(arc4random_uniform(to-from)+from);
    return [NSString stringWithFormat:@"%ld", item];
}

// 整形判断
+ (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

//浮点形判断
+ (BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}


- (NSString *)md5
{
    if(self == nil)
    {
        return nil;
    }
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            
            result[0], result[1], result[2], result[3],
            
            result[4], result[5], result[6], result[7],
            
            result[8], result[9], result[10], result[11],
            
            result[12], result[13], result[14], result[15]
            
            ];
}

- (NSString *)pinYin
{//先转换为带声调的拼音
    NSMutableString *str = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    
    return str;
}

+ (NSString *)locationInstance:(float)instance{
    if (instance < 0) {
        return @"";
    }
    
    if (instance < 1000) {
        return [NSString stringWithFormat:@"%.1lfm", instance];
    }
    return [NSString stringWithFormat:@"%.1lfkm", instance/1000];
}

+ (NSString *)toUTF8:(NSString *)string{
    return [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (BOOL)isEmpty:(NSString *)string{
    if (string == nil ||
        string.length == 0 ||
        [string isEqualToString:@"null"] ||
        [string isEqualToString:@"(null)"]) {
        return true;
    } else {
        return false;
    }
}

+ (NSString *)convertByBool:(BOOL)object {
    return object?@"true":@"false";
}

+ (BOOL)isNULLBy:(NSString *)string {
    return (string==nil)||(string.length==0);
}

+ (NSString *)getUniqueStrByUUID {
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStrRef= CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *retStr = [NSString stringWithString:(__bridge NSString *)uuidStrRef];
    CFRelease(uuidStrRef);
    return retStr;
}

@end










