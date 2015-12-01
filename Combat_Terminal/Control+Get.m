/*!
 @author Piyush Bansal (piyush2508@gmail.com), Gopi Krishna Rajoju (gopirajoju@live.com) and Sakshi Goyal (sakshigoyal369@gmail.com)
 
 @date 04/07/14
 
 @brief Combat:Control+Get.m
 
 @copyright : Copyright (c) 2015, The Combat authors - Piyush Bansal, Gopi Krishna Rajoju and Sakshi Goyal. All rights reserved. Redistribution is not permitted. Use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 Use of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Use in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the derived product.
 The names of its contributors must not be used to endorse or promote products derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
#import "Control+Get.h"
#import "Logger.h"
#import <AppKit/AppKit.h>

@implementation Control_Get

@synthesize logger = _logger;

/*!
 @brief get value of attribute
 @param  (CFStringRef)attribute - attribute name
 (AXUIElementRef)uielement - Accessible UI Element
 @return (CFTypeRef)
 */
-(CFTypeRef)getValueOfAttribute:(CFStringRef)attribute forElement:(AXUIElementRef)uielement
{
    CFTypeRef result;
    if(uielement != nil)
    {
        
        @try {
            AXUIElementCopyAttributeValue(uielement, attribute, &result);
        }
        @catch (NSException *exception) {
            [_logger log:[NSString stringWithFormat:@"Control_Get: AXUIELEMENTREF: %@, exception prduced with ATTRIBUTE: %@", [self getValueOfAttribute:(CFStringRef)NSAccessibilityTitleAttribute forElement:uielement], attribute]];
        }
    }
    else
    {
        [_logger log:@"Control_Get: UI Element Reference is Set to Nil"];
    }
    
    if(result == nil)
        return @"NO_VALUE";
    
    return result;
}

/*!
 @brief get value of all attributes
 @param (AXUIElementRef)uielement - Accessible UI Element
 @return (NSDictionary *)
 */
-(NSDictionary *)getValueOfAllAttributes:(AXUIElementRef)uielement
{
    NSMutableDictionary* allAttrValueKeyPair = [[NSMutableDictionary alloc]init];
    
    CFArrayRef allAttributesRef = nil;
    AXUIElementCopyAttributeNames(uielement, &allAttributesRef);
    
    NSMutableArray* allAttributes = (__bridge NSMutableArray*) allAttributesRef;
    
    if(allAttributes && ([allAttributes count] > 0)){
        
        for(int i = 0; i < [allAttributes count]; i++){
            [allAttrValueKeyPair setValue:(id)[self getValueOfAttribute:(CFStringRef)[allAttributes objectAtIndex:i] forElement:uielement] forKey:[allAttributes objectAtIndex:i]];
        }
    }
    return allAttrValueKeyPair;
}

/*!
 @brief get top left position(x,y) of uielement
 @param (AXUIElementRef)uielement - Accessible UI Element
 @return (NSPoint)
 */
-(NSPoint)getPosition:(AXUIElementRef)uielement
{
    CFTypeRef thisPoint = [self getValueOfAttribute:(CFStringRef)NSAccessibilityPositionAttribute forElement:uielement];
    
    CFStringRef thisPointString = CFCopyDescription(thisPoint);
    
    NSString* mystring = (NSString*) thisPointString;
    NSRange range = [mystring rangeOfString:@"{"];
    NSRange range2 = [mystring rangeOfString:@"type"];
    
    NSString *substring = [[mystring substringToIndex:range2.location - 1]substringFromIndex:range.location + 1];
    
    substring = [substring stringByReplacingOccurrencesOfString:@"value = " withString:@""];
    
    NSString* x = [substring substringToIndex:[substring rangeOfString:@" "].location - 1];
    x = [x stringByReplacingOccurrencesOfString:@"x:" withString:@""];
    
    NSString* y = [substring substringFromIndex:[substring rangeOfString:@" "].location + 1];
    y = [y stringByReplacingOccurrencesOfString:@"y:" withString:@""];

    NSPoint point2;
    point2.x = [x floatValue];
    point2.y = [y floatValue];
    return point2;
}

/*!
 @brief get size(w,h) of uielement
 @param (AXUIElementRef)uielement - Accessible UI Element
 @return (NSSize)
 */
-(NSSize)getSize:(AXUIElementRef)uielement
{
    CFTypeRef thisPoint = [self getValueOfAttribute:(CFStringRef)NSAccessibilitySizeAttribute forElement:uielement];
    
    CFStringRef thisPointString = CFCopyDescription(thisPoint);
    
    NSString* mystring = (NSString*) thisPointString;
    NSRange range = [mystring rangeOfString:@"{"];
    NSRange range2 = [mystring rangeOfString:@"type"];
    
    NSString *substring = [[mystring substringToIndex:range2.location - 1]substringFromIndex:range.location + 1];
    
    substring = [substring stringByReplacingOccurrencesOfString:@"value = " withString:@""];
    
    NSString* w = [substring substringToIndex:[substring rangeOfString:@" "].location - 1];
    w = [w stringByReplacingOccurrencesOfString:@"w:" withString:@""];
    
    NSString* h = [substring substringFromIndex:[substring rangeOfString:@" "].location + 1];
    h = [h stringByReplacingOccurrencesOfString:@"h:" withString:@""];
    
    NSSize size;
    size.height = [h floatValue];
    size.width = [w floatValue];
    
    return size;
}

/*!
 @brief check attribute value of uielement is equal to expected value
 @param (CFStringRef)attribute - attribute name
 (AXUIElementRef)uielement - Accessible UI Element
 (CFTypeRef)value - Expected value
 @return (BOOL)
 */
-(BOOL)verifyAttribute:(CFStringRef)attribute forElement:(AXUIElementRef)uielement withValue:(CFTypeRef)value
{
    CFTypeRef result = [self getValueOfAttribute:attribute forElement:uielement];
    //NSLog(@"%@", result);
    //Boolean Result= CFEqual(result, value);
    //NSLog(@"%hhu", Result);
    //Boolean x = [result isKindOfClass:[NSString class]];
    BOOL result1=[result boolValue];
    BOOL val1=[value boolValue];
    //NSString* value1=(NSString*)value;
    if(result == Nil)
        return FALSE;
    
    else if(result == value)
        return TRUE;
    
    else if ((result1) && (val1))
        return TRUE;
    else if (!(result1) && !(val1))
        return TRUE;
    return FALSE;
}

-(AXUIElementRef)appContext:(pid_t)pid
{
    if (pid != 0) {
        return AXUIElementCreateApplication(pid);
    }
    else
        return nil;
}
@end
