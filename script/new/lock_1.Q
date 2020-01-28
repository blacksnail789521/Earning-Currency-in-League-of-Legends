[General]
SyntaxVersion=2
BeginHotkey=36
BeginHotkeyMod=8
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=35
StopHotkeyMod=8
RunOnce=1
EnableWindow=
MacroID=d0d98179-463a-46d0-9b89-aded1754e89f
Description=lock_1
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
lock_1路徑 = lol路徑 & "others\global_files\lock_1.ini"



//檢查lock_1(只有一台電腦要檢查)
While 1
	Text = dm.ReadIni("lock_1", "lock", lock_1路徑)
	If Text = "released" Then 
		//lock = "released"
	Else 
		//lock = "locked"
		Delay 40000
		dm.WriteIni "lock_1", "lock", "released", lock_1路徑
	End If
Wend