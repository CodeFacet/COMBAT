//
//  System+Application.m
/*!
@author Piyush Bansal (piyush2508@gmail.com), Gopi Krishna Rajoju (gopirajoju@live.com) and Sakshi Goyal (sakshigoyal369@gmail.com)

@date 04/07/14

@brief This class is used to interact with the Application under test to get the snippet of a control.

@copyright Copyright (c) 2015, The Combat authors - Piyush Bansal, Gopi Krishna Rajoju and Sakshi Goyal. All rights reserved.

Redistribution is not permitted. Use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Use of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

Use in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the derived product.

The names of its contributors must not be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#import "System+Application.h"
#import "SystemManager.h"
#import "Control+Get.h"
#import "Application+Search.h"

@implementation System_Application

@synthesize control_Get = _control_Get;
@synthesize system = _system;
@synthesize application_Search = _application_Search;
/*!

 @brief This method is used to get a snippet UI element present in the Application under test.

 @param  appname the name of the Application under test ; 
 uielementConditions is a NSDictionary element to define the UI element's control conditions that are used to find it in the application ;
 windowConditions is a NSDictionary element to define the contro conditions ofthe window in which the UI element is present.

 @return (AXUIElementRef) The UI element refence of the element found. 

 @remark TThis method is used to get a snippet UI element present in the Application under test. The mention of the windowConditions makes it possible to limit the search to the window only.

 */
-(CGImageRef)getControlSnip:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions
{
    CGImageRef imageRef;
    
    AXUIElementRef appContext = [_control_Get appContext:[_system getPid:appname]];
    if(appContext != nil)
    {
        AXUIElementRef uielementRef = [_application_Search findControlIn:appContext and:uielementConditions ];
        if(uielementRef != nil)
        {
            NSPoint origin = [_control_Get getPosition:uielementRef];
            NSSize size = [_control_Get getSize:uielementRef];
            CGImageRef screenShot = [_system getScreenShot];
            
            CGRect cropRect;
            cropRect.origin.x = origin.x;
            cropRect.origin.y = origin.y;
            cropRect.size.height = size.height;
            cropRect.size.width = size.width;
            
            imageRef = CGImageCreateWithImageInRect(screenShot, cropRect);
        }
        else
            return nil;
    }
    else
        return nil;
    
    return imageRef;
}

@end
