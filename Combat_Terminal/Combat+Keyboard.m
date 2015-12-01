/*!
 @author Piyush Bansal (piyush2508@gmail.com), Gopi Krishna Rajoju (gopirajoju@live.com) and Sakshi Goyal (sakshigoyal369@gmail.com)
 
 @date 11/07/14
 
 @brief Combat:Combat+Keyboard.m
 
 @copyright : Copyright (c) 2015, The Combat authors - Piyush Bansal, Gopi Krishna Rajoju and Sakshi Goyal. All rights reserved. Redistribution is not permitted. Use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 Use of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Use in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the derived product.
 The names of its contributors must not be used to endorse or promote products derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
#import "Combat+Keyboard.h"

@implementation Combat_Keyboard

/*!
 @brief KeyIn operation
 @param (NSString *)text - text to be typed
 @return (NSString *)
 */
-(NSString *)keyIn:(NSString *)text
{
    //[NSThread sleepForTimeInterval:1.0];
    NSDictionary* error;
    NSString* appleScriptInput = [[NSString alloc]initWithFormat:@"tell application \"System Events\" to keystroke \"%@\"", text ];
    NSString * res;
    NSAppleEventDescriptor* returnDescriptor = NULL;
    NSAppleScript *scriptObject = [[NSAppleScript alloc]initWithSource:appleScriptInput];
    returnDescriptor = [scriptObject executeAndReturnError:&error];
    if (returnDescriptor != NULL) {
        res= @"Done Typing";    }
    else{
        res =@"Error Typing";
    }
    return res;

}

/*!
 @brief KeyIn operation - Special Characters
 @param (NSString *)text - text to be typed
 @return (NSString *)
 */
-(NSString *)specialKeyIn:(NSString *)specialKey
{
    //[NSThread sleepForTimeInterval:1.0];
    CGKeyCode keycode = [self keyCodeFormSpecialKeyString:specialKey];
    CGEventRef e1 = CGEventCreateKeyboardEvent(NULL, keycode, TRUE);
    CGEventPost(kCGSessionEventTap, e1);
    
    CGEventRef e2 = CGEventCreateKeyboardEvent(NULL, keycode, FALSE);
    CGEventPost(kCGSessionEventTap, e2);
    NSString * res=@"Done Typing";
    return res;
}

/*!
 @brief KeyIn operation with modifer key
 @param (NSString *)text - text to be typed
 (NSString *)modifierKeys - Modifier Keys (CTRL, CMD, ALT, SHIFT)
 @return (NSString *)
 */
-(NSString * )modifierKeyDown:(NSString *)modifierKeys
{
    NSArray *mkArray = [modifierKeys componentsSeparatedByString:@","];
    
    for (int i = 0; i < [mkArray count]; i++) {
        if ([[mkArray objectAtIndex:i] length] > 0) {
            
            CGKeyCode keycode = [self keyCodeFormSpecialKeyString: (NSString*)[mkArray objectAtIndex:i] ];
            CGEventRef e1 = CGEventCreateKeyboardEvent(NULL, keycode, TRUE);
            CGEventPost(kCGSessionEventTap, e1);
        }
    }
    NSString * res=@"Done Typing";
    return res;
}

/*!
 @brief Keyup operation of modifer key
 @param  (NSString *)modifierKeys - Modifier Keys (CTRL, CMD, ALT, SHIFT)
 @return (NSString *)
 */
-(NSString * )modifierKeyUp:(NSString *)modifierKeys
{
    NSArray *mkArray = [modifierKeys componentsSeparatedByString:@","];
    
    for (int i = 0; i < [mkArray count]; i++) {
        if ([[mkArray objectAtIndex:i] length] > 0) {
            

        CGKeyCode keycode = [self keyCodeFormSpecialKeyString: (NSString*)[mkArray objectAtIndex:i] ];
        CGEventRef e1 = CGEventCreateKeyboardEvent(NULL, keycode, FALSE);
        CGEventPost(kCGSessionEventTap, e1);
        }
    }
    NSString * res=@"Done Typing";
    return res;
}

-(NSString *)keyIn:(NSString *)text withModifiers:(NSString *)modifiers
{
    NSDictionary* error;
    CGKeyCode keycode = [self keyCodeFormSpecialKeyString: (NSString*)text];
    NSString* appleScriptInput = [[NSString alloc]initWithFormat:@"tell application \"System Events\" \n key code %hu using %@ \n end tell \n", keycode, modifiers];
    NSAppleScript *scriptObject = [[NSAppleScript alloc]initWithSource:appleScriptInput];
    [scriptObject executeAndReturnError:&error];
    NSString * res=@"Done Typing";
    return res;
    /*
    CGEventFlags flags = kCGEventFlagsChanged;
    CGEventRef ev;
    CGEventSourceRef source = CGEventSourceCreate (kCGEventSourceStateCombinedSessionState);
    //NSString * res1;
    for(NSString* modifierKey in modifiers)
    {
        CGKeyCode keycode = [self keyCodeFormSpecialKeyString: (NSString*)modifierKey];
        ev = CGEventCreateKeyboardEvent (source, keycode, true);
        CGEventSetFlags(ev,flags | CGEventGetFlags(ev)); //combine flags
        CGEventPost(kCGHIDEventTap,ev);
        //CFRelease(ev);
    }
    [NSThread sleepForTimeInterval:1.0];
    if((text != NULL))
        [self keyIn:text];
    [NSThread sleepForTimeInterval:1.0];
    for(NSString* modifierKey in modifiers)
    {
        CGKeyCode keycode = [self keyCodeFormSpecialKeyString: (NSString*)modifierKey];
        ev = CGEventCreateKeyboardEvent (source, keycode, false);
        CGEventSetFlags(ev,flags | CGEventGetFlags(ev)); //combine flags
        CGEventPost(kCGHIDEventTap,ev);
        //CFRelease(ev);
    }
     CFRelease(ev);
     CFRelease(source);
    NSString * res=@"Done Typing";
    return res;*/
}

-(CGKeyCode)keyCodeFormSpecialKeyString:(NSString*)keyString{
    keyString = [keyString uppercaseString];
    
    if ([keyString isEqualToString:@"RETURN"]) return 36;
    
    if ([keyString isEqualToString:@"F5"]) return 96;
    if ([keyString isEqualToString:@"F6"]) return 97;
    if ([keyString isEqualToString:@"F7"]) return 98;
    if ([keyString isEqualToString:@"F3"]) return 99;
    if ([keyString isEqualToString:@"F8"]) return 100;
    if ([keyString isEqualToString:@"F9"]) return 101;
    
    if ([keyString isEqualToString:@"F11"]) return 103;
    
    if ([keyString isEqualToString:@"F13"]) return 105;
    
    if ([keyString isEqualToString:@"F14"]) return 107;
    
    if ([keyString isEqualToString:@"F10"]) return 109;
    
    if ([keyString isEqualToString:@"F12"]) return 111;
    
    if ([keyString isEqualToString:@"F15"]) return 113;
    if ([keyString isEqualToString:@"HELP"]) return 114;
    if ([keyString isEqualToString:@"HOME"]) return 115;
    if ([keyString isEqualToString:@"PGUP"]) return 116;
    if ([keyString isEqualToString:@"FORWARDDELETE"]) return 117;
    if ([keyString isEqualToString:@"F4"]) return 118;
    if ([keyString isEqualToString:@"END"]) return 119;
    if ([keyString isEqualToString:@"F2"]) return 120;
    if ([keyString isEqualToString:@"PGDN"]) return 121;
    if ([keyString isEqualToString:@"F1"]) return 122;
    if ([keyString isEqualToString:@"LEFT"]) return 123;
    if ([keyString isEqualToString:@"RIGHT"]) return 124;
    if ([keyString isEqualToString:@"DOWN"]) return 125;
    if ([keyString isEqualToString:@"UP"]) return 126;
    if ([keyString isEqualToString:@"`"]) return 50;
    if ([keyString isEqualToString:@"DELETE"]) return 51;
    if ([keyString isEqualToString:@"ENTER"]) return 52;
    if ([keyString isEqualToString:@"ESCAPE"]) return 53;
    
    // some more missing codes abound, reserved I presume, but it would
    // have been helpful for Apple to have a document with them all listed
    
    if ([keyString isEqualToString:@"."]) return 65;
    
    if ([keyString isEqualToString:@"*"]) return 67;
    
    if ([keyString isEqualToString:@"+"]) return 69;
    
    if ([keyString isEqualToString:@"CLEAR"]) return 71;
    
    if ([keyString isEqualToString:@"/"]) return 75;
    if ([keyString isEqualToString:@"ENTER"]) return 76;  // numberpad on full kbd
    
    if ([keyString isEqualToString:@"="]) return 78;
    
    if ([keyString isEqualToString:@"."]) return 47;
    if ([keyString isEqualToString:@"TAB"]) return 48;
    if ([keyString isEqualToString:@"SPACE"]) return 49;
    
    
    if ([keyString isEqualToString:@"CTRL"]) return 59;
    if ([keyString isEqualToString:@"CMD"]) return 55;
    if ([keyString isEqualToString:@"ALT"]) return 58;
    if ([keyString isEqualToString:@"SHIFT"]) return 56;
    if ([keyString isEqualToString:@"FN"]) return 63;
    if ([keyString isEqualToString:@"0"]) return 29;
    if ([keyString isEqualToString:@"1"]) return 18;
    if ([keyString isEqualToString:@"2"]) return 19;
    if ([keyString isEqualToString:@"3"]) return 20;
    if ([keyString isEqualToString:@"4"]) return 21;
    if ([keyString isEqualToString:@"5"]) return 23;
    if ([keyString isEqualToString:@"6"]) return 22;
    if ([keyString isEqualToString:@"7"]) return 26;
    if ([keyString isEqualToString:@"8"]) return 28;
    if ([keyString isEqualToString:@"9"]) return 25;
    if ([keyString isEqualToString:@"A"]) return 0;
    if ([keyString isEqualToString:@"B"]) return 11;
    if ([keyString isEqualToString:@"C"]) return 8;
    if ([keyString isEqualToString:@"D"]) return 2;
    if ([keyString isEqualToString:@"E"]) return 14;
    if ([keyString isEqualToString:@"F"]) return 3;
    if ([keyString isEqualToString:@"G"]) return 5;
    if ([keyString isEqualToString:@"H"]) return 4;
    if ([keyString isEqualToString:@"I"]) return 34;
    if ([keyString isEqualToString:@"J"]) return 38;
    if ([keyString isEqualToString:@"K"]) return 40;
    if ([keyString isEqualToString:@"L"]) return 37;
    if ([keyString isEqualToString:@"M"]) return 46;
    if ([keyString isEqualToString:@"N"]) return 45;
    if ([keyString isEqualToString:@"O"]) return 31;
    if ([keyString isEqualToString:@"P"]) return 35;
    if ([keyString isEqualToString:@"Q"]) return 12;
    if ([keyString isEqualToString:@"R"]) return 15;
    if ([keyString isEqualToString:@"S"]) return 1;
    if ([keyString isEqualToString:@"T"]) return 17;
    if ([keyString isEqualToString:@"U"]) return 32;
    if ([keyString isEqualToString:@"V"]) return 9;
    if ([keyString isEqualToString:@"W"]) return 13;
    if ([keyString isEqualToString:@"X"]) return 7;
    if ([keyString isEqualToString:@"Y"]) return 16;
    if ([keyString isEqualToString:@"Z"]) return 6;
    
    return 0;
}

@end