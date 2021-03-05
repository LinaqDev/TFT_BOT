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
		;CallSurrender()
		Break
	}
}

FindMatch(){
	Loop{
		firstimage:= SearchButtonAndClick("FindMatch_1.png")
		secondImage:= SearchButtonAndClick("FindMatch_2.png")
		thirdImage:= SearchButtonAndClick("FindMatch_3.png")
		if(firstimage = true)
			 Break
		if(secondImage = true)
			 Break
		if(thirdImage = true)
			 Break
		Sleep 2000
	}
}

CallSurrender(){ 
	firstimage:= SearchButtonAndClick("Surrender_1.png")
	secondImage:= SearchButtonAndClick("Surrender_2.png") 
	
	if(firstimage=true){
		
	}else {
		if(secondImage = true){
			
		}
	}
}
SearchButtonAndClick(path){
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, %path%
	if (ErrorLevel = 2){
		LogMessage("Could not conduct the search")
		return false
	} 
	else if (ErrorLevel = 1){
		LogMessage("Find match button could not be found on the screen.") 
		return false
	} 
	else{
		x := FoundX+50
		y := FoundY+25
		LogMessage("Clicking on find match")
		MouseClick, left, %x%, %y%
		return true
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