//
//  Application+Get.m
/*!
@author Piyush Bansal (piyush2508@gmail.com), Gopi Krishna Rajoju (gopirajoju@live.com) and Sakshi Goyal (sakshigoyal369@gmail.com)

@date 07/07/14

@brief This class is used to get UI element information from the Application under test. 
It gives UI element's attribute information, Descendants' information and it's leneage.
@copyright Copyright (c) 2015, The Combat authors - Piyush Bansal, Gopi Krishna Rajoju and Sakshi Goyal. All rights reserved.

Redistribution is not permitted. Use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Use of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

Use in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the derived product.

The names of its contributors must not be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#import "Application+Get.h"
#import "Control+Get.h"
#import <AppKit/AppKit.h>

@implementation Application_Get
/*!

 @brief This method is used to get attributeinformation of  UI element present in the Application under test.

 @param  uielement is an AXUIElementRef type of variable that gives the UI element information.

 @return (NSString*) The method returns the attribute information of the UI element in the following format: 
 <controltype><properties property1=value1 property2=value2 ..../></controltype> 
 
 @remark This method is used to get attributeinformation of  UI element present in the Application under test.

 */
-(NSString *)getElementInfo:(AXUIElementRef)uielement
{
    Control_Get *control_Get = [[Control_Get alloc]init];
    
    NSMutableString *elementInfo = [[NSMutableString alloc]init];
    
    NSString *elementType = [control_Get getValueOfAttribute:(CFStringRef)NSAccessibilityRoleAttribute forElement:uielement];
    NSString *myType = @"";
    
    NSMutableDictionary *properties = [[NSMutableDictionary alloc]init];
    [properties setValue:[control_Get getValueOfAttribute:(CFStringRef)NSAccessibilityRoleAttribute forElement:uielement] forKey:NSAccessibilityRoleAttribute];
    [properties setValue:[control_Get getValueOfAttribute:(CFStringRef)NSAccessibilityRoleDescriptionAttribute forElement:uielement] forKey:NSAccessibilityRoleDescriptionAttribute];
    [properties setValue:[control_Get getValueOfAttribute:(CFStringRef)NSAccessibilityIdentifierAttribute forElement:uielement] forKey:NSAccessibilityIdentifierAttribute];
    [properties setValue:[control_Get getValueOfAttribute:(CFStringRef)NSAccessibilityTitleAttribute forElement:uielement] forKey:NSAccessibilityTitleAttribute];
    
    if([elementType isEqualToString:@"AXWindow"])
    {
        myType = @"window";
    }
    else if([elementType isEqualToString:@"AXMenuBarItem"] || [elementType isEqualToString:@"AXMenuItem"])
    {
        myType = @"menu";
    }
    else
    {
        myType = @"uiobject";
    }
    
    [elementInfo appendFormat:@"<%@><properties ", myType];
    
    for (NSString* key in properties) {
        if ([properties valueForKey:key]) {
            [elementInfo appendFormat:@"%@ = \"%@\"",key, [properties valueForKey:key]];
        }
    }
    [elementInfo appendFormat:@"/></%@>", myType];
    
    return elementInfo;
}

/*!

 @brief This method is used to get descendants' information of a UI element present in the Application under test.

 @param  uielement is an AXUIElementRef type of variable that gives the UI element information.

 @return (NSString*) The method returns the attribute information of the UI element in the following format: 
 <controltype><properties property1=value1 property2=value2 ..../>
 <descendants>
 <controltype><properties property1=value1 property2=value2 ..../></controltype> 
 <controltype><properties property1=value1 property2=value2 ..../></controltype>
 <controltype><properties property1=value1 property2=value2 ..../></controltype>
 </descendants>
 </controltype> 
 
 @remark This method is used to get descendants' information of a UI element present in the Application under test.

 */
-(NSString *)getElementAndDescendantsInfo:(AXUIElementRef)uielement
{
    Control_Get *control_Get = [[Control_Get alloc]init];
    NSArray* arrayOfChildren = [control_Get getValueOfAttribute:(CFStringRef)NSAccessibilityChildrenAttribute forElement:uielement];
    
    
    NSMutableString *elementInfo = [[NSMutableString alloc]init];
    NSString *elementType = [control_Get getValueOfAttribute:(CFStringRef)NSAccessibilityRoleAttribute forElement:uielement];
    NSString *myType = @"";
    
    NSMutableDictionary *properties = [[NSMutableDictionary alloc]init];
    [properties setValue:[control_Get getValueOfAttribute:(CFStringRef)NSAccessibilityRoleAttribute forElement:uielement] forKey:NSAccessibilityRoleAttribute];
    [properties setValue:[control_Get getValueOfAttribute:(CFStringRef)NSAccessibilityRoleDescriptionAttribute forElement:uielement] forKey:NSAccessibilityRoleDescriptionAttribute];
    [properties setValue:[control_Get getValueOfAttribute:(CFStringRef)NSAccessibilityIdentifierAttribute forElement:uielement] forKey:NSAccessibilityIdentifierAttribute];
    [properties setValue:[control_Get getValueOfAttribute:(CFStringRef)NSAccessibilityTitleAttribute forElement:uielement] forKey:NSAccessibilityTitleAttribute];
    
    if([elementType isEqualToString:@"AXWindow"])
    {
        myType = @"window";
    }
    else if([elementType isEqualToString:@"AXMenuBarItem"] || [elementType isEqualToString:@"AXMenuItem"])
    {
        myType = @"menu";
    }
    else
    {
        myType = @"uiobject";
    }
    
    [elementInfo appendFormat:@"<%@><properties ", myType];
    
    for (NSString* key in properties) {
        if ([properties valueForKey:key]) {
            [elementInfo appendFormat:@"%@ = \"%@\"",key, [properties valueForKey:key]];
        }
    }
    [elementInfo appendFormat:@"/>"];
    
    if ([arrayOfChildren count] > 0)
    {
        [elementInfo appendFormat:@"<descendants>"];
        for (int i = 0; i < [arrayOfChildren count]; i++)
        {
            [self getElementAndDescendantsInfo:(AXUIElementRef)[arrayOfChildren objectAtIndex:i]];
        }
        [elementInfo appendFormat:@"</descendants>"];
    }
    
    [elementInfo appendFormat:@"</%@>", myType];
    
    return elementInfo;

}

/*!

 @brief This method is used to get the leneage of a UI element present in the Application under test.

 @param  uielement is an AXUIElementRef type of variable that gives the UI element information.

 @return (NSString*) The method returns the leneage information of the UI element in the following format: 
 (controlrole::controltitle)1;(controlrole::controltitle)2;(controlrole::controltitle)3;....
 
 @remark This method is used to get the leneage of a UI element present in the Application under test.

 */
-(NSString *)getLineage:(AXUIElementRef)uielement
{
    Control_Get *control_Get = [[Control_Get alloc]init];
    NSMutableString *lineage = [[NSMutableString alloc]init];
    
    if([control_Get getValueOfAttribute:(CFStringRef)NSAccessibilityParentAttribute forElement:uielement] != nil)
    {
        NSMutableString *temp = [[NSMutableString alloc]init];
        NSMutableDictionary *properties = [[NSMutableDictionary alloc]init];
        [properties setValue:[control_Get getValueOfAttribute:(CFStringRef)NSAccessibilityRoleAttribute forElement:uielement] forKey:NSAccessibilityRoleAttribute];
        [properties setValue:[control_Get getValueOfAttribute:(CFStringRef)NSAccessibilityTitleAttribute forElement:uielement] forKey:NSAccessibilityTitleAttribute];
        
        [temp appendFormat:@"%@::%@;", [properties valueForKey:NSAccessibilityRoleAttribute], ([properties valueForKey:NSAccessibilityTitleAttribute])?[properties valueForKey:NSAccessibilityTitleAttribute]:nil];
        
        [lineage appendFormat:@"%@;%@",[self getLineage:[control_Get getValueOfAttribute:(CFStringRef)NSAccessibilityParentAttribute forElement:uielement]], temp];
    }
    
    return lineage;
}
@end
