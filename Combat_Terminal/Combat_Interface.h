/*!
 @author Piyush Bansal (piyush2508@gmail.com), Gopi Krishna Rajoju (gopirajoju@live.com) and Sakshi Goyal (sakshigoyal369@gmail.com)
 
 @date 04/07/14
 
 @brief Combat:CombatInterface.h
 
 @copyright : Copyright (c) 2015, The Combat authors - Piyush Bansal, Gopi Krishna Rajoju and Sakshi Goyal. All rights reserved. Redistribution is not permitted. Use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 Use of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Use in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the derived product.
 The names of its contributors must not be used to endorse or promote products derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <Foundation/Foundation.h>

@class Utilities,Control_Get,Control_Set, Application_AppleScript_Set, Application_Search, Application_Set, SystemManager, System_Application, NSString, Combat_Mouse, Combat_Keyboard, Application_Get;

@interface CombatInterface : NSObject{
    SystemManager *_systemManager;
    System_Application *_system_Application;
    Application_Search *_application_Search;
    Application_Get *_application_Get;
    Control_Set *_control_Set;
    Control_Get *_control_Get;
    Utilities *utilities;
    Combat_Mouse *_combat_Mouse;
    Combat_Keyboard *_combat_Keyboard;
    Application_AppleScript_Set *_application_AppleScript_Set;
}

+(CombatInterface *)getInstance;
+(void) destroyInstance;

-(NSString*)      launchApp:(NSString*)appname;
-(NSString*)      checkIfAppReady:(NSString*)appname;
-(NSString*)      waitForAppReady:(NSString*)appname;
-(NSString*)      quitApp:(NSString*)appname;
-(NSData*)      getScreenShot;
-(NSString *)     checkIfFileExists: (NSString *)filepath;
-(NSString *)     removeExistingFile: (NSString *)filepath;
-(NSString *)     checkIfFileLocked: (NSString *)filepath;
-(NSString *)     copyFilefrom: (NSString *)filepath to: (NSString *)destinationpath;
-(NSData*)      getControlSnip:(NSString*)appname and:(NSDictionary*)uielementConditions and:(NSDictionary*)windowConditions;
-(NSString*)      setUIelement:(NSString*)appname and:(NSDictionary*)uielementConditions and:(NSDictionary*)windowConditions and:(NSString*)attributeName and:(NSString*)attributeValue;
-(NSString*)      clickUIelement:(NSString*)appname and:(NSDictionary*)uielementConditions and:(NSDictionary*)windowConditions;
-(NSString*)      checkCheckBox:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions;
-(NSString *)     uncheckCheckBox:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions;
-(NSString*)      clickDecrementButton:(NSString*)appname and:(NSDictionary*)uielementConditions and:(NSDictionary*)windowConditions;
-(NSString*)      clickIncrementButton:(NSString*)appname and:(NSDictionary*)uielementConditions and:(NSDictionary*)windowConditions;
-(NSString*)      clickOnScreenPoint:(NSPoint) screenpoint;
-(NSString*)      selectAppMenuOption:(NSString*)appname and:(NSArray*) menuoptions;
-(NSString*)      selectPopUpMenuOption:(NSString*) appname and:(NSDictionary*)uielementConditions and:(NSDictionary*)windowConditions and:(NSString*) menuOption;
-(NSString*)      clickComboBoxButton:(NSString*) appname and:(NSDictionary*)uielementConditions and:(NSDictionary*)windowConditions and:(NSString*) menuOption;
-(NSString*)      clickUIControl:(NSString*) appname and:(NSDictionary*)uielementConditions;
-(NSString*)      typeText:(NSString*)text;
-(NSString*)      typeTextWithModifier:(NSString *)text and:(NSString *)modifierKeys;
-(NSString*)      typeSpecial:(NSString*)specialKey;
-(NSString*)      clickDragRelease:(NSPoint)begin and:(NSPoint)end;
-(NSString*)      getUIelementInfo:(NSString*) appname and:(NSDictionary*)uielementConditions and:(NSDictionary*)windowConditions;
-(NSString*)      getUIElementLineage:(NSString*) appname and:(NSDictionary*)uielementConditions and:(NSDictionary*)windowConditions;
-(NSString*)      getUIelementAttributes:(NSString*) appname and:(NSDictionary*)uielementConditions and:(NSDictionary*)windowConditions;
-(NSString*)      getuielementDescendants:(NSString*) appname and:(NSDictionary*)uielementConditions and:(NSDictionary*)windowConditions;
-(NSString*)      isUIelementSettable:(NSString*) appname and:(NSDictionary*)uielementConditions and:(NSDictionary*)windowConditions and:(NSString*) attributeName;
-(NSString*)      verifyUIelement:(NSString*) appname and:(NSDictionary*)uielementConditions and:(NSDictionary*)windowConditions and:(NSString*)attributeName and:(NSString*)expectedValue;
-(NSString *)      verifyUIelement1:(NSString*) appname and:(NSDictionary*)uielementConditions and:(NSDictionary*)windowConditions and:(NSString*)attributeName and:(NSString*)expectedValue;
-(NSString *)     hoverOverMenu:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions;
/*TODO*/
-(NSString*)      selectControlMenuOption:(NSString*) appname and:(NSDictionary*)uielementConditions and:(NSDictionary*)windowConditions and:(NSString*) menuOption;
-(NSString*)      selectContextMenuOption:(NSString*) appname and:(NSArray*) menuoptions;
-(NSString *)     clickTableListItem:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions;
-(NSString *)     checkIfUIElementExists:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions;

-(NSString *)     selectOptionFromComboBox:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions and:(NSString *)menuOption;
-(NSString *)     setOptionValuetoComboBox:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSDictionary *)windowConditions and:(NSString *)menuOption;
-(NSString*)      checkCheckBox:(NSString*) appname and:(NSDictionary*)uielementConditions;
-(NSString*)      uncheckCheckBox:(NSString*) appname and:(NSDictionary*)uielementConditions;
-(NSString *)     editTextField:(NSString *)appname and:(NSDictionary *)uielementConditions and:(NSString *)option;
-(NSString *)     tickuntickmenuoption:(NSString *)appname and:(NSArray *)menuoptions and:(NSString *)tickUntickMenuOption;
-(NSDate *)logDate;


@end
