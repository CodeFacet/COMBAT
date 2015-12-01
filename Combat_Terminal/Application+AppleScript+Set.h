//
//  Application+AppleScript+Set.h
//  
/*!
@author Piyush Bansal (piyush2508@gmail.com), Gopi Krishna Rajoju (gopirajoju@live.com) and Sakshi Goyal (sakshigoyal369@gmail.com)

@date 04/07/14

@brief This class shows the interactivity between the Application under test and applescript to perform actions on UI controls based on their control type

@copyright Copyright (c) 2015, The Combat authors - Piyush Bansal, Gopi Krishna Rajoju and Sakshi Goyal. All rights reserved.

Redistribution is not permitted. Use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Use of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

Use in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the derived product.

The names of its contributors must not be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#import <Foundation/Foundation.h>

@interface Application_AppleScript_Set : NSObject

-(NSString*) clickAppMenu:(NSString*) appname andMenuPath:(NSArray*) menuoptions;
-(NSString*) clickOnPopUpButton:(NSString*) appname forControl:(NSDictionary*) controlConditions andMenuOption:(NSString*) thisValue;
-(NSString*) selectOptionFromComboBox : (NSString*) appname forControl:(NSDictionary*) controlConditions andMenuOption:(NSString*) thisValue;
-(NSString*) setOptionValuetoComboBox : (NSString*) appname forControl:(NSDictionary*) controlConditions andMenuOption:(NSString*) thisValue;
-(NSString*) clickUIControl : (NSString*) appname forControl:(NSDictionary*) controlConditions;
-(NSString*) checkCheckBox : (NSString*) appname forControl:(NSDictionary*) controlConditions;
-(NSString*) uncheckCheckBox : (NSString*) appname forControl:(NSDictionary*) controlConditions;
-(NSString*) editTextField : (NSString*) appname forControl:(NSDictionary*) controlConditions andMenuOption:(NSString*) thisValue;
-(NSString*) tickUntickAppMenu:(NSString *)appname andMenuPath:(NSArray *)menuoptions andTickUntick: (NSString *) tickUntickMenuOption;


@end
