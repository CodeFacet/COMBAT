/*!
 @author Piyush Bansal (piyush2508@gmail.com), Gopi Krishna Rajoju (gopirajoju@live.com) and Sakshi Goyal (sakshigoyal369@gmail.com)
 
 @date 04/07/14
 
 @brief Combat:Combat_Interface.m
 
 @copyright : Copyright (c) 2015, The Combat authors - Piyush Bansal, Gopi Krishna Rajoju and Sakshi Goyal. All rights reserved. Redistribution is not permitted. Use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
     Use of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
     Use in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the derived product.
     The names of its contributors must not be used to endorse or promote products derived from this software without specific prior written permission.
 
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "Combat_Interface.h"
#import "Utilities.h"
#import "Control+Get.h"
#import "Control+Set.h"
#import "Application+AppleScript+Set.h"
#import "Application+Search.h"
#import "Application+Set.h"
#import "SystemManager.h"
#import "System+Application.h"
#import "Combat+Mouse.h"
#import "Combat+Keyboard.h"
#import "Application+Get.h"

static CombatInterface *curInstance;

@implementation CombatInterface
-(id)init
{
    self = [super init];
    if(self){
        Combat_Mouse *mm = [[Combat_Mouse alloc]init];
        //This method is essential for mouse actions execution.
        // Copies Cliclick App to Temp directory for reference for AppleScript
        [mm copyCliClickToTempFolder];
    }
    return self;
}

#pragma mark Properties
-(SystemManager*)systemManager
{
    if (_systemManager == nil) {
        _systemManager = [[SystemManager alloc]init];
    }
    
    return _systemManager;
}

-(System_Application*)system_Application
{
    if(_system_Application == nil)
        _system_Application = [[System_Application alloc]init];
    
    return _system_Application;
}

-(Application_Search*)application_Search
{
    if(_application_Search == nil)
        _application_Search = [[Application_Search alloc]init];
    
    return _application_Search;
}

-(Control_Set*)control_Set
{
    if(_control_Set == nil)
        _control_Set = [[Control_Set alloc]init];
    
    return _control_Set;
}

-(Control_Get*)control_Get
{
    if(_control_Get == nil)
        _control_Get = [[Control_Get alloc]init];
    
    return _control_Get;
}

-(Combat_Mouse*)combat_Mouse
{
    if(_combat_Mouse == nil)
        _combat_Mouse = [[Combat_Mouse alloc]init];
    return _combat_Mouse;
}

-(Combat_Keyboard*)combat_Keyboard
{
    if(_combat_Keyboard == nil)
        _combat_Keyboard = [[Combat_Keyboard alloc]init];
    
    return _combat_Keyboard;
}

-(Application_AppleScript_Set*)application_AppleScript_Set
{
    if (_application_AppleScript_Set == nil) {
        _application_AppleScript_Set = [[Application_AppleScript_Set alloc]init];
    }
    
    return _application_AppleScript_Set;
}

-(Application_Get*)application_Get
{
    if(_application_Get == nil)
        _application_Get = [[Application_Get alloc]init];
    
    return _application_Get;
}

#pragma mark Methods
/*!
 @brief Launch Desktop App
 @param  (NSString *)appname - Name of App to launch
 @return YES if launch successful / NO, if was not able to launch application
 @remark This is a super-easy method to use, you only need to provide the Application Name to launch the Application, while launching all the conditions are managed at the backend.
 */
-(NSString *)launchApp:(NSString *)appname
{
    BOOL launchStatus = [[self systemManager] launchApp:appname];
    return [NSString stringWithFormat:@"%hhd", launchStatus];
}

/*!
 @brief To Check if an application on which action needs to be performed is ready to accept events or not
 @param  (NSString *)appname - Name of App
 @return YES if it is ready to accept events / NO if app is not ready/loading/execution/hang state
 @remark when ever this method is called, it checks if the application in online/launched and then confirms it the app is ready to accept events 
 */
-(NSString *)checkIfAppReady:(NSString *)appname
{
    return [NSString stringWithFormat:@"%hhd",[[self systemManager] isAppReady:appname]];
}

/*!
 @brief wait for max 10secs timeout period, to see if the app becomes ready
 @param  (NSString *)appname - Name of App
 @return YES if it is ready to accept events / NO if app is not ready/loading/execution/hang state
 @remark when ever this method is called, it checks if the application in online/launched and then confirms it the app is ready to accept events. If not ready this method will keep checking every second to see if the app is ready to accept action of not
 */
-(NSString *)waitForAppReady:(NSString *)appname
{
    return [NSString stringWithFormat:@"%hhd",[[self systemManager] wait:10 ForAppReady:appname]];
}

/*!
 @brief quit App
 @param  (NSString *)appname - Name of App
 @return YES if app is not running/ NO if failed to quit app
 @remark This is a super-easy method to use, you only need to provide the Application Name to exit/close
 */
-(NSString *)quitApp:(NSString *)appname
{
    return [NSString stringWithFormat:@"%hhd",[[self systemManager] quitApp:appname]];
}

/*!
 @brief Get a Screen Shot of the Main Screen
 @return a JPEG File of the screenshot taken
 */
-(NSData *)getScreenShot
{
    CGImageRef img = [[self systemManager] getScreenShot];
    NSString *tempDirectory = NSTemporaryDirectory();
    CFURLRef url = (CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/combattempimage.jpg",tempDirectory]];
    
    CGImageDestinationRef destination = CGImageDestinationCreateWithURL(url, kUTTypePNG, 1, NULL);
    
    CGImageDestinationAddImage(destination, img, nil);
    if(!CGImageDestinationFinalize(destination))
        NSLog(@"Failed to write Image");
    
    NSData *mydata = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/combattempimage.jpg",tempDirectory]];
    
    return mydata;
    
}

/*!
 @brief Check if a File Exists on the System
 @param  (NSString *)filepath - filepath
 @return YES if File Exists / NO File doesn't exist
 @remark This is a super-easy method to use, you only need to provide the filepath
 */
-(NSString *)checkIfFileExists: (NSString *)filepath
{
    BOOL b=[[NSFileManager defaultManager] fileExistsAtPath:filepath];
    return [NSString stringWithFormat:@"%hhd", b];
}

/*!
 @brief Check if a File Exists and remove it from the System
 @param  (NSString *)filepath - filepath
 @return '' if everthing happens without any hiccup, else exception message is returned
 @remark This is a super-easy method to use, you only need to provide the filepath
 */
-(NSString *)removeExistingFile: (NSString *)filepath
{
    NSError *e = nil;
    [[NSFileManager defaultManager] removeItemAtPath:filepath error:(NSError **)e];
    return [NSString stringWithFormat:@"%@", e];
}

/*!
 @brief Check if a File Exists and copy it to a new location
 @param  (NSString *)filepath - filepath
 @return '' if everthing happens without any hiccup, else exception message is returned
 @remark This is a super-easy method to use, you only need to provide the to-from filepaths,
 */
-(NSString *)copyFilefrom: (NSString *)filepath to: (NSString *)destinationpath
{
    NSError *e = nil;
    [[NSFileManager defaultManager] copyItemAtPath:(NSString *)filepath toPath:(NSString *) destinationpath error:(NSError **) e];
    return [NSString stringWithFormat:@"%@", e];
}

/*!
 @brief Check if a File is locked
 @param  (NSString *)filepath - filepath
 @return '' if everthing happens without any hiccup, else exception message is returned
 @remark This is a super-easy method to use, you only need to provide the to-from filepaths,
 */
-(NSString *)checkIfFileLocked: (NSString *)filepath
{
    NSError *e = nil;
    NSDictionary *attributes=[[NSFileManager defaultManager] attributesOfItemAtPath:(NSString *) filepath error:(NSError **)e];
    BOOL isLocked =[[attributes objectForKey:@"NSFileImmutable"]boolValue];
    return [NSString stringWithFormat:@"%hhd", isLocked];
}

/*!
 @brief get control snippet; i.e. Screenshot if the control only
 @param  (NSString *)appname - Name of Application, 
         (NSDictionary *)uielementConditions are key-value pairs properties using which will be used to search a control on the Screen e.g. AXIdentifier, AXDescription (use developer tools-->accessibility inspector tool for more info), 
         (NSDictionary *)windowConditions are key-value pairs properties of the containing window
 @return JPEG file of the control-specific snip
 @remark in this method, a rectangle is drawn using x,y(top-left position of control) and w,h(width & height of control) and that part starting the x,y coordinates is snips to screenshot to create a control-specific image
 */
-(NSData *)getControlSnip:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions
{
    CGImageRef img = [[self system_Application] getControlSnip:appname and:uielementConditions and:windowConditions];
    NSString *tempDirectory = NSTemporaryDirectory();
    CFURLRef url = (CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/combattempimage.jpg",tempDirectory]];
    
    CGImageDestinationRef destination = CGImageDestinationCreateWithURL(url, kUTTypePNG, 1, NULL);
    
    CGImageDestinationAddImage(destination, img, nil);
    if(!CGImageDestinationFinalize(destination))
        NSLog(@"Failed to write Image");
    
    NSData *mydata = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/combattempimage.jpg",tempDirectory]];
    
    return mydata;
}

/*!
 @brief set ui element
 @param  (NSString *)appname - Name of Application,
 (NSDictionary *)uielementConditions are key-value pairs properties using which will be used to search a control on the Screen e.g. AXIdentifier, AXDescription (use developer tools-->accessibility inspector tool for more info),
 (NSDictionary *)windowConditions are key-value pairs properties of the containing window
 (NSString *)attributeName name of the property to set
 (NSString *)attributeValue set value to
 @return Value set to property just now/ 0 if something bad happens
 @remark setuielement method should be used to set settable properties of the uielement under use
 */
-(NSString *)setUIelement:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions and:(NSString *)attributeName and:(NSString *)attributeValue
{
    //TIMongooseHTTPResponseType response = [self checkIfUIElementExists:appname and:uielementConditions and:windowConditions];
    AXUIElementRef appreference = AXUIElementCreateApplication([[self systemManager]getPid:appname]);
    AXUIElementRef windowRef = nil;
    AXUIElementRef uielement = nil;
    NSDate *datenow = [self logDate];
    NSDate *dateafter = [self logDate];
    NSTimeInterval diff = 0.0;
    while (diff < 6)
    {
        if (windowConditions != nil)
        windowRef = [[self application_Search]findControlIn:appreference and:windowConditions];
        
        if(windowRef != nil)
        uielement = [[self application_Search] findControlInWindow:windowRef and:uielementConditions];
        else
        uielement = [[self application_Search] findControlIn:appreference and:uielementConditions];
        dateafter = [self logDate];
        diff = [dateafter timeIntervalSinceDate:datenow];
        if (uielement != nil)
        break;
    }
    if(uielement != nil)
    {
        [[self control_Set]setValueForAttribute:(CFStringRef)attributeName forElement:uielement withValue:(CFTypeRef)attributeValue];
        
        BOOL verifyValue = [[self control_Get]verifyAttribute:(CFStringRef)attributeName forElement:uielement withValue:(CFTypeRef)attributeValue];
        
        return [NSString stringWithFormat:@"%hhd",verifyValue];
    }
    else
    {
        return @"0";
    }
}

/*!
 @brief click ui element
 @param  (NSString *)appname - Name of Application,
 (NSDictionary *)uielementConditions are key-value pairs properties using which will be used to search a control on the Screen e.g. AXIdentifier, AXDescription (use developer tools-->accessibility inspector tool for more info),
 (NSDictionary *)windowConditions are key-value pairs properties of the containing window
 @return Value set to property just now/ 0 if something bad happens
 @remark clickuielement method should be used to Click properties of the uielement under use
 */
-(NSString *)clickUIelement:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions
{    
    
    AXUIElementRef appreference = AXUIElementCreateApplication([[self systemManager]getPid:appname]);
    AXUIElementRef windowRef = nil;
    AXUIElementRef uielement = nil;
    NSDate *datenow = [self logDate];
    NSLog(@"Date Now:%@", datenow);
    //NSTimeInterval sectoadd = 1;
    
    NSDate *dateafter = [self logDate];
    NSLog(@"New Date::%@",dateafter);
    NSTimeInterval diff = 0.0;
    while (diff < 6)
    {
        
    if (windowConditions != nil)
        windowRef = [[self application_Search]findControlIn:appreference and:windowConditions];
    
    if(windowRef != nil)
        uielement = [[self application_Search] findControlInWindow:windowRef and:uielementConditions];
    else
        uielement = [[self application_Search] findControlIn:appreference and:uielementConditions];
        NSDate *dateafter = [self logDate];
        NSLog(@"New Date HERE::%@",dateafter);
        //dateafter = [dateafter dateByAddingTimeInterval:sectoadd];
        //NSLog(@"Date After:%@",dateafter);
        diff = [dateafter timeIntervalSinceDate:datenow];
        //timeout --;
        if (uielement != nil)
            break;
    }
    if(uielement != nil)
    {
        NSPoint screenpoint = [[self control_Get]getPosition:uielement];
        NSSize controlsize = [[self control_Get] getSize:uielement];
        NSString * response=[[self combat_Mouse]clickOnControl:screenpoint andSize:controlsize];
        return [NSString stringWithFormat:@"%@",response];
    }
    else
    {
        return [NSString stringWithFormat:@"0"];
    }
}

/*!
 @brief check if ui element exists
 @param  (NSString *)appname - Name of Application,
 (NSDictionary *)uielementConditions are key-value pairs properties using which will be used to search a control on the Screen e.g. AXIdentifier, AXDescription (use developer tools-->accessibility inspector tool for more info),
 (NSDictionary *)windowConditions are key-value pairs properties of the containing window
 @return 1 if exists/ 0 if not found
 @remark checkIfUIElementExists method should be used to see if UI element is visible on screen
 */
-(NSString *)checkIfUIElementExists:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions
{
    
    //[NSThread sleepForTimeInterval:2.0];
    AXUIElementRef appreference = AXUIElementCreateApplication([[self systemManager]getPid:appname]);
    AXUIElementRef windowRef = nil;
    AXUIElementRef uielement = nil;
    
    if (windowConditions != nil)
        windowRef = [[self application_Search]findControlIn:appreference and:windowConditions];
    
    if(windowRef != nil)
        uielement = [[self application_Search] findControlInWindow:windowRef and:uielementConditions];
    else
        uielement = [[self application_Search] findControlIn:appreference and:uielementConditions];
    
    if(uielement != nil)
    {
        return [NSString stringWithFormat:@"1"];
    }
    else
    {
        return [NSString stringWithFormat:@"0"];    }
}

/*!
 @brief Click on Table List Item
 @param  (NSString *)appname - Name of Application,
 (NSDictionary *)uielementConditions are key-value pairs properties using which will be used to search a control on the Screen e.g. AXIdentifier, AXDescription (use developer tools-->accessibility inspector tool for more info),
 (NSDictionary *)windowConditions are key-value pairs properties of the containing window
 @return YE/No depending if was able to perform click/ 0 if ui element not found
 @remark clickTableListItem method should be used to select Item in a Table
 */
-(NSString *)     clickTableListItem:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions
{
    
    //[NSThread sleepForTimeInterval:2.0];
    AXUIElementRef appreference = AXUIElementCreateApplication([[self systemManager]getPid:appname]);
    AXUIElementRef windowRef = nil;
    AXUIElementRef uielement = nil;
    
    NSDate *datenow = [self logDate];
    NSDate *dateafter = [self logDate];
    NSTimeInterval diff = 0.0;
    while (diff < 6)
    {
    if (windowConditions != nil)
        windowRef = [[self application_Search]findControlIn:appreference and:windowConditions];
    
    if(windowRef != nil)
        uielement = [[self application_Search] findControlInWindow:windowRef and:uielementConditions];
    else
        uielement = [[self application_Search] findControlIn:appreference and:uielementConditions];
        dateafter = [self logDate];
        diff = [dateafter timeIntervalSinceDate:datenow];
        if (uielement != nil)
            break;
    }
    if(uielement != nil)
    {
        NSPoint screenpoint = [[self control_Get]getPosition:uielement];
        NSSize controlsize = [[self control_Get] getSize:uielement];
        NSString * res=[[self combat_Mouse]clickOnControl:screenpoint andSize:controlsize];
        return [NSString stringWithFormat:@"%@",res];
    }
    else
    {
        return @"0";
    }
}

/*!
 @brief Check a Checkbox Ui Element
 @param  (NSString *)appname - Name of Application,
 (NSDictionary *)uielementConditions are key-value pairs properties using which will be used to search a control on the Screen e.g. AXIdentifier, AXDescription (use developer tools-->accessibility inspector tool for more info),
 (NSDictionary *)windowConditions are key-value pairs properties of the containing window
 @return YE/No depending if was able to perform check operation/ 0 if somethign went wrong while doing Check operation / 1 if already checked
 @remark checkCheckBox method should be used to check checkbox
 */
-(NSString *)checkCheckBox:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions
{
    //[NSThread sleepForTimeInterval:0.6];
    AXUIElementRef appreference = AXUIElementCreateApplication([[self systemManager]getPid:appname]);
    AXUIElementRef windowRef = nil;
    AXUIElementRef uielement = nil;
    NSString * ifChecked = [self verifyUIelement1:appname and:uielementConditions and:windowConditions and:@"AXValue" and:@"1"];
    if (![ifChecked caseInsensitiveCompare:@"0"]) {
    
    if (windowConditions != nil)
        windowRef = [[self application_Search]findControlIn:appreference and:windowConditions];
    
    if(windowRef != nil)
        uielement = [[self application_Search] findControlIn:windowRef and:uielementConditions];
    else
        uielement = [[self application_Search] findControlIn:appreference and:uielementConditions];
    if(uielement != nil)
    {
        NSPoint screenpoint = [[self control_Get]getPosition:uielement];
        NSSize controlsize = [[self control_Get] getSize:uielement];
        NSString * res = [[self combat_Mouse]clickOnControl:screenpoint andSize:controlsize];
        //[NSThread sleepForTimeInterval:1.0];
        return [NSString stringWithFormat:@"%@",res];
        
    }
    else
    {
        return [NSString stringWithFormat:@"0"];
    }
    }
    else
        return [NSString stringWithFormat:@"1"];
}

/*!
 @brief Uncheck a Checkbox Ui Element
 @param  (NSString *)appname - Name of Application,
 (NSDictionary *)uielementConditions are key-value pairs properties using which will be used to search a control on the Screen e.g. AXIdentifier, AXDescription (use developer tools-->accessibility inspector tool for more info),
 (NSDictionary *)windowConditions are key-value pairs properties of the containing window
 @return YE/No depending if was able to perform uncheck operation/ 0 if somethign went wrong while doing UnCheck operation / 1 if already unchecked
 @remark uncheckCheckBox method should be used to uncheck checkbox
 */
-(NSString *)uncheckCheckBox:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions
{
    //[NSThread sleepForTimeInterval:0.6];
    AXUIElementRef appreference = AXUIElementCreateApplication([[self systemManager]getPid:appname]);
    AXUIElementRef windowRef = nil;
    AXUIElementRef uielement = nil;
    NSString * ifChecked = [self verifyUIelement1:appname and:uielementConditions and:windowConditions and:@"AXValue" and:@"0"];
    if (![ifChecked caseInsensitiveCompare:@"0"]) {
        
        if (windowConditions != nil)
            windowRef = [[self application_Search]findControlIn:appreference and:windowConditions];
        
        if(windowRef != nil)
            uielement = [[self application_Search] findControlIn:windowRef and:uielementConditions];
        else
            uielement = [[self application_Search] findControlIn:appreference and:uielementConditions];
        if(uielement != nil)
        {
            NSPoint screenpoint = [[self control_Get]getPosition:uielement];
            NSSize controlsize = [[self control_Get] getSize:uielement];
            NSString * res = [[self combat_Mouse]clickOnControl:screenpoint andSize:controlsize];
            //[NSThread sleepForTimeInterval:1.0];
            return [NSString stringWithFormat:@"%@",res];
            
        }
        else
        {
            return @"0";
        }
    }
    else
        return [NSString stringWithFormat:@"1"];
}

/*!
 @brief click increment Ui Element
 @param  (NSString *)appname - Name of Application,
 (NSDictionary *)uielementConditions are key-value pairs properties using which will be used to search a control on the Screen e.g. AXIdentifier, AXDescription (use developer tools-->accessibility inspector tool for more info),
 (NSDictionary *)windowConditions are key-value pairs properties of the containing window
 @return YE/No depending if was able to perform increment/ 0 if somethign went wrong while doing increment operation
 */
-(NSString *)clickIncrementButton:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions
{
    AXUIElementRef appreference = AXUIElementCreateApplication([[self systemManager]getPid:appname]);
    AXUIElementRef windowRef = nil;
    AXUIElementRef uielement = nil;
    
    NSDate *datenow = [self logDate];
    NSDate *dateafter = [self logDate];
    NSTimeInterval diff = 0.0;
    while (diff < 6)
    {
        if (windowConditions != nil)
        windowRef = [[self application_Search]findControlIn:appreference and:windowConditions];
        
        if(windowRef != nil)
        uielement = [[self application_Search] findControlInWindow:windowRef and:uielementConditions];
        else
        uielement = [[self application_Search] findControlIn:appreference and:uielementConditions];
        dateafter = [self logDate];
        diff = [dateafter timeIntervalSinceDate:datenow];
        if (uielement != nil)
        break;
    }
    if(uielement != nil)
    {
        NSPoint screenpoint = [[self control_Get]getPosition:uielement];
        NSSize controlsize = [[self control_Get] getSize:uielement];
        NSSize newcontrolsize=NSMakeSize((controlsize.width), (controlsize.height/2));
        NSString * res = [[self combat_Mouse]clickOnControl:screenpoint andSize:newcontrolsize];
        return [NSString stringWithFormat:@"%@", res];
    }
    else
    {
        return @"0";
    }
}

/*!
 @brief click decrement Ui Element
 @param  (NSString *)appname - Name of Application,
 (NSDictionary *)uielementConditions are key-value pairs properties using which will be used to search a control on the Screen e.g. AXIdentifier, AXDescription (use developer tools-->accessibility inspector tool for more info),
 (NSDictionary *)windowConditions are key-value pairs properties of the containing window
 @return YE/No depending if was able to perform decrement/ 0 if somethign went wrong while doing decrement operation
 */
-(NSString *)clickDecrementButton:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions
{
    //[NSThread sleepForTimeInterval:0.6];
    AXUIElementRef appreference = AXUIElementCreateApplication([[self systemManager]getPid:appname]);
    AXUIElementRef windowRef = nil;
    AXUIElementRef uielement = nil;
    
    NSDate *datenow = [self logDate];
    NSDate *dateafter = [self logDate];
    NSTimeInterval diff = 0.0;
    while (diff < 6)
    {
        if (windowConditions != nil)
        windowRef = [[self application_Search]findControlIn:appreference and:windowConditions];
        
        if(windowRef != nil)
        uielement = [[self application_Search] findControlInWindow:windowRef and:uielementConditions];
        else
        uielement = [[self application_Search] findControlIn:appreference and:uielementConditions];
        dateafter = [self logDate];
        diff = [dateafter timeIntervalSinceDate:datenow];
        if (uielement != nil)
        break;
    }
    if(uielement != nil)
    {
        NSPoint screenpoint = [[self control_Get]getPosition:uielement];
        NSSize controlsize = [[self control_Get] getSize:uielement];
        NSSize newcontrolsize=NSMakeSize((controlsize.width), (controlsize.height/2));
        NSPoint newscreenpoint=NSMakePoint(screenpoint.x, (screenpoint.y+(controlsize.height/2)));
        NSString * res=[[self combat_Mouse]clickOnControl:newscreenpoint andSize:newcontrolsize];
        return [NSString stringWithFormat:@"%@", res];
    }
    else
    {
        return @"0";
    }
}

/*!
 @brief click Combobox Ui Element
 @param  (NSString *)appname - Name of Application,
 (NSDictionary *)uielementConditions are key-value pairs properties using which will be used to search a control on the Screen e.g. AXIdentifier, AXDescription (use developer tools-->accessibility inspector tool for more info),
 (NSDictionary *)windowConditions are key-value pairs properties of the containing window
 @return YE/No depending if was able to select item in combo box/ 0 if somethign went wrong while selecting item in combobox
 */
-(NSString *)clickComboBoxButton:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions and:(NSString*) menuOption
{
    //[NSThread sleepForTimeInterval:1.0];
    AXUIElementRef appreference = AXUIElementCreateApplication([[self systemManager]getPid:appname]);
    AXUIElementRef windowRef = nil;
    AXUIElementRef uielement = nil;
    
    NSDate *datenow = [self logDate];
    NSDate *dateafter = [self logDate];
    NSTimeInterval diff = 0.0;
    while (diff < 6)
    {
        if (windowConditions != nil)
        windowRef = [[self application_Search]findControlIn:appreference and:windowConditions];
        
        if(windowRef != nil)
        uielement = [[self application_Search] findControlInWindow:windowRef and:uielementConditions];
        else
        uielement = [[self application_Search] findControlIn:appreference and:uielementConditions];
        dateafter = [self logDate];
        diff = [dateafter timeIntervalSinceDate:datenow];
        if (uielement != nil)
        break;
    }
    if(uielement != nil)
    {
        NSPoint screenpoint = [[self control_Get]getPosition:uielement];
        NSSize controlsize = [[self control_Get] getSize:uielement];
        NSSize newcontrolsize=NSMakeSize((16), (controlsize.height));
        NSPoint newscreenpoint=NSMakePoint((screenpoint.x+controlsize.width-18), (screenpoint.y));
        NSString *res1 = [[self combat_Mouse]clickOnControl:newscreenpoint andSize:newcontrolsize];
        if ([res1 isEqualToString:@"1"]) {
            [self typeText:(menuOption)];
            //[NSThread sleepForTimeInterval:1.0];
            [self typeSpecial:(@"ENTER")];
        }
        return [NSString stringWithFormat:@"1"];

    }
    else
    {
        return @"0";
    }
}

-(NSString *)hoverOverMenu:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions
{
    AXUIElementRef appreference = AXUIElementCreateApplication([[self systemManager]getPid:appname]);
    AXUIElementRef windowRef = nil;
    AXUIElementRef uielement = nil;
    
    NSDate *datenow = [self logDate];
    NSDate *dateafter = [self logDate];
    NSTimeInterval diff = 0.0;
    while (diff < 6)
    {
        if (windowConditions != nil)
        windowRef = [[self application_Search]findControlIn:appreference and:windowConditions];
        
        if(windowRef != nil)
        uielement = [[self application_Search] findControlInWindow:windowRef and:uielementConditions];
        else
        uielement = [[self application_Search] findControlIn:appreference and:uielementConditions];
        dateafter = [self logDate];
        diff = [dateafter timeIntervalSinceDate:datenow];
        if (uielement != nil)
        break;
    }
    if(uielement != nil)
    {
        NSPoint screenpoint = [[self control_Get]getPosition:uielement];
        NSString * res=[[self combat_Mouse]moveCursor:screenpoint];
        return [NSString stringWithFormat:@"%@", res];
        
        
        
    }
    else
    {
        return @"0";
    }
}

/*!
 @brief click on screen point
 @param  (NSPoint)screenpoint - Screen x,y coordinates on which click operation needs to be performed
 @return 1 click operation successful / 0 something went wrong while doing lcick operation
 @remark This is a super-easy method to use, when click on screen point needs to be perfomed
 */
-(NSString *)clickOnScreenPoint:(NSPoint)screenpoint
{
    NSString * res=[[self combat_Mouse] clickOnScreen:screenpoint];
    NSString * res1;
    if ([res isEqualToString:@"1"]) {
        res1 = @"1";
    }
    else
       res1= @"0";
    return [NSString stringWithFormat:@"%@", res1];
}

/*!
 @brief Select Application Menu Option
 @param  (NSString *)appname - name of application under test
         (NSArray *)menuoptions - Array path to be selected on the application menu (File, New) .. etc.
 @return (NSString *) - Applescript response
 */
-(NSString *)selectAppMenuOption:(NSString *)appname and:(NSArray *)menuoptions
{
    return [NSString stringWithFormat:@"%@", [[self application_AppleScript_Set]clickAppMenu:appname andMenuPath:menuoptions]];
}

/*!
 @brief tick/untick Application Menu Option
 @param  (NSString *)appname - name of application under test
 (NSArray *)menuoptions - Array path to be selected on the application menu (File, New) .. etc.
 (NSString *)tickUntickMenuOption - tick/untick
 @return (NSString *) - Applescript response
 */
-(NSString *)tickuntickmenuoption:(NSString *)appname and:(NSArray *)menuoptions and:(NSString *)tickUntickMenuOption
{
    return [NSString stringWithFormat:@"%@", [[self application_AppleScript_Set]tickUntickAppMenu:appname andMenuPath:menuoptions andTickUntick:tickUntickMenuOption ]];
}

/*!
 @brief Select Pop up menu option
 @param  (NSString *)appname - Name of Application,
         (NSDictionary *)uielementConditions are key-value pairs properties using which will be used to search a control on the Screen e.g. AXIdentifier, AXDescription (use developer tools-->accessibility inspector tool for more info),
         (NSDictionary *)windowConditions are key-value pairs properties of the containing window
 @return (NSString *)
 */
-(NSString *)selectPopUpMenuOption:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions and:(NSString *)menuOption
{
    return [NSString stringWithFormat:@"%@",[[self application_AppleScript_Set] clickOnPopUpButton:appname forControl:uielementConditions andMenuOption:menuOption]];
}

/*!
 @brief Select option from Combo up menu option
 @param  (NSString *)appname - Name of Application,
 (NSDictionary *)uielementConditions are key-value pairs properties using which will be used to search a control on the Screen e.g. AXIdentifier, AXDescription (use developer tools-->accessibility inspector tool for more info),
 (NSDictionary *)windowConditions are key-value pairs properties of the containing window
 @return (NSString *)
 */
-(NSString *)selectOptionFromComboBox:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions and:(NSString *)menuOption
{
    return [NSString stringWithFormat:@"%@",[[self application_AppleScript_Set] selectOptionFromComboBox:appname forControl:uielementConditions andMenuOption:menuOption]];
}

/*!
 @brief Select option from Combo up menu option
 @param  (NSString *)appname - Name of Application,
 (NSDictionary *)uielementConditions are key-value pairs properties using which will be used to search a control on the Screen e.g. AXIdentifier, AXDescription (use developer tools-->accessibility inspector tool for more info),
 (NSDictionary *)windowConditions are key-value pairs properties of the containing window
 @return (NSString *)
 */
-(NSString *)setOptionValuetoComboBox:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions and:(NSString *)menuOption
{
    return [NSString stringWithFormat:@"%@",[[self application_AppleScript_Set] setOptionValuetoComboBox:appname forControl:uielementConditions andMenuOption:menuOption]];
}

/*!
 @brief CLick UI Element using AppleScipt
 @param  (NSString *)appname - Name of Application,
 (NSDictionary *)uielementConditions are key-value pairs properties using which will be used to search a control on the Screen e.g. AXIdentifier, AXDescription (use developer tools-->accessibility inspector tool for more info)
 @return (NSString *)
 */
-(NSString *)clickUIControl:(NSString *)appname and:(NSDictionary *)uielementConditions
{
    return [NSString stringWithFormat:@"%@",[[self application_AppleScript_Set] clickUIControl:appname forControl:uielementConditions]];
}

/*!
 @brief Check Checkbox UI Element using AppleScipt
 @param  (NSString *)appname - Name of Application,
 (NSDictionary *)uielementConditions are key-value pairs properties using which will be used to search a control on the Screen e.g. AXIdentifier, AXDescription (use developer tools-->accessibility inspector tool for more info)
 @return (NSString *)
 */
-(NSString *)checkCheckBox:(NSString *)appname and:(NSDictionary *)uielementConditions
{
    return [NSString stringWithFormat:@"%@",[[self application_AppleScript_Set] checkCheckBox:appname forControl:uielementConditions] ];
}

/*!
 @brief Uncheck Checkbox UI Element using AppleScipt
 @param  (NSString *)appname - Name of Application,
 (NSDictionary *)uielementConditions are key-value pairs properties using which will be used to search a control on the Screen e.g. AXIdentifier, AXDescription (use developer tools-->accessibility inspector tool for more info)
 @return (NSString *)
 */
-(NSString *)uncheckCheckBox:(NSString *)appname and:(NSDictionary *)uielementConditions
{
    return [NSString stringWithFormat:@"%@",[[self application_AppleScript_Set] uncheckCheckBox:appname forControl:uielementConditions] ];
}

/*!
 @brief edit EDIT UI Element using AppleScipt
 @param  (NSString *)appname - Name of Application,
 (NSDictionary *)uielementConditions are key-value pairs properties using which will be used to search a control on the Screen e.g. AXIdentifier, AXDescription (use developer tools-->accessibility inspector tool for more info)
 (NSString *)option -  text to be added in the edit field
 @return (NSString *)
 */
-(NSString *)editTextField:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSString *)option
{
    return [NSString stringWithFormat:@"%@",[[self application_AppleScript_Set] editTextField:appname forControl:uielementConditions andMenuOption:option] ];
}

/*!
 @brief edit EDIT UI Element
 @param  (NSString *)appname - Name of Application,
 (NSDictionary *)uielementConditions are key-value pairs properties using which will be used to search a control on the Screen e.g. AXIdentifier, AXDescription (use developer tools-->accessibility inspector tool for more info)
 (NSString *)option -  text to be added in the edit field
 @return (NSString *)
 */
-(NSString *)typeText:(NSString *)text
{
    NSString * res = [[self combat_Keyboard] keyIn:text];
    return [NSString stringWithFormat:@"%@ '%@'", res, text];
}

/*!
 @brief Type Special Characters
 @param  (NSString *)specialKey - Special Key Characters
 @return (NSString *)
 */
-(NSString *)typeSpecial:(NSString *)specialKey
{
    NSString *res = [[self combat_Keyboard]specialKeyIn:specialKey];
    return [NSString stringWithFormat:@"%@ '%@'", res, specialKey];
}

/*!
 @brief Type Characters along with Modifier Key
 @param  (NSString *)specialKey - Special Key Characters
         (NSString *)modifierKeys - Modifier Key (CMD, SHIFT, ALT, CTRL)
 @return (NSString *)
 */
-(NSString *)typeTextWithModifier:(NSString *)text and:(NSString *)modifierKeys
{
    NSString * res = [[self combat_Keyboard]keyIn:text withModifiers:modifierKeys];
    
    return [NSString stringWithFormat:@"%@ '%@ + %@'", res, modifierKeys ,text];
}

/*!
 @brief Type Characters along with Modifier Key
 @param  (NSPoint)begin - starting point x,y
 (NSPoint)end - end point x,y
 @return (NSString *)
 */
-(NSString *)clickDragRelease:(NSPoint)begin and:(NSPoint)end
{
    NSString * res=[[self combat_Mouse] click:begin dragAndRelease:end];
    return [NSString stringWithFormat:@"%@",res];
}

/*!
 @brief Get UI Element Attributes
 @param  (NSString *)appname - Name of Application,
 (NSDictionary *)uielementConditions are key-value pairs properties using which will be used to search a control on the Screen e.g. AXIdentifier, AXDescription (use developer tools-->accessibility inspector tool for more info),
 (NSDictionary *)windowConditions are key-value pairs properties of the containing window
 @return (NSString *) get list of all Key-Value attributes
 */
-(NSString *)getUIelementAttributes:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions
{
    AXUIElementRef appreference = AXUIElementCreateApplication([[self systemManager]getPid:appname]);
    AXUIElementRef windowRef = nil;
    AXUIElementRef uielement = nil;
    
    if (windowConditions != nil)
        windowRef = [[self application_Search]findControlIn:appreference and:windowConditions];
    
    if(windowRef != nil)
        uielement = [[self application_Search] findControlIn:windowRef and:uielementConditions];
    else
        uielement = [[self application_Search] findControlIn:appreference and:uielementConditions];
    
    if(uielement != nil)
    {
        return [NSString stringWithFormat:@"%@",[[self control_Get] getValueOfAllAttributes:uielement]];
    }
    
    else
    {
        return @"0";
    }
}

/*!
 @brief Get All Children of a UI Element
 @param  (NSString *)appname - Name of Application,
 (NSDictionary *)uielementConditions are key-value pairs properties using which will be used to search a control on the Screen e.g. AXIdentifier, AXDescription (use developer tools-->accessibility inspector tool for more info),
 (NSDictionary *)windowConditions are key-value pairs properties of the containing window
 @return (NSString *)
 */
-(NSString *)getuielementDescendants:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions
{
    AXUIElementRef appreference = AXUIElementCreateApplication([[self systemManager]getPid:appname]);
    AXUIElementRef windowRef = nil;
    AXUIElementRef uielement = nil;
    
    if (windowConditions != nil)
        windowRef = [[self application_Search]findControlIn:appreference and:windowConditions];
    
    if(windowRef != nil)
        uielement = [[self application_Search] findControlIn:windowRef and:uielementConditions];
    else
        uielement = [[self application_Search] findControlIn:appreference and:uielementConditions];
    
    if(uielement != nil)
    {
        return [NSString stringWithFormat:@"%@",[[self application_Get] getElementAndDescendantsInfo:uielement]];
    }
    
    else
    {
        return @"0";
    }
}

/*!
 @brief Get root to Current of a UI Element
 @param  (NSString *)appname - Name of Application,
 (NSDictionary *)uielementConditions are key-value pairs properties using which will be used to search a control on the Screen e.g. AXIdentifier, AXDescription (use developer tools-->accessibility inspector tool for more info),
 (NSDictionary *)windowConditions are key-value pairs properties of the containing window
 @return (NSString *)
 */
-(NSString *)getUIElementLineage:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions
{
    AXUIElementRef appreference = AXUIElementCreateApplication([[self systemManager]getPid:appname]);
    AXUIElementRef windowRef = nil;
    AXUIElementRef uielement = nil;
    
    if (windowConditions != nil)
        windowRef = [[self application_Search]findControlIn:appreference and:windowConditions];
    
    if(windowRef != nil)
        uielement = [[self application_Search] findControlIn:windowRef and:uielementConditions];
    else
        uielement = [[self application_Search] findControlIn:appreference and:uielementConditions];
    
    if(uielement != nil)
    {
        return [NSString stringWithFormat:@"%@",[[self application_Get] getLineage:uielement]];
    }
    
    else
    {
        return @"0";
    }
}

/*!
 @brief Get all Propertiesof current UI Element
 @param  (NSString *)appname - Name of Application,
 (NSDictionary *)uielementConditions are key-value pairs properties using which will be used to search a control on the Screen e.g. AXIdentifier, AXDescription (use developer tools-->accessibility inspector tool for more info),
 (NSDictionary *)windowConditions are key-value pairs properties of the containing window
 @return (NSString *)
 */
-(NSString *)getUIelementInfo:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions
{
    AXUIElementRef appreference = AXUIElementCreateApplication([[self systemManager]getPid:appname]);
    AXUIElementRef windowRef = nil;
    AXUIElementRef uielement = nil;
    
    NSDate *datenow = [self logDate];
    NSDate *dateafter = [self logDate];
    NSTimeInterval diff = 0.0;
    while (diff < 6)
    {
        if (windowConditions != nil)
        windowRef = [[self application_Search]findControlIn:appreference and:windowConditions];
        
        if(windowRef != nil)
        uielement = [[self application_Search] findControlInWindow:windowRef and:uielementConditions];
        else
        uielement = [[self application_Search] findControlIn:appreference and:uielementConditions];
        dateafter = [self logDate];
        diff = [dateafter timeIntervalSinceDate:datenow];
        if (uielement != nil)
        break;
    }
    if(uielement != nil)
    {
        return [NSString stringWithFormat:@"%@",[[self application_Get] getElementInfo:uielement]];
    }
    
    else
    {
        return @"0";
    }
}

/*!
 @brief check if property name of current UI Element is settable
 @param  (NSString *)appname - Name of Application,
 (NSDictionary *)uielementConditions are key-value pairs properties using which will be used to search a control on the Screen e.g. AXIdentifier, AXDescription (use developer tools-->accessibility inspector tool for more info),
 (NSDictionary *)windowConditions are key-value pairs properties of the containing window,
 (NSString *)attributeName - Attribute name to set a value to
 @return (NSString *)
 */
-(NSString *)isUIelementSettable:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions and:(NSString *)attributeName
{
    AXUIElementRef appreference = AXUIElementCreateApplication([[self systemManager]getPid:appname]);
    AXUIElementRef windowRef = nil;
    AXUIElementRef uielement = nil;
    
    NSDate *datenow = [self logDate];
    NSDate *dateafter = [self logDate];
    NSTimeInterval diff = 0.0;
    while (diff < 6)
    {
        if (windowConditions != nil)
        windowRef = [[self application_Search]findControlIn:appreference and:windowConditions];
        
        if(windowRef != nil)
        uielement = [[self application_Search] findControlInWindow:windowRef and:uielementConditions];
        else
        uielement = [[self application_Search] findControlIn:appreference and:uielementConditions];
        dateafter = [self logDate];
        diff = [dateafter timeIntervalSinceDate:datenow];
        if (uielement != nil)
        break;
    }
    if(uielement != nil)
    {
        return [NSString stringWithFormat:@"%hhd",[[self control_Set] isAttributeSettable:uielement and:(CFStringRef)attributeName]];
    }
    else
    {
        return @"0";
    }
}

/*!
 @brief Verify property of a UIElement is set to an expected value or not
 @param  (NSString *)appname - Name of Application,
 (NSDictionary *)uielementConditions are key-value pairs properties using which will be used to search a control on the Screen e.g. AXIdentifier, AXDescription (use developer tools-->accessibility inspector tool for more info),
 (NSDictionary *)windowConditions are key-value pairs properties of the containing window,
 (NSString *)attributeName - Attribute name to set a value to
 NSString *)expectedValue - Expected value of property
 @return (NSString *)
 */
-(NSString *)verifyUIelement:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions and:(NSString *)attributeName and:(NSString *)expectedValue
{
    //[NSThread sleepForTimeInterval:1.0];
    AXUIElementRef appreference = AXUIElementCreateApplication([[self systemManager]getPid:appname]);
    AXUIElementRef windowRef = nil;
    AXUIElementRef uielement = nil;
    
    NSDate *datenow = [self logDate];
    NSDate *dateafter = [self logDate];
    NSTimeInterval diff = 0.0;
    while (diff < 6)
    {
        if (windowConditions != nil)
        windowRef = [[self application_Search]findControlIn:appreference and:windowConditions];
        
        if(windowRef != nil)
        uielement = [[self application_Search] findControlInWindow:windowRef and:uielementConditions];
        else
        uielement = [[self application_Search] findControlIn:appreference and:uielementConditions];
        dateafter = [self logDate];
        diff = [dateafter timeIntervalSinceDate:datenow];
        if (uielement != nil)
        break;
    }
    if(uielement != nil)
    {
        BOOL verifyValue = [[self control_Get]verifyAttribute:(CFStringRef)attributeName forElement:uielement withValue:(CFTypeRef)expectedValue];
    
        return [NSString stringWithFormat:@"%hhd",verifyValue];
    }
    else
    {
        return [NSString stringWithFormat:@"0"];
    }
}
-(NSString *)verifyUIelement1:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions and:(NSString *)attributeName and:(NSString *)expectedValue
{
    //[NSThread sleepForTimeInterval:1.0];
    AXUIElementRef appreference = AXUIElementCreateApplication([[self systemManager]getPid:appname]);
    AXUIElementRef windowRef = nil;
    AXUIElementRef uielement = nil;
    
    NSDate *datenow = [self logDate];
    NSDate *dateafter = [self logDate];
    NSTimeInterval diff = 0.0;
    while (diff < 6)
    {
        if (windowConditions != nil)
        windowRef = [[self application_Search]findControlIn:appreference and:windowConditions];
        
        if(windowRef != nil)
        uielement = [[self application_Search] findControlInWindow:windowRef and:uielementConditions];
        else
        uielement = [[self application_Search] findControlIn:appreference and:uielementConditions];
        dateafter = [self logDate];
        diff = [dateafter timeIntervalSinceDate:datenow];
        if (uielement != nil)
        break;
    }
    if(uielement != nil)
    {
        BOOL verifyValue = [[self control_Get]verifyAttribute:(CFStringRef)attributeName forElement:uielement withValue:(CFTypeRef)expectedValue];
        NSString * res= [NSString stringWithFormat:@"%hhd",verifyValue];
        return res;
    }
    else
    {
        NSString * res= [NSString stringWithFormat:@"0"];
        return res;
    }
}

#pragma mark Static Methods
+(CombatInterface *)getInstance
{
    if(curInstance == nil)
        curInstance = [[CombatInterface alloc]init];
    
    return curInstance;
}

+(void) destroyInstance
{
    if (curInstance != nil) {
        [curInstance release];
    }
}

-(NSDate *)logDate
{
    NSDate * now=[NSDate date];
    NSDateFormatter *outputFormatter=[[NSDateFormatter alloc]init];
    [outputFormatter setDateFormat:@"HH:mm:ss"];
    NSString *newdatestring=[outputFormatter stringFromDate:now];
    NSLog(@"time Stamp:%@",newdatestring);
    return now;
    [outputFormatter release];
}
@end
