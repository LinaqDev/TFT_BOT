#SingleInstance,Force
SetWorkingDir,%A_ScriptDir%
CoordMode,Mouse,screen
CoordMode,Pixel,screen
Gui, +AlwaysOnTop 
Gui Add, Button, w80, StartPlaying 
Gui Add, Button, w80, Close
Gui, Add, ListView, r20 w700, Time|Description
Gui, Show
return
 
ButtonStartPlaying:
	PlayTFT()
 
	
PlayTFT(){ 
	gameNumber := 0
	Loop
	{
		gameNumber := gameNumber+1
		LogMessage("Game number "+gameNumber)
		Sleep 500
		FindMatch()
	}
}

FindMatch(){
	Loop{
		
	}
}
SearchButtonAndClick(){
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