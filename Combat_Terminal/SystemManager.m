//
//  System.m
/*!
@author Piyush Bansal (piyush2508@gmail.com), Gopi Krishna Rajoju (gopirajoju@live.com) and Sakshi Goyal (sakshigoyal369@gmail.com)

@date 04/07/14

@brief This class is used to interact with Application under test tocheck if it's running, is the app is ready, to luanch and quit an app, 
to get the process ID of the app, to get the screen resolution of the system, to get the screenshot of the current screen, to bring an app to front and focus, and to wait for a certain amount of time for an app to be ready

@copyright Copyright (c) 2015, The Combat authors - Piyush Bansal, Gopi Krishna Rajoju and Sakshi Goyal. All rights reserved.

Redistribution is not permitted. Use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Use of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

Use in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the derived product.

The names of its contributors must not be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#import "SystemManager.h"
#import <AppKit/AppKit.h>

@implementation SystemManager
/*!

 @brief This method is used to check if the given application is currently running on the system.

 @param appname is the name of the application that needs to be checked.

 @return (BOOL) The value is YES if the app is running and NO if it is not.

 @remark This method is used to check if the given application is currently running on the system.

 */
-(BOOL)isAppRunning:(NSString *)appname
{
    NSArray* allRunningApps = [[NSWorkspace sharedWorkspace]runningApplications];
    
    for(NSRunningApplication *runningApp in allRunningApps){
        if([runningApp.localizedName isEqualToString:appname])
            [self bringAppToFront:appname];
            return YES;
    }
    return NO;
}
/*!

 @brief This method is used to check if the given application is currently ready to recieve commands or not.

 @param appname is the name of the application that needs to be checked.

 @return (BOOL) The value is YES if the app is ready and NO if it is not.

 @remark This method is used to check if the given application is currently ready to recieve commands or not.

 */
-(BOOL)isAppReady:(NSString *)appname
{
            BOOL result = false;
    if([self isAppRunning:appname])
    {

        NSArray* allRunningApps = [[NSWorkspace sharedWorkspace]runningApplications];
        NSRunningApplication *myApp;
        for(NSRunningApplication *runningApp in allRunningApps)
        {
            if([runningApp.localizedName isEqualToString:appname])
            {
                [self bringAppToFront:appname];
                myApp = runningApp;
                break;
            }
        }
        @try {
            if ([myApp isActive]) {
                result = true;
            }
        }
        @catch (NSException *exception) {
        }
    }
    return result;
}
/*!

 @brief This method is used to launch the given application.

 @param appname is the name of the application that needs to be launched.

 @return (BOOL) The value is YES if the app is running after launch and NO if it is not.

 @remark This method is used to launch the given application.

 */
-(BOOL)launchApp:(NSString *)appname
{
    
     NSDictionary* error;
    NSString* appleScriptInput = [[NSString alloc]initWithFormat:@"set appname to \"%@\" \n tell application appname \n activate \n tell application \"System Events\" \n tell process appname \n get UI elements \n end tell \n end tell \n end tell \n", appname];
    
    
    if(appname != NULL){
        NSAppleScript *scriptObject = [[NSAppleScript alloc]initWithSource:appleScriptInput];
        sleep(1);
        [scriptObject executeAndReturnError:&error];
    }
    /*NSTask *task =[[NSTask alloc] init];
    
    NSString* path= [[NSString alloc] initWithFormat:@"/Applications/QCD_09_04/%@", appname];
    NSBundle *bundle=[NSBundle bundleWithPath:[[NSWorkspace sharedWorkspace] fullPathForApplication:path]] ;
    [task setLaunchPath:[bundle executablePath]];
    
    if (appname != NULL) {
        [task setArguments:[NSArray arrayWithObjects:@"-a",appname, nil]];
        [task launch];
        [task release];
    }*/
    
    return [self isAppRunning:appname];
}
/*!

 @brief This method is used to quit the given application if it is running on the system.

 @param appname is the name of the application that needs to be quit.

 @return (BOOL) The value is YES if the app is not running after quit and NO if it is still running.

 @remark This method is used to quit the given application if it is running on the system.

 */
-(BOOL)quitApp:(NSString *)appname
{
    if ([self isAppRunning:appname]) {
        NSArray* allRunningApps = [[NSWorkspace sharedWorkspace]runningApplications];
        [NSThread sleepForTimeInterval:0.6];
        for(NSRunningApplication *runningApp in allRunningApps){
            if([runningApp.localizedName isEqualToString:appname]){
                return [runningApp terminate];
            }
            
        }

    }
    
    if (![self isAppRunning:appname]) {
        return TRUE;
    }
    
    return FALSE;
}
/*!

 @brief This method is used to get the process ID of the given application if it is running on the system.

 @param appname is the name of the application.

 @return (pid_t) the value is the process ID if the app is running and 0 if not.

 @remark This method is used to get the process ID of the given application if it is running on the system.

 */
-(pid_t)getPid:(NSString *)appname
{
    if ([self isAppRunning:appname]) {
        NSArray* allRunningApps = [[NSWorkspace sharedWorkspace]runningApplications];
        
        for(NSRunningApplication *runningApp in allRunningApps){
            if([runningApp.localizedName isEqualToString:appname])
                return runningApp.processIdentifier;
        }
    }
    return 0;
}
/*!

 @brief This method is used to get the screen resolution of the system.

 @param none.

 @return (NSString *) the value is the screen resolution of the system.

 @remark This method is used to get the screen resolution of the system.

 */
-(NSString *)getScreenResolution
{
    NSScreen *myMainScreen = [NSScreen mainScreen];
    
    float height = [myMainScreen frame].size.height;
    float width = [myMainScreen frame].size.width;
    
    NSString *resolution = [NSString stringWithFormat:@"%fX%f", width, height];
    
    return resolution;
}
/*!

 @brief This method is used to get the screen shot of the current screen.

 @param none.

 @return (CGImageRef) the screen shot of the current screen.

 @remark This method is used to get the screen shot of the current screen.

 */
-(CGImageRef)getScreenShot
{
    CGImageRef screenShot = CGWindowListCreateImage(CGRectInfinite, kCGWindowListOptionOnScreenOnly, kCGNullWindowID, kCGWindowImageDefault);
    
    return screenShot;
}
/*!

 @brief This method is used to bring the given application to the fornt.

 @param appname is the name of the application.

 @return (BOOL) the value YES if the app is running and NO if not.

 @remark This method is used to bring the given application to the fornt.

 */
-(BOOL)bringAppToFront:(NSString *)appname
{
    /*tell application "System Events"
     tell application appname
     activate
     end tell
     end tell*/
    
    NSDictionary* error;
    NSString* appleScriptInput = [[NSString alloc]initWithFormat:@"set appname to \"%@\" \n tell application \"System Events\" \n tell application appname \n activate \n end tell \n end tell \n", appname];
    
    
    if(appname != NULL){
        NSAppleScript *scriptObject = [[NSAppleScript alloc]initWithSource:appleScriptInput];
        sleep(1);
        [scriptObject executeAndReturnError:&error];
    }
    
    return [self isAppRunning:appname];
}
/*!

 @brief This method is used to wait for the given application for a given time to be ready to respond.

 @param maxseconds is the int value for the maximum time of wait ; appname is the name of the application.

 @return (BOOL) the value YES if the app is ready and NO if not.

 @remark This method is used to wait for the given application for a given time to be ready to respond.

 */
-(BOOL)wait:(int)maxseconds ForAppReady:(NSString *)appname
{
    int searchTimeOut = maxseconds;
    while (searchTimeOut > 0) {
        if ([self isAppReady:appname]) {
            return TRUE;
        }
        searchTimeOut--;
    }
    return NO;
}
@end
