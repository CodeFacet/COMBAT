//
//  Application+Search.m
/*!
@author Piyush Bansal (piyush2508@gmail.com), Gopi Krishna Rajoju (gopirajoju@live.com) and Sakshi Goyal (sakshigoyal369@gmail.com)

@date 04/07/14

@brief This class is used to search or find UI element/elements in the Application under test. 
It returns the AXUIElementRef of the UI element found and an array of AXUIElementRef if more than one control is found.

@copyright Copyright (c) 2015, The Combat authors - Piyush Bansal, Gopi Krishna Rajoju and Sakshi Goyal. All rights reserved.

Redistribution is not permitted. Use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Use of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

Use in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the derived product.

The names of its contributors must not be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#import "Application+Search.h"
#import "Control+Get.h"
#import <AppKit/AppKit.h>

@implementation Application_Search

-(id)init
{
    self = [super init];
    if(self)
    {
        _foundElementRef = nil;
        _foundElementRef1 = nil;
        _foundElementRefs = nil;
    }
    return self;
}

-(Control_Get*)control_Get
{
    if(_control_Get == nil)
    {
        _control_Get = [[Control_Get alloc]init];
    }
    return _control_Get;
}

#pragma mark -Control(s)
/*!

 @brief This method is used to find a UI element in another UI element in the Application under test using the given control information.

 @param  uielement is an AXUIElementRef used to define the UI element in which the control needs to be found ; 
 controlConditions is a NSDictionary element to define the UI element's control conditions that are used to find it in the application.

 @return (AXUIElementRef) The UI element refence of the element found. 

 @remark This method is used to find a UI element in a UI element in the Application under test using the given control information. It searches for the control within another UI element in the Application.

 */
-(AXUIElementRef)       findControlIn:(AXUIElementRef)uielement and:(NSDictionary *)controlConditions
{
    if (_foundElementRef == nil) {
        BOOL allMatch = FALSE;
        int i = 0;
        for(NSString* condition in controlConditions){
            
            NSString* valueFromCurrent = (NSString*)[[self control_Get] getValueOfAttribute:(CFStringRef)condition forElement:uielement];
            NSString* valueToMatch = (NSString*)[controlConditions objectForKey:condition];
            
            if([valueFromCurrent isEqual:valueToMatch]){
                
                if(i+1 == [controlConditions count]){
                    allMatch = TRUE;
                }
            }
            else
                break;
            i++;
        }
        if(allMatch == TRUE){
            _foundElementRef = uielement;
            return _foundElementRef;
        }
        
        NSMutableArray* arrayOfChildren = (NSMutableArray*)[[self control_Get] getValueOfAttribute:(CFStringRef) NSAccessibilityChildrenAttribute forElement:uielement];
        
        if (![arrayOfChildren isEqual:(id)@"NO_VALUE"] && [arrayOfChildren count] > 0 && _foundElementRef == nil) {
            
            for (int i = 0; i < [arrayOfChildren count]; i++) {
                [self findControlIn:(__bridge AXUIElementRef)([arrayOfChildren objectAtIndex:i]) and:controlConditions];
            }
        }
    }
    return (_foundElementRef);
}
/*!

 @brief This method is used to find a UI element in a window in the Application under test using the given control information.

 @param  uielement is an AXUIElementRef used to define the window in which the control needs to be found ; 
 controlConditions is a NSDictionary element to define the UI element's control conditions that are used to find it in the application.

 @return (AXUIElementRef) The UI element refence of the element found. 

 @remark This method is used to find a UI element in a window in the Application under test using the given control information. It searches for the control within a window in the Application.

 */
-(AXUIElementRef)       findControlInWindow:(AXUIElementRef)uielement and:(NSDictionary *)controlConditions
{
    
    if (_foundElementRef1 == nil) {
        BOOL allMatch = FALSE;
        int i = 0;
        for(NSString* condition in controlConditions){
            
            NSString* valueFromCurrent = (NSString*)[[self control_Get] getValueOfAttribute:(CFStringRef)condition forElement:uielement];
            NSString* valueToMatch = (NSString*)[controlConditions objectForKey:condition];
            
            
            if([valueFromCurrent isEqual:valueToMatch]){
                
                if(i+1 == [controlConditions count]){
                    allMatch = TRUE;
                }
            }
            else
                break;
            i++;
        }
        if(allMatch == TRUE){
            _foundElementRef1 = uielement;
            return _foundElementRef1;
        }
        
        NSMutableArray* arrayOfChildren = (NSMutableArray*)[[self control_Get] getValueOfAttribute:(CFStringRef) NSAccessibilityChildrenAttribute forElement:uielement];
        
        if (![arrayOfChildren isEqual:(id)@"NO_VALUE"] && [arrayOfChildren count] > 0 && _foundElementRef1 == nil) {
            
            for (int i = 0; i < [arrayOfChildren count]; i++) {
                [self findControlInWindow:(__bridge AXUIElementRef)([arrayOfChildren objectAtIndex:i]) and:controlConditions];
            }
        }
    }
    return (_foundElementRef1);
}
/*!

 @brief This method is used to find a UI element in a window that needs to be found within another UI control in the Application under test using the given control information.

 @param  uielement is an AXUIElementRef used to define the UI control in which the window that contains the control needs to be found ; 
 windowConditions is a NSDictionary element to define the window's control conditions that are used to find it in the application.
 controlConditions is a NSDictionary element to define the UI element's control conditions that are used to find it in the application.

 @return (AXUIElementRef) The UI element refence of the element found. 

 @remark This method is used to find a UI element in a window that needs to be found within another UI control in the Application under test using the given control information.

 */
-(AXUIElementRef)       findControlIn:(AXUIElementRef)uielement inWindow:(NSDictionary *)windowConditions and:(NSDictionary *)controlConditions
{
    AXUIElementRef windowRef = [self findControlIn:uielement and:windowConditions];
    return [self findControlIn: windowRef and:controlConditions];
}
/*!

 @brief This method is used to find UI elements in another UI element in the Application under test using the given control information.

 @param  uielement is an AXUIElementRef used to define the UI element in which the control needs to be found ; 
 controlConditions is a NSDictionary element to define the UI element's control conditions that are used to find it in the application.

 @return (NSArray*) The array of UI element refences of the elements found. 

 @remark This method is used to find UI elements in a UI element in the Application under test using the given control information. It searches for the control within another UI element in the Application.

 */
-(NSArray *)            findControlsIn:(AXUIElementRef)uielement and:(NSDictionary *)controlConditions
{
    BOOL allMatch = FALSE;
    int i = 0;
    for(NSString* condition in controlConditions){
        
        NSString* valueFromCurrent = (NSString*)[[self control_Get] getValueOfAttribute:(CFStringRef)condition forElement:uielement];
        NSString* valueToMatch = (NSString*)[controlConditions objectForKey:condition];
        
        if([valueFromCurrent isEqual: valueToMatch]){
            if(i+1 == [controlConditions count]){
                allMatch = TRUE;
            }
        }
        else
            break;
        i++;
    }
    
    if(allMatch == TRUE){
        if(_foundElementRefs == nil)
            _foundElementRefs = [[NSMutableArray alloc]init];
        
        [_foundElementRefs addObject:(__bridge id)(uielement)];
    }
    
    NSMutableArray* arrayOfChildren = (NSMutableArray*)[[self control_Get] getValueOfAttribute:(CFStringRef) NSAccessibilityChildrenAttribute forElement:uielement];
    
    if (![arrayOfChildren isEqual:(id)@"NO_VALUE"] &&[arrayOfChildren count] > 0) {
        
        for (int i = 0; i < [arrayOfChildren count]; i++) {
            [self findControlsIn:(__bridge AXUIElementRef)([arrayOfChildren objectAtIndex:i]) and:controlConditions];
        }
    }
    
    return (_foundElementRefs);
}
/*!

 @brief This method is used to find UI elements in a window that needs to be found within another UI control in the Application under test using the given control information.

 @param  uielement is an AXUIElementRef used to define the UI control in which the window that contains the control needs to be found ; 
 windowConditions is a NSDictionary element to define the window's control conditions that are used to find it in the application.
 controlConditions is a NSDictionary element to define the UI element's control conditions that are used to find it in the application.

 @return (NSArray*) The array of UI element refences of the elements found. 

 @remark This method is used to find UI elements in a window that needs to be found within another UI control in the Application under test using the given control information.

 */
-(NSArray *)            findControlsIn:(AXUIElementRef)uielement inWindow:(NSDictionary *)windowConditions and:(NSDictionary *)controlConditions
{
    AXUIElementRef windowRef = [self findControlIn:uielement and:windowConditions];
    return [self findControlsIn: windowRef and:controlConditions];
}

//===================================================================================================
#pragma mark - Find Window(s)
/*!

 @brief This method is used to find a window in another UI element in the Application under test using the given control information.

 @param  uielement is an AXUIElementRef used to define the UI element in which the window needs to be found ; 
 controlConditions is a NSDictionary element to define the window's control conditions that are used to find it in the application.

 @return (AXUIElementRef) The UI element refence of the window found.

 @remark This method is used to find a window in a UI element in the Application under test using the given control information. It searches for the control within another UI element in the Application.

 */
-(AXUIElementRef)       findWindowIn:(AXUIElementRef)uielement and:(NSDictionary *)windowConditions
{
    return [self findControlIn:uielement and:windowConditions];
}
/*!

 @brief This method is used to find windows in another UI element in the Application under test using the given control information.

 @param  uielement is an AXUIElementRef used to define the UI element in which the window needs to be found ; 
 controlConditions is a NSDictionary element to define the window's control conditions that are used to find it in the application.

 @return (NSArray*) The array of UI element refences of the windows found. 

 @remark This method is used to find windows in a UI element in the Application under test using the given control information. It searches for the control within another UI element in the Application.

 */
-(NSArray *)            findWindowsIn:(AXUIElementRef)uielement and:(NSDictionary *)windowConditions
{
    return [self findControlsIn:uielement and:windowConditions];
}

@end
