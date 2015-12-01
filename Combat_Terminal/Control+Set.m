/*!
 @author Piyush Bansal (piyush2508@gmail.com), Gopi Krishna Rajoju (gopirajoju@live.com) and Sakshi Goyal (sakshigoyal369@gmail.com)
 
 @date 04/07/14
 
 @brief Combat:Control+Set.m
 
 @copyright : Copyright (c) 2015, The Combat authors - Piyush Bansal, Gopi Krishna Rajoju and Sakshi Goyal. All rights reserved. Redistribution is not permitted. Use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 Use of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Use in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the derived product.
 The names of its contributors must not be used to endorse or promote products derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
#import "Control+Set.h"
#import "Logger.h"
#import "Control+Get.h"
#import <AppKit/AppKit.h>

@implementation Control_Set

@synthesize control_Get;

/*!
 @brief is attribute of uielement settable
 @param (CFStringRef)attribute - attribute name
 (AXUIElementRef)uielement - Accessible UI Element
 @return (BOOL)
 */
-(BOOL)isAttributeSettable:(AXUIElementRef)uielement and:(CFStringRef)attribute
{
    Boolean result = FALSE;
    if(uielement != nil)
    {
        
        @try {
            AXUIElementIsAttributeSettable(uielement, attribute, &result);
        }
        @catch (NSException *exception) {
            [_logger log:[NSString stringWithFormat:@"Control_Set: AXUIELEMENTREF: %@, exception prduced with ATTRIBUTE: %@", [control_Get getValueOfAttribute:(CFStringRef)NSAccessibilityTitleAttribute forElement:uielement], attribute]];
        }
    }
    else
    {
        [_logger log:@"Control_Set: UI Element Reference is Set to Nil"];
    }
    
    return (BOOL)result;
}

/*!
 @brief set attribute of uielement to value
 @param (CFStringRef)attribute - attribute name
 (AXUIElementRef)uielement - Accessible UI Element
 (CFTypeRef)value - set to this value
 @return (BOOL)
 */
-(BOOL)setValueForAttribute:(CFStringRef)attribute forElement:(AXUIElementRef)uielement withValue:(CFTypeRef)value
{
    BOOL result = FALSE;
    if([self isAttributeSettable:uielement and:attribute])
    {
        AXUIElementSetAttributeValue(uielement, attribute, value);
        
        if([control_Get getValueOfAttribute:attribute forElement:uielement] == value)
            result = TRUE;
    }
    
    return result;
}

/*!
 @brief perform action on uielement
 @param (AXUIElementRef)uielement - Accessible UI Element
 @return (BOOL)
 */
-(BOOL)action:(CFStringRef)action onElement:(AXUIElementRef)uielement
{
    @try {
        AXUIElementPerformAction(uielement, action);
    }
    @catch (NSException *exception) {
        [_logger log:[NSString stringWithFormat:@"Control_Set: AXUIELEMENTREF: %@, exception prduced with Action: %@", [control_Get getValueOfAttribute:(CFStringRef)NSAccessibilityTitleAttribute forElement:uielement], action]];
        
        return FALSE;
    }
    
    return TRUE;
}

@end
