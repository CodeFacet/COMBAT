(*
 @author Piyush Bansal (piyush2508@gmail.com), Gopi Krishna Rajoju (gopirajoju@live.com) and Sakshi Goyal (sakshigoyal369@gmail.com)
 
 @date 04/07/14
 
 @brief This file contains all the AppleScript methods
 
 @copyright Copyright (c) 2015, The Combat authors - Piyush Bansal, Gopi Krishna Rajoju and Sakshi Goyal. All rights reserved.
 
 Redistribution is not permitted. Use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Use of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 
 Use in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the derived product.
 
 The names of its contributors must not be used to endorse or promote products derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *)
set myfunctionname to "var_ myfunctionname"
set appname to "var_appname"
set option1 to "var_option1"
set option2 to "var_option2"
set option3 to "var_option3"
set option4 to "var_option4"
set AXIdentifier to "var_AXIdentifier"
set AXDescription to "var_AXDescription"
set optionToSelect to "var_optionToSelect"

set temporaryItemsFolderPath to path to of temporary items from system domain
set temporaryItemsFolderPosixPath to POSIX path of (temporaryItemsFolderPath as text)
set cliclickPath to trim_line(temporaryItemsFolderPosixPath, "TemporaryItems/", 1) & "cliclick "

executemyfunction(myfunctionname, appname, option1, option2, option3, option4, AXIdentifier, AXDescription, optionToSelect, cliclickPath)

on executemyfunction(myfunctionname, appname, option1, option2, option3, option4, AXIdentifier, AXDescription, optionToSelect, cliclickPath)
	if (myfunctionname = "clickmeuoption3") then
		clickmenuoption3(appname, option1, option2, option3)
	else if (myfunctionname = "clickmeuoption2") then
		clickmenuoption2(appname, option1, option2)
	else if (myfunctionname = "clickmeuoption1") then
		clickmenuoption1(appname, option1)
	else if (myfunctionname = "clickmeuoption4") then
		clickmenuoption4(appname, option1, option2, option3, option4)
	else if (myfunctionname = "selectpopupmenuoption") then
		findIfControlFound1(myfunctionname, appname, AXIdentifier, AXDescription, false, cliclickPath, optionToSelect, false)
	else if (myfunctionname = "selectOptionFromComboBox") then
		findIfControlFound1(myfunctionname, appname, AXIdentifier, AXDescription, false, cliclickPath, optionToSelect, true)
	else if (myfunctionname = "setOptionValuetoComboBox") then
		findIfControlFound1(myfunctionname, appname, AXIdentifier, AXDescription, false, cliclickPath, optionToSelect, false)
	else if (myfunctionname = "clickuielement") then
		findIfControlFound1(myfunctionname, appname, AXIdentifier, AXDescription, false, cliclickPath, optionToSelect, false)
	else if (myfunctionname = "checkcheckbox") then
		findIfControlFound1(myfunctionname, appname, AXIdentifier, AXDescription, true, cliclickPath, optionToSelect, false)
	else if (myfunctionname = "uncheckcheckbox") then
		findIfControlFound1(myfunctionname, appname, AXIdentifier, AXDescription, false, cliclickPath, optionToSelect, false)
	else if (myfunctionname = "editTextField") then
		findIfControlFound1(myfunctionname, appname, AXIdentifier, AXDescription, false, cliclickPath, optionToSelect, false)
	else if (myfunctionname = "typeText") then
		typeText(appname, optionToSelect)
	else if (myfunctionname = "tickmeuoption2") then
		tickuntickmeuoption2(appname, option1, option2, true)
	else if (myfunctionname = "tickmeuoption3") then
		tickuntickmeuoption3(appname, option1, option2, option3, true)
	else if (myfunctionname = "tickmeuoption4") then
		tickuntickmeuoption4(appname, option1, option2, option3, option4, true)
	else if (myfunctionname = "untickmeuoption2") then
		tickuntickmeuoption2(appname, option1, option2, false)
	else if (myfunctionname = "untickmeuoption3") then
		tickuntickmeuoption3(appname, option1, option2, option3, false)
	else if (myfunctionname = "untickmeuoption4") then
		tickuntickmeuoption4(appname, option1, option2, option3, option4, false)
	end if
	
end executemyfunction

on typeText(appname, textToType)
	tell application appname
		activate
	end tell
	tell application "System Events"
		keystroke textToType
	end tell
end typeText

on clickmenuoption1(appname, option1)
	tell application appname
		activate
	end tell
	tell application "System Events"
		tell process appname
			tell menu bar 1
				click menu bar item option1
			end tell
		end tell
	end tell
	return "task is complete"
end clickmenuoption1

on clickmenuoption2(appname, option1, option2)
	tell application appname
		activate
	end tell
	tell application "System Events"
		tell process appname
			tell menu bar 1
				tell menu bar item option1
					tell menu option1
						click menu item option2
					end tell
				end tell
			end tell
		end tell
	end tell
	return "task is complete"
	
end clickmenuoption2

on tickuntickmeuoption2(appname, option1, option2, tickmarkstate)
	tell application appname
		activate
	end tell
	tell application "System Events"
		tell process appname
			tell menu bar 1
				tell menu bar item option1
					tell menu option1
						if (tickmarkstate) then
							if (value of attribute "AXMenuItemMarkChar" of menu item option2 is equal to missing value) then
								click menu item option2
							else
								(*key code 53*)
								return "menu option is tick status is already true"
							end if
						else
							if (value of attribute "AXMenuItemMarkChar" of menu item option2 is equal to missing value) then
								(*key code 53*)
								return "menu option is tick status is already false"
								
							else
								click menu item option2
								return "task is complete"
							end if
						end if
						
					end tell
				end tell
			end tell
		end tell
	end tell
end tickuntickmeuoption2

on tickuntickmeuoption3(appname, option1, option2, option3, tickmarkstate)
	tell application appname
		activate
	end tell
	tell application "System Events"
		tell process appname
			tell menu bar 1
				tell menu bar item option1
					tell menu option1
						tell menu item option2
							tell menu option2
								if (tickmarkstate) then
									if (value of attribute "AXMenuItemMarkChar" of menu item option3 is equal to missing value) then
										click menu item option3
									else
										key code 53
										return "ERROR : menu option is tick status is already true"
									end if
								else
									if (value of attribute "AXMenuItemMarkChar" of menu item option3 is equal to missing value) then
										key code 53
										return "ERROR : menu option is tick status is already false"
									else
										click menu item option3
										return "task is complete"
									end if
								end if
								
							end tell
						end tell
					end tell
				end tell
			end tell
		end tell
	end tell
end tickuntickmeuoption3

on tickuntickmeuoption4(appname, option1, option2, option3, option4, tickmarkstate)
	tell application appname
		activate
	end tell
	tell application "System Events"
		tell process appname
			tell menu bar 1
				tell menu bar item option1
					tell menu option1
						tell menu item option2
							tell menu option2
								tell menu item option3
									tell menu option3
										if (tickmarkstate) then
											if (value of attribute "AXMenuItemMarkChar" of menu item option4 is equal to missing value) then
												click menu item option4
											else
												key code 53
												return "ERROR : menu option is tick status is already true"
											end if
										else
											if (value of attribute "AXMenuItemMarkChar" of menu item option4 is equal to missing value) then
												key code 53
												return "ERROR : menu option is tick status is already false"
											else
												click menu item option4
												return "task is complete"
											end if
										end if
									end tell
								end tell
							end tell
						end tell
					end tell
				end tell
			end tell
		end tell
	end tell
end tickuntickmeuoption4

on clickmenuoption3(appname, option1, option2, option3)
	tell application appname
		activate
	end tell
	tell application "System Events"
		tell process appname
			tell menu bar 1
				tell menu bar item option1
					tell menu option1
						tell menu item option2
							tell menu option2
								click menu item option3
								return "task is complete"
								
							end tell
						end tell
					end tell
				end tell
			end tell
		end tell
	end tell
end clickmenuoption3

on clickmenuoption4(appname, option1, option2, option3, option4)
	tell application appname
		activate
	end tell
	tell application "System Events"
		tell process appname
			tell menu bar 1
				tell menu bar item option1
					tell menu option1
						tell menu item option2
							tell menu option2
								tell menu item option3
									tell menu option3
										click menu item option4
										return "task is complete"
										
									end tell
								end tell
							end tell
						end tell
					end tell
				end tell
			end tell
		end tell
	end tell
end clickmenuoption4

on findIfControlFound1(myfunctionname, appname, AXIdentifier, AXDescription, checkuncheck, cliclickPath, optionToSelect, strictSelection)
	
	if (AXIdentifier is not equal to "var_" & "AXIdentifier") then
		set searchAttribute_value to AXIdentifier
		set searchAttribute_name to "AXIdentifier"
	else if (AXDescription is not equal to "var_" & "AXDescription") then
		set searchAttribute_value to AXDescription
		set searchAttribute_name to "AXDescription"
	else
		return "Search attribute is not given for AXIdentifier or AXDescription"
	end if
	
	try
		set triesnum to {1, 2, 3}
		repeat with i in triesnum
			tell application appname
				activate
			end tell
			tell application "System Events"
				tell process appname
					set theWindowNumber to 0
					set theWindows to every window -- get a list of windows
					set iscontrolfound to false
					
					
					repeat with theWindow in theWindows
						set theWindowNumber to theWindowNumber + 1
						(* log "this window number is : " & theWindowNumber *)
						
						set tElements to entire contents of theWindow
						set theControlNumber to 0
						(* set tElements to every combo box of theWindow *)
						repeat with tElement in tElements
							set theControlNumber to theControlNumber + 1
							
							
							if (exists attribute searchAttribute_name of tElement) then
								if (value of attribute searchAttribute_name of tElement is equal to searchAttribute_value) then
									log "Window number is : " & theWindowNumber & " Control number is : " & theControlNumber
									set finalcontrolnum to theControlNumber
									set finalwinnum to theWindowNumber
									set iscontrolfound to true
								end if
							end if
							
						end repeat
						
						(* log "is control value is : " & iscontrolfound *)
						if iscontrolfound is equal to true then exit repeat
					end repeat
					
				end tell
			end tell
			log "NO OF TRIES:" & i & "Control Fond is:" & iscontrolfound
			if iscontrolfound is equal to true then exit repeat
			
			
			
			
		end repeat
		if iscontrolfound is equal to true then
			
			if (myfunctionname = "selectpopupmenuoption") then
				selectPopupMenuOption1(appname, finalwinnum, finalcontrolnum, optionToSelect)
			else if (myfunctionname = "selectOptionFromComboBox") then
				selectOptionFromComboBox1(appname, finalwinnum, finalcontrolnum, optionToSelect, cliclickPath, true)
			else if (myfunctionname = "setOptionValuetoComboBox") then
				selectOptionFromComboBox1(appname, finalwinnum, finalcontrolnum, optionToSelect, cliclickPath, false)
			else if (myfunctionname = "clickuielement") then
				clickuielement1(appname, finalwinnum, finalcontrolnum, cliclickPath)
			else if (myfunctionname = "checkcheckbox") then
				checkuncheckcheckbox1(appname, finalwinnum, finalcontrolnum, checkuncheck, cliclickPath)
			else if (myfunctionname = "uncheckcheckbox") then
				checkuncheckcheckbox1(appname, finalwinnum, finalcontrolnum, checkuncheck, cliclickPath)
			else if (myfunctionname = "editTextField") then
				editTextField1(appname, finalwinnum, finalcontrolnum, optionToSelect, cliclickPath)
			end if
			return "Control found and executed the task"
		else
			return "ERROR: Control not found!!"
		end if
	end try
	
end findIfControlFound1

on selectPopupMenuOption1(appname, theWindowNumber, theControlNumber, optionToSelect)
	
	try
		tell application appname
			activate
		end tell
		tell application "System Events"
			tell process appname
				
				log "theControlNumber:" & theControlNumber & " theWindowNumber:" & theWindowNumber
				
				set theControls to entire contents of window theWindowNumber
				set mycombo to the item theControlNumber of theControls
				log mycombo
				
				
				
				click mycombo
				(* removed the below delays as this was resulting in huge delay on every execution *)
				(* delay 0.1 *)
				keystroke optionToSelect
				(* delay 0.1 *)
				set menuItemTitles to name of menu items of menu 1 of mycombo
				if optionToSelect is in menuItemTitles then
					click menu item optionToSelect of menu 1 of mycombo
					return "Control found and executed the task"
				else
					key code 53
					return "ERROR : Control found but not the given option in popup menu"
				end if
				
				
				
			end tell
		end tell
	end try
end selectPopupMenuOption1

on editTextField1(appname, theWindowNumber, theControlNumber, optionToSelect, cliclickPath)
	
	try
		tell application appname
			activate
		end tell
		tell application "System Events"
			tell process appname
				
				log "theControlNumber:" & theControlNumber & " theWindowNumber:" & theWindowNumber
				
				set theControls to entire contents of window theWindowNumber
				set mycombo to the item theControlNumber of theControls
				log mycombo
				
				
				
				set cp to position of mycombo
				set cs to size of mycombo
				
				set buttonxCoordinate to (item 1 of cp) + (item 1 of cs) / 2 as text
				log buttonxCoordinate
				set buttonyCoordinate to (item 2 of cp) + (item 2 of cs) / 2 as text
				log buttonyCoordinate
				
				my tripleClickOnScreenPoint(cliclickPath, buttonxCoordinate, buttonyCoordinate)
				keystroke optionToSelect
				
				
			end tell
		end tell
	end try
end editTextField1

on selectOptionFromComboBox1(appname, theWindowNumber, theControlNumber, optionToSelect, cliclickPath, strictSelection)
	
	try
		tell application appname
			activate
		end tell
		tell application "System Events"
			tell process appname
				
				log "theControlNumber:" & theControlNumber & " theWindowNumber:" & theWindowNumber
				
				set theControls to entire contents of window theWindowNumber
				set mycombo to the item theControlNumber of theControls
				log mycombo
				
				if strictSelection is equal to true then
					try
						log "strict is:" & strictSelection
						click button of mycombo
						log "After button click"
					end try
				else
					set cp to position of mycombo
					set cs to size of mycombo
					
					set buttonxCoordinate to (item 1 of cp) + (item 1 of cs) / 2 as text
					log buttonxCoordinate
					set buttonyCoordinate to (item 2 of cp) + (item 2 of cs) / 2 as text
					log buttonyCoordinate
					
					my tripleClickOnScreenPoint(cliclickPath, buttonxCoordinate, buttonyCoordinate)
					keystroke optionToSelect
					keystroke return
					return "task is complete"
					
					(* set value of tElement to optionToSelect *)
				end if
			end tell
		end tell
		if strictSelection is equal to true then
			log "before strict selection"
			selectComboBoxListItem(appname, theWindowNumber, theControlNumber, optionToSelect, cliclickPath)
			log "after strict selection"
		end if
	end try
end selectOptionFromComboBox1

on clickuielement1(appname, theWindowNumber, theControlNumber, cliclickPath)
	
	try
		tell application appname
			activate
		end tell
		tell application "System Events"
			tell process appname
				
				log "theControlNumber:" & theControlNumber & " theWindowNumber:" & theWindowNumber
				
				set theControls to entire contents of window theWindowNumber
				set mycombo to the item theControlNumber of theControls
				log mycombo
				
				
				
				set cp to position of mycombo
				set cs to size of mycombo
				
				set buttonxCoordinate to (item 1 of cp) + (item 1 of cs) / 2 as text
				log buttonxCoordinate
				set buttonyCoordinate to (item 2 of cp) + (item 2 of cs) / 2 as text
				log buttonyCoordinate
				my clickScreenPoint(cliclickPath, buttonxCoordinate, buttonyCoordinate)
				
				
			end tell
		end tell
	end try
end clickuielement1

on checkuncheckcheckbox1(appname, theWindowNumber, theControlNumber, checkuncheck, cliclickPath, strictSelection)
	
	try
		tell application appname
			activate
		end tell
		tell application "System Events"
			tell process appname
				
				log "theControlNumber:" & theControlNumber & " theWindowNumber:" & theWindowNumber
				
				set theControls to entire contents of window theWindowNumber
				set mycombo to the item theControlNumber of theControls
				log mycombo
				
				
				if (checkuncheck) then
					if not (value of tElement as boolean) then
						set cp to position of mycombo
						set cs to size of mycombo
						
						set buttonxCoordinate to (item 1 of cp) + (item 1 of cs) / 2 as text
						log buttonxCoordinate
						set buttonyCoordinate to (item 2 of cp) + (item 2 of cs) / 2 as text
						log buttonyCoordinate
						my clickScreenPoint(cliclickPath, buttonxCoordinate, buttonyCoordinate)
					else
						return "ERROR : check box is already checked!"
					end if
				else
					if (value of tElement as boolean) then
						set cp to position of mycombo
						set cs to size of mycombo
						
						set buttonxCoordinate to (item 1 of cp) + (item 1 of cs) / 2 as text
						log buttonxCoordinate
						set buttonyCoordinate to (item 2 of cp) + (item 2 of cs) / 2 as text
						log buttonyCoordinate
						my clickScreenPoint(cliclickPath, buttonxCoordinate, buttonyCoordinate)
					else
						return "ERROR : check box is already unchecked!"
					end if
				end if
				
			end tell
		end tell
		
	end try
end checkuncheckcheckbox1

on selectPopupMenuOption(appname, AXIdentifier, AXDescription, optionToSelect)
	set resultOfFind to findIfControlFound(appname, AXIdentifier, AXDescription)
	if (resultOfFind = true) then
		set element_AXRoleDescription to "AXRoleDescription"
		set AXRoleDescription to "pop up button"
		
		
		set iscontrol to "0"
		set controlfound to "1"
		
		if (AXIdentifier is not equal to "var_" & "AXIdentifier") then
			set searchAttribute_value to AXIdentifier
			set searchAttribute_name to "AXIdentifier"
		else if (AXDescription is not equal to "var_" & "AXDescription") then
			set searchAttribute_value to AXDescription
			set searchAttribute_name to "AXDescription"
		else
			return "Search attribute is not given for AXIdentifier or AXDescription"
		end if
		if (optionToSelect is equal to "") then
			return "Please provide the option to select in Pop up menu!"
		end if
		
		try
			tell application appname
				activate
			end tell
			tell application "System Events"
				tell process appname
					set theWindows to every window -- get a list of windows
					repeat with theWindow in theWindows
						set tElements to entire contents of theWindow
						repeat with tElement in tElements
							if (value of attribute element_AXRoleDescription of tElement is equal to AXRoleDescription) then
								if (exists attribute searchAttribute_name of tElement) then
									if (value of attribute searchAttribute_name of tElement is equal to searchAttribute_value) then
										click tElement
										(* removed the below delays as this was resulting in huge delay on every execution *)
										(* delay 0.1 *)
										keystroke optionToSelect
										(* delay 0.1 *)
										set menuItemTitles to name of menu items of menu 1 of tElement
										if optionToSelect is in menuItemTitles then
											click menu item optionToSelect of menu 1 of tElement
											return "Control found and executed the task"
										else
											key code 53
											return "ERROR : Control found but not the given option in popup menu"
										end if
										set iscontrol to controlfound
										exit repeat
									end if
								end if
							end if
						end repeat
						if iscontrol is equal to controlfound then exit repeat
					end repeat
					if iscontrol is equal to controlfound then
						return "Control found and executed the task"
					else
						return "ERROR : Control not found with given search properties!!"
					end if
				end tell
			end tell
		end try
	else
		return "ERROR : Control not found with given search properties!!"
	end if
end selectPopupMenuOption

on selectComboBoxListItem(appname, theWindowNumber, theControlNumber, optionToSelect, cliclickPath)
	try
		tell application appname
			activate
		end tell
		tell application "System Events"
			tell process appname
				set theControls to entire contents of window theWindowNumber
				set mycombo to the item theControlNumber of theControls
				set currentList to value of text fields of list 1 of scroll area 1 of mycombo
				
				set p to position of button of mycombo
				set s to size of button of mycombo
				set cp to position of mycombo
				set cs to size of mycombo
				
				set buttonxCoordinate to (item 1 of item 1 of p) + (item 1 of item 1 of s) / 2 as text
				log buttonxCoordinate
				set buttonyCoordinate to (item 2 of item 1 of p) + (item 2 of item 1 of s) / 2 as text
				log buttonyCoordinate
				my clickScreenPoint(cliclickPath, buttonxCoordinate, buttonyCoordinate)
				
				if currentList contains optionToSelect then
					set xCoordinate to (item 1 of cp) + (item 1 of cs) / 2 as text
					set yCoordinate to (item 2 of cp) + (item 2 of cs) / 2 as text
					my tripleClickOnScreenPoint(cliclickPath, xCoordinate, yCoordinate)
					
					keystroke optionToSelect
					keystroke return
					return "task is complete"
					(* click button 1 of mycombo collapsing menu is not working need to be look into this*)
					(* set value of mycombo to optionToSelect *)
				else
					(* click button 1 of mycombo *)
					return "ERROR : value is not present in the list"
				end if
			end tell
		end tell
	end try
end selectComboBoxListItem

on selectOptionFromComboBox(appname, AXIdentifier, AXDescription, optionToSelect, strictSelection, cliclickPath)
	
	set resultOfFind to findIfControlFound(appname, AXIdentifier, AXDescription)
	if (resultOfFind = true) then
		
		set element_AXRoleDescription to "AXRoleDescription"
		set AXRoleDescription to "combo box"
		
		if (AXIdentifier is not equal to "var_" & "AXIdentifier") then
			set searchAttribute_value to AXIdentifier
			set searchAttribute_name to "AXIdentifier"
		else if (AXDescription is not equal to "var_" & "AXDescription") then
			set searchAttribute_value to AXDescription
			set searchAttribute_name to "AXDescription"
		else
			return "Search attribute is not given for AXIdentifier or AXDescription"
		end if
		if (optionToSelect is equal to "") then
			return "Please provide the option to select in Pop up menu!"
		end if
		
		try
			tell application appname
				activate
			end tell
			tell application "System Events"
				tell process appname
					set theWindowNumber to 0
					set theWindows to every window -- get a list of windows
					set iscontrolfound to false
					
					repeat with theWindow in theWindows
						set theWindowNumber to theWindowNumber + 1
						(* log "this window number is : " & theWindowNumber *)
						
						set tElements to entire contents of theWindow
						set theControlNumber to 0
						(* set tElements to every combo box of theWindow *)
						repeat with tElement in tElements
							set theControlNumber to theControlNumber + 1
							if class of tElement is combo box then
								if (exists attribute searchAttribute_name of tElement) then
									if (value of attribute searchAttribute_name of tElement is equal to searchAttribute_value) then
										(* log "Window number is : " & theWindowNumber & " Control number is : " & theControlNumber *)
										set iscontrolfound to true
										
										set p to position of tElement
										log p
										set s to size of tElement
										
										if strictSelection is equal to true then
											click button of tElement
										else
											set xCoordinate to (item 1 of p) + (item 1 of s) / 2 as text
											set yCoordinate to (item 2 of p) + (item 2 of s) / 2 as text
											log xCoordinate & yCoordinate
											
											my tripleClickOnScreenPoint(cliclickPath, xCoordinate, yCoordinate)
											keystroke optionToSelect
											keystroke return
											return "task is complete"
											
											(* set value of tElement to optionToSelect *)
										end if
										
										exit repeat
									end if
								end if
							end if
						end repeat
						(* log "is control value is : " & iscontrolfound *)
						if iscontrolfound is equal to true then exit repeat
					end repeat
					if iscontrolfound is equal to true then
						return "Control found and executed the task"
					else
						return "ERROR : Control not found with given search properties!!"
					end if
				end tell
			end tell
		end try
		(* log "final Window number is : " & theWindowNumber & " Control number is : " & theControlNumber *)
		if strictSelection is equal to true then
			selectComboBoxListItem(appname, theWindowNumber, theControlNumber, optionToSelect, cliclickPath)
		end if
		
		
	else
		return "ERROR : Control not found with given search properties!!"
	end if
	
	
end selectOptionFromComboBox

on clickuielement(appname, AXIdentifier, AXDescription, cliclickPath)
	set resultOfFind to findIfControlFound(appname, AXIdentifier, AXDescription)
	if (resultOfFind = true) then
		if (AXIdentifier is not equal to "var_" & "AXIdentifier") then
			set searchAttribute_value to AXIdentifier
			set searchAttribute_name to "AXIdentifier"
		else if (AXDescription is not equal to "var_" & "AXDescription") then
			set searchAttribute_value to AXDescription
			set searchAttribute_name to "AXDescription"
		else
			return "Search attribute is not given for AXIdentifier or AXDescription"
		end if
		try
			tell application appname
				activate
			end tell
			tell application "System Events"
				tell process appname
					set theWindowNumber to 0
					set theWindows to every window -- get a list of windows
					set iscontrolfound to false
					
					repeat with theWindow in theWindows
						set theWindowNumber to theWindowNumber + 1
						(* log "this window number is : " & theWindowNumber *)
						
						set tElements to entire contents of theWindow
						set theControlNumber to 0
						
						repeat with tElement in tElements
							set theControlNumber to theControlNumber + 1
							if (exists attribute searchAttribute_name of tElement) then
								if (value of attribute searchAttribute_name of tElement is equal to searchAttribute_value) then
									(* log "Window number is : " & theWindowNumber & " Control number is : " & theControlNumber *)
									set iscontrolfound to true
									
									set p to position of tElement
									set s to size of tElement
									
									set xCoordinate to (item 1 of p) + (item 1 of s) / 2 as text
									set yCoordinate to (item 2 of p) + (item 2 of s) / 2 as text
									log xCoordinate & yCoordinate
									
									my clickScreenPoint(cliclickPath, xCoordinate, yCoordinate)
									
									exit repeat
								end if
							end if
						end repeat
						if iscontrolfound is equal to true then exit repeat
					end repeat
					if iscontrolfound is equal to true then
						return "Control found and executed the task"
					else
						return "ERROR : Control not found with given search properties!!"
					end if
				end tell
			end tell
		end try
	else
		return "ERROR : Control not found with given search properties!!"
	end if
end clickuielement

on checkuncheckcheckbox(appname, AXIdentifier, AXDescription, checkuncheck, cliclickPath)
	set resultOfFind to findIfControlFound(appname, AXIdentifier, AXDescription)
	if (resultOfFind = true) then
		if (AXIdentifier is not equal to "var_" & "AXIdentifier") then
			set searchAttribute_value to AXIdentifier
			set searchAttribute_name to "AXIdentifier"
		else if (AXDescription is not equal to "var_" & "AXDescription") then
			set searchAttribute_value to AXDescription
			set searchAttribute_name to "AXDescription"
		else
			return "Search attribute is not given for AXIdentifier or AXDescription"
		end if
		try
			tell application appname
				activate
			end tell
			tell application "System Events"
				tell process appname
					set theWindowNumber to 0
					set theWindows to every window -- get a list of windows
					set iscontrolfound to false
					
					repeat with theWindow in theWindows
						set theWindowNumber to theWindowNumber + 1
						(* log "this window number is : " & theWindowNumber *)
						
						set tElements to entire contents of theWindow
						set theControlNumber to 0
						
						repeat with tElement in tElements
							set theControlNumber to theControlNumber + 1
							if class of tElement is checkbox then
								if (exists attribute searchAttribute_name of tElement) then
									if (value of attribute searchAttribute_name of tElement is equal to searchAttribute_value) then
										(* log "Window number is : " & theWindowNumber & " Control number is : " & theControlNumber *)
										set iscontrolfound to true
										
										if (checkuncheck) then
											if not (value of tElement as boolean) then
												set p to position of tElement
												set s to size of tElement
												
												set xCoordinate to (item 1 of p) + (item 1 of s) / 2 as text
												set yCoordinate to (item 2 of p) + (item 2 of s) / 2 as text
												log xCoordinate & yCoordinate
												
												my clickScreenPoint(cliclickPath, xCoordinate, yCoordinate)
											else
												return "ERROR : check box is already checked!"
											end if
										else
											if (value of tElement as boolean) then
												set p to position of tElement
												set s to size of tElement
												
												set xCoordinate to (item 1 of p) + (item 1 of s) / 2 as text
												set yCoordinate to (item 2 of p) + (item 2 of s) / 2 as text
												log xCoordinate & yCoordinate
												
												my clickScreenPoint(cliclickPath, xCoordinate, yCoordinate)
											else
												return "ERROR : check box is already unchecked!"
											end if
										end if
										
										exit repeat
									end if
								end if
							end if
						end repeat
						if iscontrolfound is equal to true then exit repeat
					end repeat
					if iscontrolfound is equal to true then
						return "Control found and executed the task"
					else
						return "ERROR : Control not found with given search properties!!"
					end if
				end tell
			end tell
		end try
	else
		return "ERROR : Control not found with given search properties!!"
	end if
end checkuncheckcheckbox

on editTextField(appname, AXIdentifier, AXDescription, optionToSelect, cliclickPath)
	set resultOfFind to findIfControlFound(appname, AXIdentifier, AXDescription)
	if (resultOfFind = true) then
		if (AXIdentifier is not equal to "var_" & "AXIdentifier") then
			set searchAttribute_value to AXIdentifier
			set searchAttribute_name to "AXIdentifier"
		else if (AXDescription is not equal to "var_" & "AXDescription") then
			set searchAttribute_value to AXDescription
			set searchAttribute_name to "AXDescription"
		else
			return "Search attribute is not given for AXIdentifier or AXDescription"
		end if
		try
			tell application appname
				activate
			end tell
			tell application "System Events"
				tell process appname
					set theWindowNumber to 0
					set theWindows to every window -- get a list of windows
					set iscontrolfound to false
					
					repeat with theWindow in theWindows
						set theWindowNumber to theWindowNumber + 1
						(* log "this window number is : " & theWindowNumber *)
						
						set tElements to entire contents of theWindow
						set theControlNumber to 0
						
						repeat with tElement in tElements
							set theControlNumber to theControlNumber + 1
							if class of tElement is text field then
								if (exists attribute searchAttribute_name of tElement) then
									if (value of attribute searchAttribute_name of tElement is equal to searchAttribute_value) then
										(* log "Window number is : " & theWindowNumber & " Control number is : " & theControlNumber *)
										set iscontrolfound to true
										
										set p to position of tElement
										set s to size of tElement
										
										set xCoordinate to (item 1 of p) + (item 1 of s) / 2 as text
										set yCoordinate to (item 2 of p) + (item 2 of s) / 2 as text
										log xCoordinate & yCoordinate
										
										my tripleClickOnScreenPoint(cliclickPath, xCoordinate, yCoordinate)
										keystroke optionToSelect
										
										exit repeat
									end if
								end if
							end if
						end repeat
						if iscontrolfound is equal to true then exit repeat
					end repeat
					if iscontrolfound is equal to true then
						return "Control found and executed the task"
					else
						return "ERROR : Control not found with given search properties!!"
					end if
				end tell
			end tell
		end try
	else
		return "ERROR : Control not found with given search properties!!"
	end if
end editTextField

on keyPress(cliclickPath, strkey)
	set possibleKeys to {"arrow-down", "arrow-left", "arrow-right", "arrow-up", "delete", "end", "esc", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "f9", "f10", "f11", "f12", "f13", "f14", "f15", "f16", "fwd-delete", "help", "home", "mute", "page-down", "page-up", "return", "space", "tab", "volume-down", "volume-up"}
	
	if possibleKeys contains strkey then
		set myShellScriptCommand to cliclickPath & "kp:" & strkey
		do shell script myShellScriptCommand
	end if
	
end keyPress

on clickScreenPoint(cliclickPath, x, y)
	set myShellScriptCommand to cliclickPath & "c:" & x & "," & y
	do shell script myShellScriptCommand
	return "task is complete"
	
end clickScreenPoint

on moveCursorOnScreenPoint(cliclickPath, x, y)
	set myShellScriptCommand to cliclickPath & "m:" & x & "," & y
	do shell script myShellScriptCommand
	return "task is complete"
	
end moveCursorOnScreenPoint

on doubleClickOnScreenPoint(cliclickPath, x, y)
	set myShellScriptCommand to cliclickPath & "dc:" & x & "," & y
	do shell script myShellScriptCommand
	return "task is complete"
	
end doubleClickOnScreenPoint

on tripleClickOnScreenPoint(cliclickPath, x, y)
	set myShellScriptCommand to cliclickPath & "tc:" & x & "," & y
	log "triple click at : " & x & y
	do shell script myShellScriptCommand
	return "task is complete"
	
end tripleClickOnScreenPoint

on dragAndDropScreenPoints(cliclickPath, x1, y1, x2, y2)
	(* TODO : this is not working need to work on this *)
	set myShellScriptCommand to cliclickPath & "-w 200 c:" & x1 & "," & y1 & "dc:" & x1 & "," & y1 & "wait:500" & "dd:" & x1 & "," & y1 & "wait:500" & "du:" & x1 & "," & y1 & "wait:500" & "dd:" & x1 & "," & y1 & "m:" & x2 & "," & y2 & "du:" & x2 & "," & y2
	do shell script myShellScriptCommand
	return "task is complete"
	
end dragAndDropScreenPoints

on trim_line(this_text, trim_chars, trim_indicator)
	-- 0 = beginning, 1 = end, 2 = both
	set x to the length of the trim_chars
	-- TRIM BEGINNING
	if the trim_indicator is in {0, 2} then
		repeat while this_text begins with the trim_chars
			try
				set this_text to characters (x + 1) thru -1 of this_text as string
			on error
				-- the text contains nothing but the trim characters
				return ""
			end try
		end repeat
	end if
	-- TRIM ENDING
	if the trim_indicator is in {1, 2} then
		repeat while this_text ends with the trim_chars
			try
				set this_text to characters 1 thru -(x + 1) of this_text as string
			on error
				-- the text contains nothing but the trim characters
				return ""
			end try
		end repeat
	end if
	return this_text
end trim_line