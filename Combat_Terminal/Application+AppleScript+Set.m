//
//  Application+AppleScript+Set.m
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

#import "Application+AppleScript+Set.h"
#import "Control+Get.h"

@implementation Application_AppleScript_Set

/*!

 @brief This method is used to click the application's menus. It works for multiple layers in the menu heirarchy, menus->submenus->subsubmenus etc

 @param  appname is the application under test's name and menuoptions is the array of the menu options to be selected.

 @return (NSString*) The message "task is complete" from the applescript after its completion. 

 @remark This method is used to click on any permutation of menu options.

 */


-(NSString*) clickAppMenu:(NSString *)appname andMenuPath:(NSArray *)menuoptions {
    
    NSLog(@"Application_AppleScript_Set : clickAppMenu : entry");
    // let's see if removing thread sleep has any impact, if there is any issue then we will uncomment.
    //[NSThread sleepForTimeInterval:0.6];

    NSInteger arraycount = [menuoptions count];
    
    // load the script from a resource by fetching its URL from within our bundle
    NSString* path = [[NSBundle mainBundle] pathForResource:@"automation" ofType:@"applescript"];
    
    if (path != nil)
    {
        NSURL* url = [NSURL fileURLWithPath:path];
        if (url != nil)
        {
            NSError* error  = [NSError alloc];
            
            NSURL* url = [NSURL fileURLWithPath:path];
            
            NSMutableString* string = [[NSMutableString alloc] initWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];

            //[url release];
            
            if (string != nil) {
                
                if(arraycount <= 1) {
                    [string replaceOccurrencesOfString:@"var_ myfunctionname" withString:@"clickmeuoption1" options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_appname" withString:appname options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_option1" withString:[menuoptions objectAtIndex:0] options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                }
                else if (arraycount == 2) {
                    [string replaceOccurrencesOfString:@"var_ myfunctionname" withString:@"clickmeuoption2" options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_appname" withString:appname options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_option1" withString:[menuoptions objectAtIndex:0] options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_option2" withString:[menuoptions objectAtIndex:1] options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                }
                else if (arraycount == 3) {
                    [string replaceOccurrencesOfString:@"var_ myfunctionname" withString:@"clickmeuoption3" options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_appname" withString:appname options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_option1" withString:[menuoptions objectAtIndex:0] options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_option2" withString:[menuoptions objectAtIndex:1] options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_option3" withString:[menuoptions objectAtIndex:2] options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                }
                else if (arraycount == 4) {
                    [string replaceOccurrencesOfString:@"var_ myfunctionname" withString:@"clickmeuoption4" options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_appname" withString:appname options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_option1" withString:[menuoptions objectAtIndex:0] options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_option2" withString:[menuoptions objectAtIndex:1] options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_option3" withString:[menuoptions objectAtIndex:2] options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_option4" withString:[menuoptions objectAtIndex:3] options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                }
                else{
                    return @"ERROR : Menu Count is greater than 4 is invalid!";
                }
                
                NSAppleScript* appleScript = [[NSAppleScript alloc] initWithSource:string];

                [string release];
                
                NSAppleEventDescriptor* returnDescriptor = NULL;
                
                
                NSDictionary* executionerror  = [NSDictionary alloc];
                
                returnDescriptor = [appleScript executeAndReturnError:&executionerror];
                
                [appleScript release];
                
                if (returnDescriptor != NULL) {
                    // successful execution
                    if (kAENullEvent != [returnDescriptor descriptorType]) {
                        // script returned an AppleScript result
                        if (cAEList == [returnDescriptor descriptorType]) {
                            // result is a list of other descriptors
                        }
                        else {
                            // coerce the result to the appropriate ObjC type
                            
                            NSString *scriptReturn = [returnDescriptor stringValue];
                            NSLog(@"Found utxt string: %@",scriptReturn);
                            NSLog(@"Application_AppleScript_Set : clickAppMenu : exit");

                            return scriptReturn;
                        }
                    }
                }
                else {
                    // no script result, handle error here
                }
            }
            else {
                // report error that applescript is not loaded from given url
            }
        }
    }
    return @"Success : click application menu option execution is complete.";
}

/*!

 @brief This method is used to select an option from a popup button in the application under test.

 @param  appname is the application under test's name and 
 controlConditions is an (NSDictionary*) type variable, for describing the control conditions to uniquely identify a control in the application under test and
 thisValue is a NSString for the value to be selected in the pupup button control.

 @return (NSString*) The message "Control found and executed the task" from the applescript after its completion. 

 @remark This method is used to click on any permutation of menu options.

 */
-(NSString*) clickOnPopUpButton:(NSString*) appname forControl:(NSDictionary*) controlConditions andMenuOption:(NSString*) thisValue {
    NSLog(@"Application_AppleScript_Set : clickOnPopUpButton : entry");

    NSString* AXIdentifierValue = (NSString*)[controlConditions valueForKey:@"AXIdentifier"];
    NSString* AXDescriptionValue = (NSString*)[controlConditions valueForKey:@"AXDescription"];
   
    NSString* searchAttribute = [NSString alloc];
    NSString* searchAttributeValue = [NSString alloc];
    
    if ([AXDescriptionValue length] > 0) {
        searchAttribute = @"var_AXDescription";
        searchAttributeValue = AXDescriptionValue;
    }
    else if ([AXIdentifierValue length] > 0) {
        searchAttribute = @"var_AXIdentifier";
        searchAttributeValue = AXIdentifierValue;
    }
    else {
        return @"ERROR : Plese provide search attribute value as AXIdentifier or AXDescription";
    }
    
    if ([thisValue isEqualToString:NULL]) {
        return @"ERROR : Plese provide option to be selected in pop up menu";
    }
    
    //NSString* AXTypeOfControl = (NSString*)[controlConditions valueForKey:@"AXRoleDescription"];
    // as this needs to be executed only on pop up button we can hard code this in apple script itself

    // load the script from a resource by fetching its URL from within our bundle
    NSString* path = [[NSBundle mainBundle] pathForResource:@"automation" ofType:@"applescript"];
    if (path != nil)
    {
        NSURL* url = [NSURL fileURLWithPath:path];
        if (url != nil)
        {
            NSError* error  = [NSError alloc];
            
            NSURL* url = [NSURL fileURLWithPath:path];
            
            NSMutableString * string = [[NSMutableString alloc] initWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
            
            if (string != nil) {
                
                [string replaceOccurrencesOfString:@"var_ myfunctionname" withString:@"selectpopupmenuoption" options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                [string replaceOccurrencesOfString:@"var_appname" withString:appname options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                [string replaceOccurrencesOfString:@"var_optionToSelect" withString:thisValue options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                [string replaceOccurrencesOfString:searchAttribute withString:searchAttributeValue options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                
                NSAppleScript* appleScript = [[NSAppleScript alloc] initWithSource:string];

                [string release];

                
                NSAppleEventDescriptor* returnDescriptor = NULL;
                
                NSDictionary* executionerror  = [NSDictionary alloc];
                
                returnDescriptor = [appleScript executeAndReturnError:&executionerror];
                
                [appleScript release];
                
                if (returnDescriptor != NULL) {
                    // successful execution
                    if (kAENullEvent != [returnDescriptor descriptorType]) {
                        // script returned an AppleScript result
                        if (cAEList == [returnDescriptor descriptorType]) {
                            // result is a list of other descriptors
                        }
                        else {
                            // coerce the result to the appropriate ObjC type
                            
                            NSString *scriptReturn = [returnDescriptor stringValue];
                            NSLog(@"Found utxt string: %@",scriptReturn);
                            NSLog(@"Application_AppleScript_Set : clickOnPopUpButton : exit");

                            return scriptReturn;
                        }
                    }
                }
                else {
                    // no script result, handle error here
                }
            }
            else {
                // report error that applescript is not loaded from given url
            }
        }
    }
    return @"Success : popup option selection task is complete.";
}

/*!

 @brief This method is used to select an option from a combo box in the application under test.

 @param  appname is the application under test's name and 
 controlConditions is an (NSDictionary*) type variable, for describing the control conditions to uniquely identify a control in the application under test and
 thisValue is a NSString for the value to be selected in the combo box control.

 @return (NSString*) The message "Control found and executed the task" from the applescript after its completion. 

 @remark This method is uses embedded applescript to select combo box options

 */

-(NSString*) clickOnComboBoxButton:(NSString*) appname forControl:(NSDictionary*) controlConditions andMenuOption:(NSString*) thisValue {

    NSLog(@"Application_AppleScript_Set : clickOnComboBoxButton : entry");

    
    NSString* AXIdentifierOfControl = (NSString*)[controlConditions valueForKey:@"AXDescription"];
    NSString* AXTypeOfControl = (NSString*)[controlConditions valueForKey:@"AXRoleDescription"];
    
    NSString* argument00	=[[NSString alloc]initWithFormat:@"%s \"%@\" \n","	set controlid to", AXIdentifierOfControl];
    NSString* argument01	=[[NSString alloc]initWithFormat:@"%s \"%@\" \n","	set controltype to", AXTypeOfControl];
    NSString* argument02	=[[NSString alloc]initWithFormat:@"%s \"%@\" \n","	set input_str to", thisValue];
    NSString* argument03	=[[NSString alloc]initWithFormat:@"%s \"%@\" \n","	set app_name to", appname];
    
    NSString* argument04	=[[NSString alloc]initWithFormat:@"%s","	tell application app_name	\n"];
    NSString* argument05	=[[NSString alloc]initWithFormat:@"%s","	activate	\n"];
    NSString* argument06	=[[NSString alloc]initWithFormat:@"%s","	delay 2	\n"];
    NSString* argument07	=[[NSString alloc]initWithFormat:@"%s","	my ClickControlWithNoWindowTitle_I(app_name, controlid, input_str,controltype)	\n"];
    NSString* argument08	=[[NSString alloc]initWithFormat:@"%s","	end tell	\n"];
    NSString* argument09	=[[NSString alloc]initWithFormat:@"%s","	on ClickControlWithNoWindowTitle_I(app_name, control_id, input_str, controltype)	\n"];
    NSString* argument10	=[[NSString alloc]initWithFormat:@"%s","	set element_attributeName to \"AXDescription\"	\n"];
    NSString* argument47	=[[NSString alloc]initWithFormat:@"%s","	set element_attributeName2 to \"AXRoleDescription\"	\n"];
    NSString* argument11	=[[NSString alloc]initWithFormat:@"%s","	set iscontrol to \"0\"	\n"];
    NSString* argument12	=[[NSString alloc]initWithFormat:@"%s","	set controlfound to \"1\"	\n"];
    NSString* argument13	=[[NSString alloc]initWithFormat:@"%s","	try	\n"];
    NSString* argument14	=[[NSString alloc]initWithFormat:@"%s","	tell application app_name	\n"];
    NSString* argument15	=[[NSString alloc]initWithFormat:@"%s","	activate	\n"];
    NSString* argument16	=[[NSString alloc]initWithFormat:@"%s","	end tell	\n"];
    NSString* argument17	=[[NSString alloc]initWithFormat:@"%s","	tell application \"System Events\"	\n"];
    NSString* argument18	=[[NSString alloc]initWithFormat:@"%s","	tell process app_name	\n"];
    NSString* argument19	=[[NSString alloc]initWithFormat:@"%s","	set theWindows to every window -- get a list of windows	\n"];
    NSString* argument20	=[[NSString alloc]initWithFormat:@"%s","	set theWindow to first item of theWindows	\n"];
    NSString* argument21	=[[NSString alloc]initWithFormat:@"%s","	repeat with windowName in theWindows	\n"];
    NSString* argument22	=[[NSString alloc]initWithFormat:@"%s","	set tElements to entire contents of windowName	\n"];
    NSString* argument23	=[[NSString alloc]initWithFormat:@"%s","	repeat with tElement in tElements	\n"];
    NSString* argument24	=[[NSString alloc]initWithFormat:@"%s","	if ((exists attribute element_attributeName of tElement) and (exists attribute element_attributeName2 of tElement)) then	\n"];
    NSString* argument25	=[[NSString alloc]initWithFormat:@"%s","	if ((value of attribute element_attributeName of tElement is equal to control_id) and (value of attribute element_attributeName2 of tElement is equal to controltype)) then	\n"];
    NSString* argument26	=[[NSString alloc]initWithFormat:@"%s","	click tElement	\n"];
    NSString* argument27	=[[NSString alloc]initWithFormat:@"%s","	delay 0.1	\n"];
    NSString* argument28	=[[NSString alloc]initWithFormat:@"%s","	keystroke input_str	\n"];
    NSString* argument29	=[[NSString alloc]initWithFormat:@"%s","	delay 0.1	\n"];
    NSString* argument30	=[[NSString alloc]initWithFormat:@"%s","	set menuItemTitles to name of menu items of menu 1 of tElement	\n"];
    NSString* argument31	=[[NSString alloc]initWithFormat:@"%s","	if input_str is in menuItemTitles then	\n"];
    NSString* argument32	=[[NSString alloc]initWithFormat:@"%s","	click menu item input_str of menu 1 of tElement	\n"];
    NSString* argument33	=[[NSString alloc]initWithFormat:@"%s","	else	\n"];
    NSString* argument34	=[[NSString alloc]initWithFormat:@"%s","	key code 53	\n"];
    NSString* argument35	=[[NSString alloc]initWithFormat:@"%s","	end if	\n"];
    NSString* argument36	=[[NSString alloc]initWithFormat:@"%s","	set iscontrol to controlfound	\n"];
    NSString* argument37	=[[NSString alloc]initWithFormat:@"%s","	exit repeat	\n"];
    NSString* argument38	=[[NSString alloc]initWithFormat:@"%s","	end if	\n"];
    NSString* argument39	=[[NSString alloc]initWithFormat:@"%s","	end if	\n"];
    NSString* argument40	=[[NSString alloc]initWithFormat:@"%s","	end repeat	\n"];
    NSString* argument41	=[[NSString alloc]initWithFormat:@"%s","	if iscontrol is equal to controlfound then exit repeat	\n"];
    NSString* argument42	=[[NSString alloc]initWithFormat:@"%s","	end repeat	\n"];
    NSString* argument43	=[[NSString alloc]initWithFormat:@"%s","	end tell	\n"];
    NSString* argument44	=[[NSString alloc]initWithFormat:@"%s","	end tell	\n"];
    NSString* argument45	=[[NSString alloc]initWithFormat:@"%s","	end try	\n"];
    NSString* argument46	=[[NSString alloc]initWithFormat:@"%s","	end ClickControlWithNoWindowTitle_I	\n"];
    
    NSMutableArray *ar = [[NSMutableArray alloc]init];
    [ar addObject:	argument00	];
    [ar addObject:	argument01	];
    [ar addObject:	argument02	];
    [ar addObject:	argument03	];
    [ar addObject:	argument04	];
    [ar addObject:	argument05	];
    [ar addObject:	argument06	];
    [ar addObject:	argument07	];
    [ar addObject:	argument08	];
    [ar addObject:	argument09	];
    [ar addObject:	argument10	];
    [ar addObject:	argument47	];
    [ar addObject:	argument11	];
    [ar addObject:	argument12	];
    [ar addObject:	argument13	];
    [ar addObject:	argument14	];
    [ar addObject:	argument15	];
    [ar addObject:	argument16	];
    [ar addObject:	argument17	];
    [ar addObject:	argument18	];
    [ar addObject:	argument19	];
    [ar addObject:	argument20	];
    [ar addObject:	argument21	];
    [ar addObject:	argument22	];
    [ar addObject:	argument23	];
    [ar addObject:	argument24	];
    [ar addObject:	argument25	];
    [ar addObject:	argument26	];
    [ar addObject:	argument27	];
    [ar addObject:	argument28	];
    [ar addObject:	argument29	];
    [ar addObject:	argument30	];
    [ar addObject:	argument31	];
    [ar addObject:	argument32	];
    [ar addObject:	argument33	];
    [ar addObject:	argument34	];
    [ar addObject:	argument35	];
    [ar addObject:	argument36	];
    [ar addObject:	argument37	];
    [ar addObject:	argument38	];
    [ar addObject:	argument39	];
    [ar addObject:	argument40	];
    [ar addObject:	argument41	];
    [ar addObject:	argument42	];
    [ar addObject:	argument43	];
    [ar addObject:	argument44	];
    [ar addObject:	argument45	];
    [ar addObject:	argument46	];
    
    NSDictionary* error;
    NSMutableString *appleScriptInput = [[NSMutableString alloc]init];
    for(NSString* s in ar){
        [appleScriptInput appendString:s];
    }
    NSLog(@"%@", appleScriptInput);
    NSAppleScript *scriptObject = [[NSAppleScript alloc]initWithSource:appleScriptInput];
    [scriptObject executeAndReturnError:&error];
    //[NSThread sleepForTimeInterval:1.0];
    NSLog(@"Application_AppleScript_Set : clickOnComboBoxButton : exit");

    return @"0";
}

/*!

 @brief This method is used to select an option from a combo box in the application under test only if it is present in the combo box's option list.

 @param  appname is the application under test's name and 
 controlConditions is an (NSDictionary*) type variable, for describing the control conditions to uniquely identify a control in the application under test and
 thisValue is a NSString for the value to be selected in the combo box control.

 @return (NSString*) The message "Control found and executed the task" from the applescript after its completion. 

 @remark This method is uses automation.applescript to select combo box options and selects an option only when the option is present in the combo box's option list

 */

-(NSString*) selectOptionFromComboBox : (NSString*) appname forControl:(NSDictionary*) controlConditions andMenuOption:(NSString*) thisValue {

    NSLog(@"Application_AppleScript_Set : selectOptionFromComboBox : entry");

    //    applescript method : selectOptionFromComboBox(appname, AXIdentifier, AXDescription, optionToSelect, true)

    NSString* AXIdentifierValue = (NSString*)[controlConditions valueForKey:@"AXIdentifier"];
    NSString* AXDescriptionValue = (NSString*)[controlConditions valueForKey:@"AXDescription"];
    
    NSString* searchAttribute = [NSString alloc];
    NSString* searchAttributeValue = [NSString alloc];
    
    if ([AXDescriptionValue length] > 0) {
        searchAttribute = @"var_AXDescription";
        searchAttributeValue = AXDescriptionValue;
    }
    else if ([AXIdentifierValue length] > 0) {
        searchAttribute = @"var_AXIdentifier";
        searchAttributeValue = AXIdentifierValue;
    }
    else {
        return @"ERROR : Plese provide search attribute value as AXIdentifier or AXDescription";
    }
    
    if ([thisValue isEqualToString:nil]) {
        return @"ERROR : Plese provide option to be selected in pop up menu";
    }
    
    //NSString* AXTypeOfControl = (NSString*)[controlConditions valueForKey:@"AXRoleDescription"];
    // as this needs to be executed only on pop up button we can hard code this in apple script itself
    
    // load the script from a resource by fetching its URL from within our bundle
    NSString* path = [[NSBundle mainBundle] pathForResource:@"automation" ofType:@"applescript"];
    if (path != nil)
    {
        NSURL* url = [NSURL fileURLWithPath:path];
        if (url != nil)
        {
            NSError* error  = [NSError alloc];
            
            NSURL* url = [NSURL fileURLWithPath:path];
            
            NSMutableString* string = [[NSMutableString alloc] initWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
            
            if (string != nil) {
                
               [string replaceOccurrencesOfString:@"var_ myfunctionname" withString:@"selectOptionFromComboBox" options:NSLiteralSearch range:NSMakeRange(0, string.length)];
               [string replaceOccurrencesOfString:@"var_appname" withString:appname options:NSLiteralSearch range:NSMakeRange(0, string.length)];
               [string replaceOccurrencesOfString:@"var_optionToSelect" withString:thisValue options:NSLiteralSearch range:NSMakeRange(0, string.length)];
               [string replaceOccurrencesOfString:searchAttribute withString:searchAttributeValue options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                
                NSAppleScript* appleScript = [[NSAppleScript alloc] initWithSource:string];
                
                [string release];
                
                NSAppleEventDescriptor* returnDescriptor = NULL;
                
                
                NSDictionary* executionerror  = [NSDictionary alloc];
                
                returnDescriptor = [appleScript executeAndReturnError:&executionerror];
                
                [appleScript release];
                
                if (returnDescriptor != NULL) {
                    // successful execution
                    if (kAENullEvent != [returnDescriptor descriptorType]) {
                        // script returned an AppleScript result
                        if (cAEList == [returnDescriptor descriptorType]) {
                            // result is a list of other descriptors
                        }
                        else {
                            // coerce the result to the appropriate ObjC type
                            
                            NSString *scriptReturn = [returnDescriptor stringValue];
                            NSLog(@"Found utxt string: %@",scriptReturn);
                            NSLog(@"Application_AppleScript_Set : selectOptionFromComboBox : exit");

                            return scriptReturn;
                        }
                    }
                }
                else {
                    // no script result, handle error here
                }
            }
            else {
                // report error that applescript is not loaded from given url
            }
        }
    }
    return @"Success : enter given value in to combobox is complete";
}

/*!

 @brief This method is used to set value to a combo box in the application under test. It sets the value to the combo box, irrespective of whether it is present in the combo box's option list or not.

 @param  appname is the application under test's name and 
 controlConditions is an (NSDictionary*) type variable, for describing the control conditions to uniquely identify a control in the application under test and
 thisValue is a NSString for the value to be selected in the combo box control.

 @return (NSString*) The message "Control found and executed the task" from the applescript after its completion. 

 @remark This method is uses automation.applescript to set a value to a combo box and sets the value even when the option is not present in the combo box's option list

 */

-(NSString*) setOptionValuetoComboBox : (NSString*) appname forControl:(NSDictionary*) controlConditions andMenuOption:(NSString*) thisValue {

    NSLog(@"Application_AppleScript_Set : setOptionValuetoComboBox : entry");

    //     applescript method :   selectOptionFromComboBox(appname, AXIdentifier, AXDescription, optionToSelect, false)

    NSString* AXIdentifierValue = (NSString*)[controlConditions valueForKey:@"AXIdentifier"];
    NSString* AXDescriptionValue = (NSString*)[controlConditions valueForKey:@"AXDescription"];
    
    NSString* searchAttribute = [NSString alloc];
    NSString* searchAttributeValue = [NSString alloc];
    
    if ([AXDescriptionValue length] > 0) {
        searchAttribute = @"var_AXDescription";
        searchAttributeValue = AXDescriptionValue;
    }
    else if ([AXIdentifierValue length] > 0) {
        searchAttribute = @"var_AXIdentifier";
        searchAttributeValue = AXIdentifierValue;
    }
    else {
        return @"ERROR : Plese provide search attribute value as AXIdentifier or AXDescription";
    }
    
    if ([thisValue isEqualToString:NULL]) {
        return @"ERROR : Plese provide option to be selected in pop up menu";
    }
    
    //NSString* AXTypeOfControl = (NSString*)[controlConditions valueForKey:@"AXRoleDescription"];
    // as this needs to be executed only on pop up button we can hard code this in apple script itself
    
    // load the script from a resource by fetching its URL from within our bundle
    NSString* path = [[NSBundle mainBundle] pathForResource:@"automation" ofType:@"applescript"];
    if (path != nil)
    {
        NSURL* url = [NSURL fileURLWithPath:path];
        if (url != nil)
        {
            NSError* error  = [NSError alloc];
            
            NSURL* url = [NSURL fileURLWithPath:path];
            
            NSMutableString* string = [[NSMutableString alloc] initWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
            
            if (string != nil) {
                
                [string replaceOccurrencesOfString:@"var_ myfunctionname" withString:@"setOptionValuetoComboBox" options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                [string replaceOccurrencesOfString:@"var_appname" withString:appname options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                [string replaceOccurrencesOfString:@"var_optionToSelect" withString:thisValue options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                [string replaceOccurrencesOfString:searchAttribute withString:searchAttributeValue options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                
                NSAppleScript* appleScript = [[NSAppleScript alloc] initWithSource:string];
                
                [string release];

                NSAppleEventDescriptor* returnDescriptor = NULL;
                
                
                NSDictionary* executionerror  = [NSDictionary alloc];
                
                returnDescriptor = [appleScript executeAndReturnError:&executionerror];
                
                [appleScript release];
                
                if (returnDescriptor != NULL) {
                    // successful execution
                    if (kAENullEvent != [returnDescriptor descriptorType]) {
                        // script returned an AppleScript result
                        if (cAEList == [returnDescriptor descriptorType]) {
                            // result is a list of other descriptors
                        }
                        else {
                            // coerce the result to the appropriate ObjC type
                            
                            NSString *scriptReturn = [returnDescriptor stringValue];
                            NSLog(@"Found utxt string: %@",scriptReturn);
                            NSLog(@"Application_AppleScript_Set : setOptionValuetoComboBox : exit");

                            return scriptReturn;
                        }
                    }
                }
                else {
                    // no script result, handle error here
                }
            }
            else {
                // report error that applescript is not loaded from given url
            }
        }
    }
    return @"Success : select option from combobox list is complete";
}

/*!

 @brief This method is used to click on a UI element in the application under test.

 @param  appname is the application under test's name and 
 controlConditions is an (NSDictionary*) type variable, for describing the control conditions to uniquely identify a control in the application under test.

 @return (NSString*) The message "Control found and executed the task" from the applescript after its completion. 

 @remark This method is uses automation.applescript to click on a UI element present in the AUT

 */

-(NSString*) clickUIControl : (NSString*) appname forControl:(NSDictionary*) controlConditions {

    NSLog(@"Application_AppleScript_Set : clickUIControl : entry");

    
    //NSLog(@"flow is inside clickUIControl method");
    
    NSString* AXIdentifierValue = (NSString*)[controlConditions valueForKey:@"AXIdentifier"];
    NSString* AXDescriptionValue = (NSString*)[controlConditions valueForKey:@"AXDescription"];
    
    NSString* searchAttribute = [NSString alloc];
    NSString* searchAttributeValue = [NSString alloc];
    
    if ([AXDescriptionValue length] > 0) {
        searchAttribute = @"var_AXDescription";
        searchAttributeValue = AXDescriptionValue;
    }
    else if ([AXIdentifierValue length] > 0) {
        searchAttribute = @"var_AXIdentifier";
        searchAttributeValue = AXIdentifierValue;
    }
    else {
        return @"ERROR : Plese provide search attribute value as AXIdentifier or AXDescription";
    }
    
    
    //NSString* AXTypeOfControl = (NSString*)[controlConditions valueForKey:@"AXRoleDescription"];
    // as this needs to be executed only on pop up button we can hard code this in apple script itself
    
    // load the script from a resource by fetching its URL from within our bundle
    NSString* path = [[NSBundle mainBundle] pathForResource:@"automation" ofType:@"applescript"];
    if (path != nil)
    {
        NSURL* url = [NSURL fileURLWithPath:path];
        if (url != nil)
        {
            NSError* error  = [NSError alloc];
            
            NSURL* url = [NSURL fileURLWithPath:path];
            
            NSMutableString* string = [[NSMutableString alloc] initWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
            
            if (string != nil) {
                
                [string replaceOccurrencesOfString:@"var_ myfunctionname" withString:@"clickuielement" options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                [string replaceOccurrencesOfString:@"var_appname" withString:appname options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                [string replaceOccurrencesOfString:searchAttribute withString:searchAttributeValue options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                
                NSAppleScript* appleScript = [[NSAppleScript alloc] initWithSource:string];
                
                [string release];
                
                NSAppleEventDescriptor* returnDescriptor = NULL;
                
                
                NSDictionary* executionerror  = [NSDictionary alloc];
                
                returnDescriptor = [appleScript executeAndReturnError:&executionerror];
                
                [appleScript release];
                
                if (returnDescriptor != NULL) {
                    // successful execution
                    if (kAENullEvent != [returnDescriptor descriptorType]) {
                        // script returned an AppleScript result
                        if (cAEList == [returnDescriptor descriptorType]) {
                            // result is a list of other descriptors
                        }
                        else {
                            // coerce the result to the appropriate ObjC type
                            
                            NSString *scriptReturn = [returnDescriptor stringValue];
                            NSLog(@"Found utxt string: %@",scriptReturn);
                            NSLog(@"Application_AppleScript_Set : clickUIControl : exit");

                            return scriptReturn;
                        }
                    }
                }
                else {
                    // no script result, handle error here
                }
            }
            else {
                // report error that applescript is not loaded from given url
            }
        }
    }
    return @"Success : task click ui element is complete";
}

/*!

 @brief This method is used to check an unchecked check box in the application under test.

 @param  appname is the application under test's name and 
 controlConditions is an (NSDictionary*) type variable, for describing the control conditions to uniquely identify a control in the application under test.

 @return (NSString*) The message "Control found and executed the task" from the applescript after its completion. 

 @remark This method is uses automation.applescript to check an unchecked check box present in the AUT and nothing is done if the checkbox is already checked.

 */

-(NSString*) checkCheckBox : (NSString*) appname forControl:(NSDictionary*) controlConditions {
    
    NSLog(@"Application_AppleScript_Set : checkCheckBox : entry");

    NSString* AXIdentifierValue = (NSString*)[controlConditions valueForKey:@"AXIdentifier"];
    NSString* AXDescriptionValue = (NSString*)[controlConditions valueForKey:@"AXDescription"];
    
    NSString* searchAttribute = [NSString alloc];
    NSString* searchAttributeValue = [NSString alloc];
    
    if ([AXDescriptionValue length] > 0) {
        searchAttribute = @"var_AXDescription";
        searchAttributeValue = AXDescriptionValue;
    }
    else if ([AXIdentifierValue length] > 0) {
        searchAttribute = @"var_AXIdentifier";
        searchAttributeValue = AXIdentifierValue;
    }
    else {
        return @"ERROR : Plese provide search attribute value as AXIdentifier or AXDescription";
    }
    
    
    //NSString* AXTypeOfControl = (NSString*)[controlConditions valueForKey:@"AXRoleDescription"];
    // as this needs to be executed only on pop up button we can hard code this in apple script itself
    
    // load the script from a resource by fetching its URL from within our bundle
    NSString* path = [[NSBundle mainBundle] pathForResource:@"automation" ofType:@"applescript"];
    if (path != nil)
    {
        NSURL* url = [NSURL fileURLWithPath:path];
        if (url != nil)
        {
            NSError* error  = [NSError alloc];
            
            NSURL* url = [NSURL fileURLWithPath:path];
            
            NSMutableString* string = [[NSMutableString alloc] initWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
            
            if (string != nil) {
                
                [string replaceOccurrencesOfString:@"var_ myfunctionname" withString:@"checkcheckbox" options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                [string replaceOccurrencesOfString:@"var_appname" withString:appname options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                [string replaceOccurrencesOfString:searchAttribute withString:searchAttributeValue options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                
                NSAppleScript* appleScript = [[NSAppleScript alloc] initWithSource:string];
                
                [string release];
                
                NSAppleEventDescriptor* returnDescriptor = NULL;
                
                
                NSDictionary* executionerror  = [NSDictionary alloc];
                
                returnDescriptor = [appleScript executeAndReturnError:&executionerror];
                
                [appleScript release];
                
                if (returnDescriptor != NULL) {
                    // successful execution
                    if (kAENullEvent != [returnDescriptor descriptorType]) {
                        // script returned an AppleScript result
                        if (cAEList == [returnDescriptor descriptorType]) {
                            // result is a list of other descriptors
                        }
                        else {
                            // coerce the result to the appropriate ObjC type
                            
                            NSString *scriptReturn = [returnDescriptor stringValue];
                            NSLog(@"Found utxt string: %@",scriptReturn);
                            NSLog(@"Application_AppleScript_Set : checkCheckBox : exit");

                            return scriptReturn;
                        }
                    }
                }
                else {
                    // no script result, handle error here
                }
            }
            else {
                // report error that applescript is not loaded from given url
            }
        }
    }
    return @"Success : task check checkbox is complete";
}

/*!

 @brief This method is used to uncheck an checked check box in the application under test.

 @param  appname is the application under test's name and 
 controlConditions is an (NSDictionary*) type variable, for describing the control conditions to uniquely identify a control in the application under test.

 @return (NSString*) The message "Control found and executed the task" from the applescript after its completion. 

 @remark This method is uses automation.applescript to uncheck an checked check box present in the AUT and nothing is done if the checkbox is already unchecked.

 */
-(NSString*) uncheckCheckBox : (NSString*) appname forControl:(NSDictionary*) controlConditions {

    NSLog(@"Application_AppleScript_Set : uncheckCheckBox : entry");
    
    NSString* AXIdentifierValue = (NSString*)[controlConditions valueForKey:@"AXIdentifier"];
    NSString* AXDescriptionValue = (NSString*)[controlConditions valueForKey:@"AXDescription"];
    
    NSString* searchAttribute = [NSString alloc];
    NSString* searchAttributeValue = [NSString alloc];
    
    if ([AXDescriptionValue length] > 0) {
        searchAttribute = @"var_AXDescription";
        searchAttributeValue = AXDescriptionValue;
    }
    else if ([AXIdentifierValue length] > 0) {
        searchAttribute = @"var_AXIdentifier";
        searchAttributeValue = AXIdentifierValue;
    }
    else {
        return @"ERROR : Plese provide search attribute value as AXIdentifier or AXDescription";
    }
    
    
    //NSString* AXTypeOfControl = (NSString*)[controlConditions valueForKey:@"AXRoleDescription"];
    // as this needs to be executed only on pop up button we can hard code this in apple script itself
    
    // load the script from a resource by fetching its URL from within our bundle
    NSString* path = [[NSBundle mainBundle] pathForResource:@"automation" ofType:@"applescript"];
    if (path != nil)
    {
        NSURL* url = [NSURL fileURLWithPath:path];
        if (url != nil)
        {
            NSError* error  = [NSError alloc];
            
            NSURL* url = [NSURL fileURLWithPath:path];
            
            NSMutableString* string = [[NSMutableString alloc] initWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
            
            if (string != nil) {
                
                [string replaceOccurrencesOfString:@"var_ myfunctionname" withString:@"uncheckcheckbox" options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                [string replaceOccurrencesOfString:@"var_appname" withString:appname options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                [string replaceOccurrencesOfString:searchAttribute withString:searchAttributeValue options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                
                NSAppleScript* appleScript = [[NSAppleScript alloc] initWithSource:string];
                
                [string release];
                
                NSAppleEventDescriptor* returnDescriptor = NULL;
                
                
                NSDictionary* executionerror  = [NSDictionary alloc];
                
                returnDescriptor = [appleScript executeAndReturnError:&executionerror];
                
                [appleScript release];
                
                if (returnDescriptor != NULL) {
                    // successful execution
                    if (kAENullEvent != [returnDescriptor descriptorType]) {
                        // script returned an AppleScript result
                        if (cAEList == [returnDescriptor descriptorType]) {
                            // result is a list of other descriptors
                        }
                        else {
                            // coerce the result to the appropriate ObjC type
                            
                            NSString *scriptReturn = [returnDescriptor stringValue];
                            NSLog(@"Found utxt string: %@",scriptReturn);
                            NSLog(@"Application_AppleScript_Set : uncheckCheckBox : exit");

                            return scriptReturn;
                        }
                    }
                }
                else {
                    // no script result, handle error here
                }
            }
            else {
                // report error that applescript is not loaded from given url
            }
        }
    }
    return @"Success : task check checkbox is complete";
}

/*!

 @brief This method is used to set a value in a text field present in the application under test.

 @param  appname is the application under test's name and 
 controlConditions is an (NSDictionary*) type variable, for describing the control conditions to uniquely identify a control in the application under test.

 @return (NSString*) The message "Control found and executed the task" from the applescript after its completion. 

 @remark This method is uses automation.applescript to set value in a text field present in the AUT.

 */
-(NSString*) editTextField : (NSString*) appname forControl:(NSDictionary*) controlConditions andMenuOption:(NSString*) thisValue {

    NSLog(@"Application_AppleScript_Set : editTextField : entry");

    NSString* AXIdentifierValue = (NSString*)[controlConditions valueForKey:@"AXIdentifier"];
    NSString* AXDescriptionValue = (NSString*)[controlConditions valueForKey:@"AXDescription"];
    
    NSString* searchAttribute = [NSString alloc];
    NSString* searchAttributeValue = [NSString alloc];
    
    if ([AXDescriptionValue length] > 0) {
        searchAttribute = @"var_AXDescription";
        searchAttributeValue = AXDescriptionValue;
    }
    else if ([AXIdentifierValue length] > 0) {
        searchAttribute = @"var_AXIdentifier";
        searchAttributeValue = AXIdentifierValue;
    }
    else {
        return @"ERROR : Plese provide search attribute value as AXIdentifier or AXDescription";
    }
    
    
    //NSString* AXTypeOfControl = (NSString*)[controlConditions valueForKey:@"AXRoleDescription"];
    // as this needs to be executed only on pop up button we can hard code this in apple script itself
    
    // load the script from a resource by fetching its URL from within our bundle
    NSString* path = [[NSBundle mainBundle] pathForResource:@"automation" ofType:@"applescript"];
    if (path != nil)
    {
        NSURL* url = [NSURL fileURLWithPath:path];
        if (url != nil)
        {
            NSError* error  = [NSError alloc];
            
            NSURL* url = [NSURL fileURLWithPath:path];
            
            NSMutableString* string = [[NSMutableString alloc] initWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
            
            if (string != nil) {
                
                [string replaceOccurrencesOfString:@"var_ myfunctionname" withString:@"editTextField" options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                [string replaceOccurrencesOfString:@"var_appname" withString:appname options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                [string replaceOccurrencesOfString:@"var_optionToSelect" withString:thisValue options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                [string replaceOccurrencesOfString:searchAttribute withString:searchAttributeValue options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                
                NSAppleScript* appleScript = [[NSAppleScript alloc] initWithSource:string];
                
                [string release];
                
                NSAppleEventDescriptor* returnDescriptor = NULL;
                
                
                NSDictionary* executionerror  = [NSDictionary alloc];
                
                returnDescriptor = [appleScript executeAndReturnError:&executionerror];
                
                [appleScript release];
                
                if (returnDescriptor != NULL) {
                    // successful execution
                    if (kAENullEvent != [returnDescriptor descriptorType]) {
                        // script returned an AppleScript result
                        if (cAEList == [returnDescriptor descriptorType]) {
                            // result is a list of other descriptors
                        }
                        else {
                            // coerce the result to the appropriate ObjC type
                            
                            NSString *scriptReturn = [returnDescriptor stringValue];
                            NSLog(@"Found utxt string: %@",scriptReturn);
                            NSLog(@"Application_AppleScript_Set : editTextField : exit");

                            return scriptReturn;
                        }
                    }
                }
                else {
                    // no script result, handle error here
                }
            }
            else {
                // report error that applescript is not loaded from given url
            }
        }
    }
    return @"Success : task editTextField is complete";
}


/*!

 @brief This method is used to tick or untick a menu option in the application under test.

 @param  appname is the application under test's name and 
 menuoptions is the array of the menu options to be selected and
 tickUntickMenuOption is an NSString used to tell if the action to be performed is to tick or untick the menu option

 @return (NSString*) The message "task is complete" from the applescript after its completion. 

 @remark This method is uses automation.applescript to tick or untick a menu option in the application under test.

 */
-(NSString*) tickUntickAppMenu:(NSString *)appname andMenuPath:(NSArray *)menuoptions andTickUntick: (NSString *) tickUntickMenuOption {

    NSLog(@"Application_AppleScript_Set : tickUntickAppMenu : entry");

    // let's see if removing thread sleep has any impact, if there is any issue then we will uncomment.
    //[NSThread sleepForTimeInterval:0.6];
    
    NSInteger arraycount = [menuoptions count];
    NSString* ASFunctionName =  [tickUntickMenuOption stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)arraycount]];
    
    // load the script from a resource by fetching its URL from within our bundle
    NSString* path = [[NSBundle mainBundle] pathForResource:@"automation" ofType:@"applescript"];
    
    if (path != nil)
    {
        NSURL* url = [NSURL fileURLWithPath:path];
        if (url != nil)
        {
            NSError* error  = [NSError alloc];
            
            NSURL* url = [NSURL fileURLWithPath:path];
            
            NSMutableString* string = [[NSMutableString alloc] initWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
            
            //[url release];
            
            if (string != nil) {
                
                if(arraycount <= 1) {
                    return @"ERROR : tick untick menu option can't be done on menu bar, please provide menu option ";

                }
                else if (arraycount == 2) {
                    [string replaceOccurrencesOfString:@"var_ myfunctionname" withString:ASFunctionName options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_appname" withString:appname options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_option1" withString:[menuoptions objectAtIndex:0] options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_option2" withString:[menuoptions objectAtIndex:1] options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                }
                else if (arraycount == 3) {
                    [string replaceOccurrencesOfString:@"var_ myfunctionname" withString:ASFunctionName options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_appname" withString:appname options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_option1" withString:[menuoptions objectAtIndex:0] options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_option2" withString:[menuoptions objectAtIndex:1] options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_option3" withString:[menuoptions objectAtIndex:2] options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                }
                else if (arraycount == 4) {
                    [string replaceOccurrencesOfString:@"var_ myfunctionname" withString:ASFunctionName options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_appname" withString:appname options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_option1" withString:[menuoptions objectAtIndex:0] options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_option2" withString:[menuoptions objectAtIndex:1] options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_option3" withString:[menuoptions objectAtIndex:2] options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                    [string replaceOccurrencesOfString:@"var_option4" withString:[menuoptions objectAtIndex:3] options:NSLiteralSearch range:NSMakeRange(0, string.length)];
                }
                else{
                    return @"ERROR : Menu Count is greater than 4 is invalid!";
                }
                
                NSAppleScript* appleScript = [[NSAppleScript alloc] initWithSource:string];
                
                [string release];
                
                NSAppleEventDescriptor* returnDescriptor = NULL;
                
                
                NSDictionary* executionerror  = [NSDictionary alloc];
                
                returnDescriptor = [appleScript executeAndReturnError:&executionerror];
                
                [appleScript release];
                
                if (returnDescriptor != NULL) {
                    // successful execution
                    if (kAENullEvent != [returnDescriptor descriptorType]) {
                        // script returned an AppleScript result
                        if (cAEList == [returnDescriptor descriptorType]) {
                            // result is a list of other descriptors
                        }
                        else {
                            // coerce the result to the appropriate ObjC type
                            
                            NSString *scriptReturn = [returnDescriptor stringValue];
                            NSLog(@"Found utxt string: %@",scriptReturn);
                            NSLog(@"Application_AppleScript_Set : tickUntickAppMenu : exit");

                            return scriptReturn;
                        }
                    }
                }
                else {
                    // no script result, handle error here
                }
            }
            else {
                // report error that applescript is not loaded from given url
            }
        }
    }
    return @"Success : click application menu option execution is complete.";
}



@end
