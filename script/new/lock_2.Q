[General]
SyntaxVersion=2
BeginHotkey=33
BeginHotkeyMod=8
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=34
StopHotkeyMod=8
RunOnce=1
EnableWindow=
MacroID=b0491b10-15e3-4e07-94f7-5d5b7facfc78
Description=lock_2
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
//大漠一開始的設定
call Plugin.Regdll.reg("c:\game_script\dm.dll")
Set dm = createobject("dm.dmsoft")



lol路徑 = "C:\Dropbox\lol\"
lock_2路徑 = lol路徑 & "others\global_files\lock_2.ini"



//檢查lock_2(只有一台電腦要檢查)
While 1
	Text = dm.ReadIni("lock_2", "lock", lock_2路徑)
	If Text = "released" Then 
		//lock = "released"
	Else 
		//lock = "locked"
		Delay 40000
		dm.WriteIni "lock_2", "lock", "released", lock_2路徑
	End If
Wend