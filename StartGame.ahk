#SingleInstance,Force
SetWorkingDir,%A_ScriptDir%
CoordMode,Mouse,screen
CoordMode,Pixel,screen
Gui, +AlwaysOnTop 
Gui Add, Button, w80, StartPlaying
Gui Add, Button, w80, ReloadPlaying
Gui Add, Button, w80, Close
Gui, Add, ListView, r20 w700, Time|Description
Gui, Show
return

ButtonStartPlaying:
	PlayTFT()

ButtonReloadPlaying:
	reload
	
PlayTFT(){
	LogMessage("Starting to play TFT")
	gameNumber := 0
	Loop, 400
	{	
		gameNumber := gameNumber+1
		LogMessage("Game number "+gameNumber)
		Sleep, 100 
			ResetMouse()
		FindMatch() 
			ResetMouse()
		GetGameWindow()
			ResetMouse()
		GetOptionsWindow()
			ResetMouse()
		SurrenderMatch()
			ResetMouse()
		AcceptSurrender()
			ResetMouse()
		CheckForMissionOk()
			ResetMouse()
		PlayAgain()
	} 
}

FindMatch(){
	
	LogMessage("Searching for match")
	found :=0
	Loop, 1000000
	{
		Sleep, 1000 
		LogMessage("Searching for find match image 1") 
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, FindMatch.png
		if (ErrorLevel = 2)
			LogMessage("Could not conduct the search")
		else if (ErrorLevel = 1)
			LogMessage("Find match button could not be found on the screen.") 
		else{
			x := FoundX+100
			y := FoundY+25
			LogMessage("Clicking on find match")
			MouseClick, left, %x%, %y%
			found :=1
			break
		}
		
		Sleep, 1000 
		LogMessage("Searching for find match image 2") 
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, FindMatch2.png
		if (ErrorLevel = 2)
			LogMessage("Could not conduct the search")
		else if (ErrorLevel = 1)
			LogMessage("Find match button could not be found on the screen.") 
		else{
			x := FoundX+100
			y := FoundY+25
			LogMessage("Clicking on find match")
			MouseClick, left, %x%, %y%
			found :=1
			break
		}
		
		Sleep, 1000 
		LogMessage("Searching for find match image 3") 
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, FindMatch3.png
		if (ErrorLevel = 2)
			LogMessage("Could not conduct the search")
		else if (ErrorLevel = 1)
			LogMessage("Find match button could not be found on the screen.") 
		else{
			x := FoundX+100
			y := FoundY+25
			LogMessage("Clicking on find match")
			MouseClick, left, %x%, %y%
			found :=1
			break
		}
		if(found >0)
			break 
	} 
		ResetMouse()
	AcceptMatch()
		ResetMouse()
	CheckIfMatchAccepted()
}

AcceptMatch(){
	LogMessage("Waiting for Accept Button")
	found :=0
	Loop, 1000000
	{
		Sleep, 2000 
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, AcceptButton.png
		if (ErrorLevel = 2)
		{}
		else if (ErrorLevel = 1)
		{}
		else{
			x := FoundX+46
			y := FoundY+15
			LogMessage("Match Found")
			MouseClick, left, %x%, %y%
			found :=1
			break
		}
		if(found >0)
			break 
	}
}

CheckIfMatchAccepted(){
	LogMessage("Checking if game was accepted") 
	Sleep, 30000 
	
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, FindMatch.png
	if (ErrorLevel = 2)
	{}
	else if (ErrorLevel = 1)
	{}
	else{
		x := FoundX+15
		y := FoundY+10
		LogMessage("Match was declined,  Pressing OK and searching again soon.")
		MouseClick, left, %x%, %y% 
		Sleep, 4000 
		FindMatch()
	}
	
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, matchDeclined.png
	if (ErrorLevel = 2)
	{}
	else if (ErrorLevel = 1)
	{}
	else{
		x := FoundX+15
		y := FoundY+10
		LogMessage("Match was declined,  Pressing OK and searching again soon.")
		MouseClick, left, %x%, %y% 
		Sleep, 4000 
		FindMatch()
	}
}

GetGameWindow(){
	LogMessage("Waiting for Game Window")
	found :=0
	Loop, 16
	{
		Sleep, 2000 
		IfWinExist, League of Legends (TM) Client
		{
			LogMessage("Found Game Window")
			WinActivate  ; Automatically uses the window found above. 
			found :=1
			break
		}
		if(found >0)
			break 
	} 
}

GetOptionsWindow(){
	LogMessage("Waiting for Options Window")
	found :=0
	Loop, 10000
	{
		Sleep, 20000  
		Loop,2{
			Send {Escape 1} 
			ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, options.png
			if (ErrorLevel = 2)
			{}
			else if (ErrorLevel = 1)
			{}
			else{ 
				LogMessage("Options Found") 
				found :=1
				break
			}
		} 
		if(found >0)
			break 
	}
}

SurrenderMatch(){
	LogMessage("Waiting for Surrender") 
	found :=0
	Loop, 10000
	{
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, surrender.png
		if (ErrorLevel = 2)
		{}
		else if (ErrorLevel = 1)
		{}
		else{
			x := FoundX+46
			y := FoundY+15
			LogMessage("Clicking on Surrender")
			MouseClick, left, %x%, %y%
			found :=1
			break
		}
		if(found >0)
			break 
		Sleep, 60000 
	} 
}

AcceptSurrender(){
	Sleep, 2000 
	LogMessage("Trying to accept surrender.") 
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, surrender2.png
		if (ErrorLevel = 2)
		{}
		else if (ErrorLevel = 1)
		{}
		else{
			x := FoundX+46
			y := FoundY+20
			LogMessage("Clicking on Surrender")
			MouseClick, left, %x%, %y%
		}
}

PlayAgain(){
	LogMessage("Waiting for play again") 
	found :=0
	Loop, 5000
	{
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, playAgain.png
		if (ErrorLevel = 2)
		{}
		else if (ErrorLevel = 1)
		{}
		else{
			x := FoundX+46
			y := FoundY+15
			LogMessage("Clicking on play again")
			MouseClick, left, %x%, %y%
			found :=1
			break
		}
		if(found >0)
			break 
		Sleep, 60000 
	} 
}

CheckForMissionOk(){
	LogMessage("Check For Mission Ok") 
	Sleep, 20000  
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, missionOk.png
	if (ErrorLevel = 2)
	{
		LogMessage("Mission not found") 
	}
	else if (ErrorLevel = 1)
	{
		LogMessage("Mission not found") 
	}
	else{
		LogMessage("Mission found") 
		x := FoundX+22
		y := FoundY+10
		LogMessage("Clicking on play again")
		MouseClick, left, %x%, %y%
		CheckForMissionOk()
	}
}

ResetMouse(){
	MouseMove, 200, 100
	Sleep, 1000 
}

LogMessage(TextToLog){
	FormatTime, TimeString,, Time
	LV_Add("", TimeString, TextToLog)
	LV_Modify( LV_GetCount(), "Vis" ) ; make the last line visible, scrolling if necessary
}

GuiClose:
ButtonClose:
ExitApp
