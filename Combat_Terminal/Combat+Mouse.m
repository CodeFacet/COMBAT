/*!
 @author Piyush Bansal (piyush2508@gmail.com), Gopi Krishna Rajoju (gopirajoju@live.com) and Sakshi Goyal (sakshigoyal369@gmail.com)
 
 @date 04/07/14
 
 @brief Combat:Combat+Mouse.m
 
 @copyright : Copyright (c) 2015, The Combat authors - Piyush Bansal, Gopi Krishna Rajoju and Sakshi Goyal. All rights reserved. Redistribution is not permitted. Use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 Use of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Use in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the derived product.
 The names of its contributors must not be used to endorse or promote products derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
#import "Combat+Mouse.h"

@implementation Combat_Mouse

-(void)copyCliClickToTempFolder
{
    /*
     rgkrishna : as the file can not be executed from app bundle, the same would be copied
     to local folder before executing, copied file also needs to be converted to executable
     file by changing its permissions.
     as this routien is added in Server Start action, it will be executed only once.
     If file already exists then it should use the existing file from temporary directory.
     */
    
    NSString *clickClickPath = [[NSBundle mainBundle] pathForResource:@"cliclick" ofType:@"" ];
    NSString *newclickClickPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"cliclick"];
    
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:newclickClickPath] == NO)
    {
        [fileManager copyItemAtPath:clickClickPath toPath:newclickClickPath error:&error];
        NSDictionary *attributes = nil;
        NSNumber *permissions;
        permissions = [NSNumber numberWithUnsignedLong: 493];
        attributes = [NSDictionary dictionaryWithObject:permissions forKey:NSFilePosixPermissions];
        [fileManager setAttributes:attributes ofItemAtPath:newclickClickPath error:nil];
    }
    [fileManager release];
}

/*!
 @brief Click on control with size and at position
 @param (NSPoint)controlposition - position of control (Top-Left-->x,y)
 (NSSize) controlsize - size(w,h) of control
 @return (BOOL)
 */
-(NSString *)clickOnControl:(NSPoint)controlposition andSize:(NSSize) controlsize
{
    NSString *clickClickPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"cliclick"];
    NSTask *mouseOpTask = [[NSTask alloc]init];
    [mouseOpTask setLaunchPath :  clickClickPath];

    float x = controlposition.x + (controlsize.width/2);
    float y = controlposition.y + (controlsize.height/2);
    NSString *argument2 = [NSString stringWithFormat:@"w:10"];
    NSString *argument = [NSString stringWithFormat:@"c:%f,%f",x , y];
    
    NSArray *arguments = [NSArray arrayWithObjects:argument2, argument, nil];
    [mouseOpTask setArguments:arguments];
    
    NSPipe *ioPipe = [NSPipe pipe];
    [mouseOpTask setStandardOutput:ioPipe];
    //NSString * res = NULL;
    
    NSPipe *pipe= [NSPipe pipe];
    [mouseOpTask setStandardOutput:pipe];
    NSFileHandle *file = [pipe fileHandleForReading];
    [mouseOpTask launch];
    NSData *data = [file readDataToEndOfFile];
    NSString *respponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", respponse);
    //[mouseOpTask waitUntilExit];
    //int status= [mouseOpTask terminationStatus];
    [mouseOpTask release];
    //if (status == 1) {
    //    res= @"1";
    //}
    //else
    //    res= @"0";
    return respponse;
}

/*!
 @brief Click on screen at position
 @param (NSPoint)screenpoint - position of screen (x,y)
 @return (BOOL)
 */
-(NSString *)clickOnScreen:(NSPoint)screenpoint
{
    NSString *clickClickPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"cliclick"];

    NSTask *mouseOpTask = [[NSTask alloc]init];
    [mouseOpTask setLaunchPath :  clickClickPath];

    NSString *argument2 = [NSString stringWithFormat:@"w:100"];
    NSString *argument = [NSString stringWithFormat:@"c:%f,%f", screenpoint.x, screenpoint.y];
    
    NSArray *arguments = [NSArray arrayWithObjects:argument2, argument, nil];
    [mouseOpTask setArguments:arguments];
    
    NSPipe *ioPipe = [NSPipe pipe];
    [mouseOpTask setStandardOutput:ioPipe];
    
    NSString * res= @"1";
    [mouseOpTask launch];
    [mouseOpTask release];
    return res;
}

/*!
 @brief Double-Click on screem at position
 @param (NSPoint)screenpoint - position of screen (x,y)
 @return (void)
 */
-(void)doubleClickOnScreenPoint:(NSPoint)screenpoint
{
    NSString *clickClickPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"cliclick"];
    NSTask *mouseOpTask = [[NSTask alloc]init];
    [mouseOpTask setLaunchPath :  clickClickPath];

    NSString *argument2 = [NSString stringWithFormat:@"w:500"];
    NSString *argument = [NSString stringWithFormat:@"dc:%f,%f", screenpoint.x, screenpoint.y];
    
    NSArray *arguments = [NSArray arrayWithObjects:argument2, argument, nil];
    [mouseOpTask setArguments:arguments];
    
    NSPipe *ioPipe = [NSPipe pipe];
    [mouseOpTask setStandardOutput:ioPipe];
    
    [mouseOpTask launch];
    
    [mouseOpTask release];
}

/*!
 @brief Click and keep pressing on screen at position
 @param (NSPoint)screenpoint - position of screen (x,y)
 @return (NSString *)
 */
-(NSString *)clickandKeepPressingOnScreen:(NSPoint)screenpoint
{
    NSString *clickClickPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"cliclick"];
    NSTask *mouseOpTask = [[NSTask alloc]init];
    [mouseOpTask setLaunchPath :  clickClickPath];

    NSString *argument2 = [NSString stringWithFormat:@"w:50"];
    NSString *argument = [NSString stringWithFormat:@"dd:%f,%f", screenpoint.x, screenpoint.y];
    
    NSArray *arguments = [NSArray arrayWithObjects:argument2, argument, nil];
    [mouseOpTask setArguments:arguments];
    
    NSPipe *ioPipe = [NSPipe pipe];
    [mouseOpTask setStandardOutput:ioPipe];
    NSString * res= @"1";
    [mouseOpTask launch];
    [mouseOpTask release];
    return res;
}

/*!
 @brief move cursor on screen at position
 @param (NSPoint)screenpoint - position of screen (x,y)
 @return (NSString *)
 */
-(NSString *)moveCursor:(NSPoint)screenpoint
{
    NSString *clickClickPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"cliclick"];
    NSTask *mouseOpTask = [[NSTask alloc]init];
    [mouseOpTask setLaunchPath :  clickClickPath];

    NSString *argument2 = [NSString stringWithFormat:@"w:500"];
    NSString *argument = [NSString stringWithFormat:@"m:%f,%f", screenpoint.x, screenpoint.y];
    
    NSArray *arguments = [NSArray arrayWithObjects:argument2, argument, nil];
    [mouseOpTask setArguments:arguments];
    
    NSPipe *ioPipe = [NSPipe pipe];
    [mouseOpTask setStandardOutput:ioPipe];
    NSString * res= @"1";
    [mouseOpTask launch];
    [mouseOpTask release];
    return res;
}

/*!
 @brief click, drag & release cursor on screen from current to position
 @param (NSPoint)screenpoint - position of screen (x,y)
 @return (NSString *)
 */
-(NSString *)dragAndRelease:(NSPoint)screenpoint
{
    NSString *clickClickPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"cliclick"];
    NSTask *mouseOpTask = [[NSTask alloc]init];
    [mouseOpTask setLaunchPath :  clickClickPath];

    NSString *argument2 = [NSString stringWithFormat:@"w:50"];
    NSString *argument = [NSString stringWithFormat:@"du:%f,%f", screenpoint.x, screenpoint.y];
    
    NSArray *arguments = [NSArray arrayWithObjects:argument2, argument, nil];
    [mouseOpTask setArguments:arguments];
    
    NSPipe *ioPipe = [NSPipe pipe];
    [mouseOpTask setStandardOutput:ioPipe];
    
    NSString * res= @"1";
    [mouseOpTask launch];
    [mouseOpTask release];
    return res;
}

/*!
 @brief click, drag & release cursor on screen from position1 to position2
 @param (NSPoint)screenpoint1 - starting position on screen (x,y)
 (NSPoint)screenpoint2 - ending position on screen (x,y)
 @return (NSString *)
 */
-(NSString *)click:(NSPoint)screenpoint1 dragAndRelease:(NSPoint)screenpoint2
{
    
    NSString * response=[self clickandKeepPressingOnScreen:screenpoint1];
    if ([response isEqualToString:@"1"]) {
        [self dragAndRelease:screenpoint2];
    }
    [self dragAndRelease:screenpoint2];
    NSString * res= @"Done with click drag release";
    return res;
}
@end
