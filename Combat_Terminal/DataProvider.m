/*!
 @author Piyush Bansal (piyush2508@gmail.com), Gopi Krishna Rajoju (gopirajoju@live.com) and Sakshi Goyal (sakshigoyal369@gmail.com)
 
 @date 04/07/14
 
 @brief Combat:DataProvider.m
 
 @copyright : Copyright (c) 2015, The Combat authors - Piyush Bansal, Gopi Krishna Rajoju and Sakshi Goyal. All rights reserved. Redistribution is not permitted. Use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 Use of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Use in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the derived product.
 The names of its contributors must not be used to endorse or promote products derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
#import "DataProvider.h"
#import "Combat_Interface.h"

@implementation DataProvider

/*!
 @brief Accepts Input query to be executed
 @param  (NSString*)step_query - of the format 'op=clickuielement&appname=Calculator&controlidentifier=_NS:120 or op=launchapp&appname=Calculator'
 @return (NSString *)
 */
- (NSString*)query:(NSString*)step_query{
    NSDictionary *paramCollection = [self getParamCollectionfromQuery:step_query];
    
    return [self channelMapper:paramCollection];
}

-(NSString*)channelMapper:(NSDictionary*) paramCollection{
    NSString *response;

    CombatInterface *combatInterface2 = [[CombatInterface alloc]init];
    
    NSString* op = [paramCollection valueForKey:@"op"];
    int opCode = [self channelCodeForOpValue:op];
    
    switch (opCode) {
        case 0: //launchapp
        {
            response = [combatInterface2 launchApp:[paramCollection valueForKey:@"appname"]];
            break;
        }
        case 1: //checkifappready
        {
            response = [combatInterface2 checkIfAppReady:[paramCollection valueForKey:@"appname"]];
            break;
        }
        case 2: //waitforappready
        {
            response = [combatInterface2 waitForAppReady:[paramCollection valueForKey:@"appname"]];
            break;
        }
        case 3: //quitapp
        {
            response = [combatInterface2 quitApp:[paramCollection valueForKey:@"appname"]];
            break;
        }
        case 4: //getscreenshot
        {
            response = [combatInterface2 getScreenShot];
            break;
        }
        case 5: //getcontrolsnip
        {
            NSString *controldescription = [paramCollection valueForKey:@"controldescription"];
            NSString *controlidentifier = [paramCollection valueForKey:@"controlidentifier"];
            NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
            if (controldescription != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXDescription";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 getControlSnip:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions];
                
            }
            else if (controlidentifier != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXIdentifier";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 getControlSnip:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions];
                
            }
            else{
                NSDictionary *controlconditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"uielementinfo"]];
                response = [combatInterface2 getControlSnip:[paramCollection valueForKey:@"appname"] and:controlconditions and:windowConditions];
            }
            
            break;
        }
        case 6: //setuielement
        {
            NSString *controldescription = [paramCollection valueForKey:@"controldescription"];
            NSString *controlidentifier = [paramCollection valueForKey:@"controlidentifier"];
            NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
            if (controldescription != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXDescription";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 setUIelement:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions and:[paramCollection valueForKey:@"attributename"] and:[paramCollection valueForKey:@"attributevalue"]];
                
            }
            else if (controlidentifier != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXIdentifier";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 setUIelement:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions and:[paramCollection valueForKey:@"attributename"] and:[paramCollection valueForKey:@"attributevalue"]];
                
            }
            else{
                NSDictionary *controlconditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"uielementinfo"]];
                
                response = [combatInterface2 setUIelement:[paramCollection valueForKey:@"appname"] and:controlconditions and:windowConditions and:[paramCollection valueForKey:@"attributename"] and:[paramCollection valueForKey:@"attributevalue"]];
            }
            
            
            break;
        }
        case 7: //clickuielement
        {
            NSLog(@"this click ui element");
            [self logDate];
            NSString *controldescription = [paramCollection valueForKey:@"controldescription"];
            NSString *controlidentifier = [paramCollection valueForKey:@"controlidentifier"];
            NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
            if (controldescription != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXDescription";
                [conditions setValue:controldescription forKey:key];
                //response = [combatInterface2 clickUIelement:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions];
                response = [combatInterface2 clickUIControl:[paramCollection valueForKey:@"appname"] and:conditions];
            }
            else if (controlidentifier != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXIdentifier";
                [conditions setValue:controlidentifier forKey:key];
                //response = [combatInterface2 clickUIelement:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions];
                response = [combatInterface2 clickUIControl:[paramCollection valueForKey:@"appname"] and:conditions];
                
            }
            else{
                NSDictionary *controlconditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"uielementinfo"]];
                
                response = [combatInterface2 clickUIelement:[paramCollection valueForKey:@"appname"] and:controlconditions and:windowConditions];
                
            }
            [self logDate];
            break;
        }
        case 8: //clickscreenpoint
        {
            NSPoint p1;
            p1.x = [[paramCollection valueForKey:@"x1"] floatValue];
            p1.y = [[paramCollection valueForKey:@"y1"] floatValue];
            
            response = [combatInterface2 clickOnScreenPoint:p1];
            break;
        }
        case 9: //selectappmenuoption
        {
            NSLog(@"this is app menu");
            [self logDate];
            NSString *appname = [paramCollection valueForKey:@"appname"];
            NSArray *menuOptions = [[paramCollection valueForKey:@"menuarray"] componentsSeparatedByString:@","];
            
            response = [combatInterface2 selectAppMenuOption:appname and:menuOptions];
            [self logDate];
            break;
        }
        case 10: //selectcontrolmenuoption
        {
            break;
        }
        case 11: //selectcontextmenuoption
        {
            break;
        }
        case 12: //selectpopupmenuoption
        {
            NSLog(@"this is pop up");
            [self logDate];
            NSString *appname = [paramCollection valueForKey:@"appname"];
            NSString *menuoption = [paramCollection valueForKey:@"menuoption"];
            NSString *controldescription = [paramCollection valueForKey:@"controldescription"];
            NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
            if (controldescription != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXDescription";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 clickUIelement:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions];
                response = [combatInterface2 selectPopUpMenuOption:appname and:conditions and:windowConditions and:menuoption];
            }
            else{
                NSDictionary *controlconditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"uielementinfo"]];
                
                response = [combatInterface2 selectPopUpMenuOption:appname and:controlconditions and:windowConditions and:menuoption];
            }
            
            [self logDate];
            break;
        }
        case 13: //typetext
        {
            [self logDate];
            response = [combatInterface2 typeText:[paramCollection valueForKey:@"text"]];
            [self logDate];
            break;
        }
        case 14: //typetextwithmodifier
        {
            NSString *text = [paramCollection valueForKey:@"text"];
            NSString *modifierkeys = [paramCollection valueForKey:@"modifierarray"];
            
            response = [combatInterface2 typeTextWithModifier:text and:modifierkeys];
            break;
        }
        case 15: //typespecial
        {
            response = [combatInterface2 typeSpecial:[paramCollection valueForKey:@"specialkey"]];
            break;
        }
        case 16: //clickdragrelease
        {
            NSLog(@"this is drag release");
            [self logDate];
            NSPoint p1,p2;
            p1.x = [[paramCollection valueForKey:@"x1"] floatValue];
            p1.y = [[paramCollection valueForKey:@"y1"] floatValue];
            p2.x = [[paramCollection valueForKey:@"x2"] floatValue];
            p2.y = [[paramCollection valueForKey:@"y2"] floatValue];
            
            response = [combatInterface2 clickDragRelease:p1 and:p2];
            [self logDate];
            break;
        }
        case 17: //getuielementinfo
        {
            NSString *controldescription = [paramCollection valueForKey:@"controldescription"];
            NSString *controlidentifier = [paramCollection valueForKey:@"controlidentifier"];
            NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
            if (controldescription != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXDescription";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 getUIelementInfo:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions];
                
            }
            else if (controlidentifier != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXIdentifier";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 getUIelementInfo:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions];
            }
            else{
                NSDictionary *controlconditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"uielementinfo"]];
                
                response = [combatInterface2 getUIelementInfo:[paramCollection valueForKey:@"appname"] and:controlconditions and:windowConditions];
            }
            break;
        }
        case 18: //getuielementlineage
        {
            NSString *controldescription = [paramCollection valueForKey:@"controldescription"];
            NSString *controlidentifier = [paramCollection valueForKey:@"controlidentifier"];
            NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
            if (controldescription != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXDescription";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 getUIElementLineage:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions];
                
            }
            else if (controlidentifier != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXIdentifier";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 getUIElementLineage:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions];
                
            }
            else{
                NSDictionary *controlconditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"uielementinfo"]];
                
                response = [combatInterface2 getUIElementLineage:[paramCollection valueForKey:@"appname"] and:controlconditions and:windowConditions];
            }
            break;
        }
        case 19: //getuielementattributes
        {
            NSString *controldescription = [paramCollection valueForKey:@"controldescription"];
            NSString *controlidentifier = [paramCollection valueForKey:@"controlidentifier"];
            NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
            if (controldescription != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXDescription";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 getUIelementAttributes:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions];
                
            }
            else if (controlidentifier != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXIdentifier";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 getUIelementAttributes:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions];
                
            }
            else{
                NSDictionary *controlconditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"uielementinfo"]];
                
                response = [combatInterface2 getUIelementAttributes:[paramCollection valueForKey:@"appname"] and:controlconditions and:windowConditions];
            }
            
            
            break;
        }
        case 20: //getuielementdescendants
        {
            NSString *controldescription = [paramCollection valueForKey:@"controldescription"];
            NSString *controlidentifier = [paramCollection valueForKey:@"controlidentifier"];
            NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
            if (controldescription != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXDescription";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 getuielementDescendants:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions];
                
                
            }
            else if (controlidentifier != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXIdentifier";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 getuielementDescendants:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions];
                
                
            }
            else{
                NSDictionary *controlconditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"uielementinfo"]];
                
                response = [combatInterface2 getuielementDescendants:[paramCollection valueForKey:@"appname"] and:controlconditions and:windowConditions];
            }
            
            
            break;
        }
        case 21: //verifyuielement
        {
            NSString *controldescription = [paramCollection valueForKey:@"controldescription"];
            NSString *controlidentifier = [paramCollection valueForKey:@"controlidentifier"];
            NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
            if (controldescription != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXDescription";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 verifyUIelement:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions and:[paramCollection valueForKey:@"attributename"] and:[paramCollection valueForKey:@"attributevalue"]];
                
            }
            else if (controlidentifier != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXIdentifier";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 verifyUIelement:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions and:[paramCollection valueForKey:@"attributename"] and:[paramCollection valueForKey:@"attributevalue"]];
                
            }
            else{
                NSDictionary *controlconditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"uielementinfo"]];
                
                response = [combatInterface2 verifyUIelement:[paramCollection valueForKey:@"appname"] and:controlconditions and:windowConditions and:[paramCollection valueForKey:@"attributename"] and:[paramCollection valueForKey:@"attributevalue"]];
            }
            
            
            break;
        }
        case 22: //iselementattributesettable
        {
            NSString *controldescription = [paramCollection valueForKey:@"controldescription"];
            NSString *controlidentifier = [paramCollection valueForKey:@"controlidentifier"];
            NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
            if (controldescription != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXDescription";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 isUIelementSettable:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions and:[paramCollection valueForKey:@"attributename"]];
                
            }
            else if (controlidentifier != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXIdentifier";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 isUIelementSettable:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions and:[paramCollection valueForKey:@"attributename"]];
                
            }
            else{
                NSDictionary *controlconditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"uielementinfo"]];
                
                response = [combatInterface2 isUIelementSettable:[paramCollection valueForKey:@"appname"] and:controlconditions and:windowConditions and:[paramCollection valueForKey:@"attributename"]];
            }
            
            
            break;
        }
        case 23:  //clickincrementbutton
        {
            NSLog(@"this is increment");
            [self logDate];
            NSString *controldescription = [paramCollection valueForKey:@"controldescription"];
            NSString *controlidentifier = [paramCollection valueForKey:@"controlidentifier"];
            NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
            if (controldescription != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXDescription";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 clickIncrementButton:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions];
                
            }
            else if (controlidentifier != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXIdentifier";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 clickIncrementButton:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions];
                
            }
            else{
                NSDictionary *controlconditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"uielementinfo"]];
                
                response = [combatInterface2 clickIncrementButton:[paramCollection valueForKey:@"appname"] and:controlconditions and:windowConditions];
            }
            
            
            [self logDate];
            break;
        }
        case 24:  //clickdecrementbutton
        {
            NSLog(@"this is decrement");
            [self logDate];
            NSString *controldescription = [paramCollection valueForKey:@"controldescription"];
            NSString *controlidentifier = [paramCollection valueForKey:@"controlidentifier"];
            NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
            if (controldescription != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXDescription";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 clickDecrementButton:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions];
                
            }
            else if (controlidentifier != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXIdentifier";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 clickDecrementButton:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions];
                
            }
            else{
                NSDictionary *controlconditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"uielementinfo"]];
                
                response = [combatInterface2 clickDecrementButton:[paramCollection valueForKey:@"appname"] and:controlconditions and:windowConditions];
            }
            
            
            [self logDate];
            break;
        }
        case 25:  //clickcomboboxbutton
        {
            NSLog(@"this is combo box");
            [self logDate];
            NSString *controldescription = [paramCollection valueForKey:@"controldescription"];
            NSString *controlidentifier = [paramCollection valueForKey:@"controlidentifier"];
            NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
            if (controldescription != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXDescription";
                [conditions setValue:controldescription forKey:key];
                response=[combatInterface2 clickComboBoxButton:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions and:[paramCollection valueForKey:@"menuoption"]];
                
            }
            else if (controlidentifier != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXIdentifier";
                [conditions setValue:controldescription forKey:key];
                response=[combatInterface2 clickComboBoxButton:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions and:[paramCollection valueForKey:@"menuoption"]];
                
            }
            else{
                NSDictionary *controlconditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"uielementinfo"]];
                //NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
                response=[combatInterface2 clickComboBoxButton:[paramCollection valueForKey:@"appname"] and:controlconditions and:windowConditions and:[paramCollection valueForKey:@"menuoption"]];
            }
            [self logDate];
            break;
        }
        case 26: //checkcheckbox
        {
            NSLog(@"this is check box");
            [self logDate];
            NSString *controldescription = [paramCollection valueForKey:@"controldescription"];
            NSString *controlidentifier = [paramCollection valueForKey:@"controlidentifier"];
            NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
            if (controldescription != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXDescription";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 checkCheckBox:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions];
                
            }
            else if (controlidentifier != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXIdentifier";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 checkCheckBox:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions];
                
            }
            else{
                NSDictionary *controlconditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"uielementinfo"]];
                //NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
                
                response = [combatInterface2 checkCheckBox:[paramCollection valueForKey:@"appname"] and:controlconditions and:windowConditions];
            }
            [self logDate];
            break;
        }
        case 27: //createitem
        {
            break;
        }
        case 28://hoverovermenuoption
        {
            
            NSLog(@"this is app menu");
            [self logDate];
            NSString *appname = [paramCollection valueForKey:@"appname"];
            NSArray *menuOptions = [[paramCollection valueForKey:@"menuarray"] componentsSeparatedByString:@","];
            NSDictionary *controlconditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"uielementinfo"]];
            NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
            [combatInterface2 selectAppMenuOption:appname and:menuOptions];
            response=[combatInterface2 hoverOverMenu:[paramCollection valueForKey:@"appname"] and:controlconditions and:windowConditions];
            [self logDate];
            break;
            
        }
        case 29: //clicktablelistitem
        {
            NSString *controldescription = [paramCollection valueForKey:@"controldescription"];
            NSString *controlidentifier = [paramCollection valueForKey:@"controlidentifier"];
            NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
            if (controldescription != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXDescription";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 clickTableListItem:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions];
                
            }
            else if (controlidentifier != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXIdentifier";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 clickTableListItem:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions];
                
            }
            else{
                NSDictionary *controlconditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"uielementinfo"]];
                
                response = [combatInterface2 clickTableListItem:[paramCollection valueForKey:@"appname"] and:controlconditions and:windowConditions];
            }
            
            
            break;
        }
        case 30: //checkiffileexists
        {
            NSString *filepath = [paramCollection valueForKey:@"filepath"];
            
            response = [combatInterface2 checkIfFileExists:(NSString *)filepath];
            break;
        }
        case 31: //removeexistingfile
        {
            NSString *filepath = [paramCollection valueForKey:@"filepath"];
            
            response = [combatInterface2 removeExistingFile:(NSString *)filepath];
            break;
        }
        case 32: //copyfile
        {
            NSString *filepath = [paramCollection valueForKey:@"filepath"];
            NSString *destinationfilepath = [paramCollection valueForKey:@"destinationfilepath"];
            
            response = [combatInterface2 copyFilefrom:(NSString *) filepath to:(NSString *)destinationfilepath];
            break;
        }
        case 33: //checkiffilelocked
        {
            NSString *filepath = [paramCollection valueForKey:@"filepath"];
            response = [combatInterface2 checkIfFileLocked:(NSString *) filepath];
            break;
        }
        case 34: //checkifcontrolexists
        {
            NSString *controldescription = [paramCollection valueForKey:@"controldescription"];
            NSString *controlidentifier = [paramCollection valueForKey:@"controlidentifier"];
            NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
            if (controldescription != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXDescription";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 checkIfUIElementExists:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions];
                
            }
            else if (controlidentifier != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXIdentifier";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 checkIfUIElementExists:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions];
                
            }
            else{
                NSDictionary *controlconditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"uielementinfo"]];
                
                response = [combatInterface2 checkIfUIElementExists:[paramCollection valueForKey:@"appname"] and:controlconditions and:windowConditions];
            }
            
            
            break;
        }
        case 35:{
            //selectOptionFromComboBox
            
            NSLog(@"Case : selectOptionFromComboBox");
            [self logDate];
            NSString * appname = [paramCollection valueForKey:@"appname"];
            NSString *controldescription = [paramCollection valueForKey:@"controldescription"];
            NSString *controlidentifier = [paramCollection valueForKey:@"controlidentifier"];
            NSString *menuoption = [paramCollection valueForKey:@"option"];
            NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
            if (controldescription != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXDescription";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 selectOptionFromComboBox:appname and:conditions and:windowConditions and:menuoption];
                
            }
            else if (controlidentifier != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXIdentifier";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 selectOptionFromComboBox:appname and:conditions and:windowConditions and:menuoption];
                
            }
            else{
                NSDictionary *controlconditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"uielementinfo"]];
                response = [combatInterface2 selectOptionFromComboBox:appname and:controlconditions and:windowConditions and:menuoption];
            }
            [self logDate];
            break;
        }
        case 36:{
            //setOptionValuetoComboBox
            
            NSLog(@"Case : setOptionValuetoComboBox");
            [self logDate];
            
            NSString * appname = [paramCollection valueForKey:@"appname"];
            NSString *controldescription = [paramCollection valueForKey:@"controldescription"];
            NSString *controlidentifier = [paramCollection valueForKey:@"controlidentifier"];
            NSString *menuoption = [paramCollection valueForKey:@"option"];
            NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
            if (controldescription != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXDescription";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 setOptionValuetoComboBox:appname and:conditions and:windowConditions and:menuoption];
                
            }
            else if (controlidentifier != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXIdentifier";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 setOptionValuetoComboBox:appname and:conditions and:windowConditions and:menuoption];
                
            }
            else{
                NSDictionary *controlconditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"uielementinfo"]];
                
                response = [combatInterface2 setOptionValuetoComboBox:appname and:controlconditions and:windowConditions and:menuoption];
            }
            [self logDate];
            break;
        }
        case 37:{
            
            NSLog(@"Case : checkCheckBox");
            [self logDate];
            
            NSString *controldescription = [paramCollection valueForKey:@"controldescription"];
            NSString *controlidentifier = [paramCollection valueForKey:@"controlidentifier"];
            //NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
            if (controldescription != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXDescription";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 checkCheckBox:[paramCollection valueForKey:@"appname"] and:conditions];
                
            }
            else if (controlidentifier != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXIdentifier";
                [conditions setValue:controlidentifier forKey:key];
                response = [combatInterface2 checkCheckBox:[paramCollection valueForKey:@"appname"] and:conditions];
                
            }
            else{
                //NSString * error = @"ERROR : Please provide control search attributes as {controldescription or controlidentifier with its value}";
                //return error;
            }
            
            [self logDate];
            break;
        }
        case 38:{
            NSLog(@"Case : uncheckCheckBox");
            [self logDate];
            
            NSString *controldescription = [paramCollection valueForKey:@"controldescription"];
            NSString *controlidentifier = [paramCollection valueForKey:@"controlidentifier"];
            //NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
            if (controldescription != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXDescription";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 uncheckCheckBox:[paramCollection valueForKey:@"appname"] and:conditions];
                
            }
            else if (controlidentifier != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXIdentifier";
                [conditions setValue:controlidentifier forKey:key];
                response = [combatInterface2 uncheckCheckBox:[paramCollection valueForKey:@"appname"] and:conditions];
                
            }
            else{
                //NSString * error = @"ERROR : Please provide control search attributes as {controldescription or controlidentifier with its value}";
                //return error;
            }
            
            [self logDate];
            break;
        }
        case 39:{
            NSLog(@"Case : editTextField");
            [self logDate];
            
            NSString *controldescription = [paramCollection valueForKey:@"controldescription"];
            NSString *controlidentifier = [paramCollection valueForKey:@"controlidentifier"];
            //NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
            if (controldescription != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXDescription";
                [conditions setValue:controldescription forKey:key];
                
                response = [combatInterface2 editTextField:[paramCollection valueForKey:@"appname"] and:conditions and:[paramCollection valueForKey:@"option"]];
                
                
            }
            else if (controlidentifier != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXIdentifier";
                [conditions setValue:controlidentifier forKey:key];
                
                response = [combatInterface2 editTextField:[paramCollection valueForKey:@"appname"] and:conditions and:[paramCollection valueForKey:@"option"]];
                
            }
            else{
                //NSString * error = @"ERROR : Please provide control search attributes as {controldescription or controlidentifier with its value}";
                //return error;
            }
            
            [self logDate];
            break;
        }
        case 40:
        {
            NSLog(@"this is app menu tick");
            [self logDate];
            NSString *appname = [paramCollection valueForKey:@"appname"];
            NSArray *menuOptions = [[paramCollection valueForKey:@"menuarray"] componentsSeparatedByString:@","];
            
            response = [combatInterface2 tickuntickmenuoption:appname and:menuOptions and:@"tickmeuoption"];
            [self logDate];
            break;
        }
        case 41:
        {
            NSLog(@"this is app menu untick");
            [self logDate];
            NSString *appname = [paramCollection valueForKey:@"appname"];
            NSArray *menuOptions = [[paramCollection valueForKey:@"menuarray"] componentsSeparatedByString:@","];
            
            response = [combatInterface2 tickuntickmenuoption:appname and:menuOptions and:@"untickmeuoption"];
            [self logDate];
            break;
        }
        case 42: //uncheckcheckbox
        {
            NSLog(@"this is check box");
            [self logDate];
            NSString *controldescription = [paramCollection valueForKey:@"controldescription"];
            NSString *controlidentifier = [paramCollection valueForKey:@"controlidentifier"];
            NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
            if (controldescription != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXDescription";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 uncheckCheckBox:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions];
                
            }
            else if (controlidentifier != nil) {
                NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
                
                NSString* key = @"AXIdentifier";
                [conditions setValue:controldescription forKey:key];
                response = [combatInterface2 uncheckCheckBox:[paramCollection valueForKey:@"appname"] and:conditions and:windowConditions];
                
            }
            else{
                NSDictionary *controlconditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"uielementinfo"]];
                //NSDictionary *windowConditions = [self getDictionaryFromXmlInfo:[paramCollection valueForKey:@"windowinfo"]];
                
                response = [combatInterface2 uncheckCheckBox:[paramCollection valueForKey:@"appname"] and:controlconditions and:windowConditions];
            }
            [self logDate];
            break;
        }
        default:
            break;
    }
    return response;
}

-(int) channelCodeForOpValue:(NSString*) op
{
    int opCode = -1;
    NSMutableDictionary *opCodeDict = [[NSMutableDictionary alloc]init];
    [opCodeDict setValue:[NSNumber numberWithInt:0] forKey:@"launchapp"];
    [opCodeDict setValue:[NSNumber numberWithInt:1] forKey:@"checkifappready"];
    [opCodeDict setValue:[NSNumber numberWithInt:2] forKey:@"waitforappready"];
    [opCodeDict setValue:[NSNumber numberWithInt:3] forKey:@"quitapp"];
    [opCodeDict setValue:[NSNumber numberWithInt:4] forKey:@"getscreenshot"];
    [opCodeDict setValue:[NSNumber numberWithInt:5] forKey:@"getcontrolsnip"];
    [opCodeDict setValue:[NSNumber numberWithInt:6] forKey:@"setuielement"];
    [opCodeDict setValue:[NSNumber numberWithInt:7] forKey:@"clickuielement"];
    [opCodeDict setValue:[NSNumber numberWithInt:8] forKey:@"clickscreenpoint"];
    [opCodeDict setValue:[NSNumber numberWithInt:9] forKey:@"selectappmenuoption"];
    [opCodeDict setValue:[NSNumber numberWithInt:10] forKey:@"selectcontrolmenuoption"];
    [opCodeDict setValue:[NSNumber numberWithInt:11] forKey:@"selectcontextmenuoption"];
    [opCodeDict setValue:[NSNumber numberWithInt:12] forKey:@"selectpopupmenuoption"];
    [opCodeDict setValue:[NSNumber numberWithInt:13] forKey:@"typetext"];
    [opCodeDict setValue:[NSNumber numberWithInt:14] forKey:@"typetextwithmodifier"];
    [opCodeDict setValue:[NSNumber numberWithInt:15] forKey:@"typespecial"];
    [opCodeDict setValue:[NSNumber numberWithInt:16] forKey:@"clickdragrelease"];
    [opCodeDict setValue:[NSNumber numberWithInt:17] forKey:@"getuielementinfo"];
    [opCodeDict setValue:[NSNumber numberWithInt:18] forKey:@"getuielementlineage"];
    [opCodeDict setValue:[NSNumber numberWithInt:19] forKey:@"getuielementattributes"];
    [opCodeDict setValue:[NSNumber numberWithInt:20] forKey:@"getuielementdescendants"];
    [opCodeDict setValue:[NSNumber numberWithInt:21] forKey:@"verifyuielement"];
    [opCodeDict setValue:[NSNumber numberWithInt:22] forKey:@"iselementattributesettable"];
    [opCodeDict setValue:[NSNumber numberWithInt:23] forKey:@"clickincrementbutton"];
    [opCodeDict setValue:[NSNumber numberWithInt:24] forKey:@"clickdecrementbutton"];
    [opCodeDict setValue:[NSNumber numberWithInt:25] forKey:@"clickcomboboxbutton"];
    [opCodeDict setValue:[NSNumber numberWithInt:26] forKey:@"checkcheckbox"];
    [opCodeDict setValue:[NSNumber numberWithInt:27] forKey:@"createitem"];
    [opCodeDict setValue:[NSNumber numberWithInt:28] forKey:@"hoverovermenuoption"];
    [opCodeDict setValue:[NSNumber numberWithInt:29] forKey:@"clicktablelistitem"];
    [opCodeDict setValue:[NSNumber numberWithInt:30] forKey:@"checkiffileexists"];
    [opCodeDict setValue:[NSNumber numberWithInt:31] forKey:@"removeexistingfile"];
    [opCodeDict setValue:[NSNumber numberWithInt:32] forKey:@"copyfile"];
    [opCodeDict setValue:[NSNumber numberWithInt:33] forKey:@"checkiffilelocked"];
    [opCodeDict setValue:[NSNumber numberWithInt:34] forKey:@"checkifcontrolexists"];
    [opCodeDict setValue:[NSNumber numberWithInt:35] forKey:@"selectOptionFromComboBox"];
    [opCodeDict setValue:[NSNumber numberWithInt:36] forKey:@"setOptionValuetoComboBox"];
    [opCodeDict setValue:[NSNumber numberWithInt:37] forKey:@"checkCheckBox"];
    [opCodeDict setValue:[NSNumber numberWithInt:38] forKey:@"uncheckCheckBox"];
    [opCodeDict setValue:[NSNumber numberWithInt:39] forKey:@"edittextfield"];
    [opCodeDict setValue:[NSNumber numberWithInt:40] forKey:@"tickappmenuoption"];
    [opCodeDict setValue:[NSNumber numberWithInt:41] forKey:@"untickappmenuoption"];
    
    if([opCodeDict valueForKey:op])
        opCode = (int)[[opCodeDict valueForKey:op] integerValue];
    [opCodeDict release];
    return opCode;
}
-(void)logDate
{
    NSDate * now=[NSDate date];
    NSDateFormatter *outputFormatter=[[NSDateFormatter alloc]init];
    [outputFormatter setDateFormat:@"HH:mm:ss"];
    NSString *newdatestring=[outputFormatter stringFromDate:now];
    NSLog(@"time Stamp:%@",newdatestring);
    [outputFormatter release];
}

-(NSMutableDictionary*)getParamCollectionfromQuery:(NSString*)queryString
{
    NSMutableDictionary* paramCollection = [[NSMutableDictionary alloc]init];
    NSArray* arr = [queryString componentsSeparatedByString:@"&"];
    
    for (int i = 0; i < [arr count]; i++) {
        NSString* key = [[arr objectAtIndex:i] substringToIndex:[[arr objectAtIndex:i] rangeOfString:@"="].location];
        NSString* value = [[arr objectAtIndex:i] substringFromIndex:[[arr objectAtIndex:i] rangeOfString:@"="].location + 1];
        
        [paramCollection setValue:value forKey:key];
    }
    return paramCollection;
}

-(NSMutableDictionary*)getDictionaryFromXmlInfo:(NSString*)uielementInfo{
    uielementInfo = [uielementInfo stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    
    NSMutableDictionary* conditions = [[NSMutableDictionary alloc]init];
    
    if(uielementInfo.length < 5)
        return nil;
    
    NSError* error = [[NSError alloc]init];
    NSXMLDocument *xmlDoc = [[NSXMLDocument alloc]initWithXMLString:uielementInfo options:NSXMLDocumentTidyXML error:&error];
    NSArray* children = [[xmlDoc rootElement]children];
    
    
    NSXMLElement* element = [children objectAtIndex:0];
    if ([[element name] isEqualToString:@"properties"] && element != NULL) {
        NSArray*attributes = [element attributes];
        
        for(NSXMLNode *attribute in attributes){
            NSString* key = [attribute name];
            NSString* value = [attribute stringValue];
            
            [conditions setValue:value forKey:key];
        }
    }
    else if ([[element name] isEqualToString:@"propertie1"] && element != NULL) {
        NSArray*attributes = [element attributes];
        
        for(NSXMLNode *attribute in attributes){
            NSString* key = [attribute name];
            NSString* value = [attribute stringValue];
            
            [conditions setValue:value forKey:key];
        }
    }
    
    return conditions;
}

@end

#pragma marks CONSTS
const NSString *PARAMTYPEAPPNAME = @"appname";
const NSString *PARAMTYPEUIELEMENTINFO = @"uielementinfo";
const NSString *PARAMTYPEWINDOWINFO = @"windowinfo";
const NSString *PARAMTYPEATTRIBUTENAME = @"attributename";
const NSString *PARAMTYPEATTRIBUTEVALUE = @"attributevalue";
const NSString *PARAMTYPEMENUARRAY = @"menupath";
const NSString *PARAMTYPETEXTVALUE = @"text";
const NSString *PARAMTYPESPECIALKEY = @"specialkey";
const NSString *PARAMTYPEFILEPATH = @"filepath";
const NSString *PARAMTYPEDESTINATIONFILEPATH = @"destinationfilepath";
const NSString *PARAMCONTROLDESCRIPTION = @"controldescription";
const NSString *PARAMCONTROLIDENTIFIER = @"controlidentifier";


