[General]
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=2282abe7-6c8b-4086-8d64-91ba24856bc5
Description=檢查teamviewer視窗
Enable=1
AutoRun=0
[Repeat]
Type=0
Number=1
[SetupUI]
Type=2
QUI=
[Relative]
SetupOCXFile=
[Comment]

[Script]
//延遲五秒
Delay 5000

IfColor 118, 1060, "DCC0A7", 0 Then
	//沒有teamviewer的視窗
Else 
	//有teamviewer的視窗
	
	LockMouse
	
	//先確定視窗有置頂
	MoveTo 88, 1060
	Delay 500
	LeftClick 1
	Delay 500
	
	//按右下角的確定
	MoveTo 1146, 581
	Delay 500
	LeftClick 1
	Delay 500
	
	UnlockMouse 
	
End If