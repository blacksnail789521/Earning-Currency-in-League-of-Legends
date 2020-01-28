[General]
SyntaxVersion=2
BeginHotkey=114
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=d894db23-9afa-487c-8479-01af86caecdb
Description=測試3
Enable=0
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


主機 = Plugin.File.ReadINI("computer", "computer", "C:\lol_local\lol_local.ini")
lol路徑 = Plugin.File.ReadINI("others", "lol", "C:\lol_local\lol_local.ini")
自己資料夾路徑 = Plugin.File.ReadINI("others", "self_folder", "C:\lol_local\lol_local.ini")

/*

ini路徑 = Plugin.File.ReadINI("ini", "ini", "C:\lol_local\lol_local.ini")
lock_1路徑 = Plugin.File.ReadINI("lock", "lock_1", "C:\lol_local\lol_local.ini")
lock_2路徑 = Plugin.File.ReadINI("lock", "lock_2", "C:\lol_local\lol_local.ini")
level路徑 = Plugin.File.ReadINI("level", "level", "C:\lol_local\lol_local.ini")
error路徑 = Plugin.File.ReadINI("error", "error", "C:\lol_local\lol_local.ini")
stop_1_copy_from_路徑 = Plugin.File.ReadINI("stop_copy_from", "stop_1", "C:\lol_local\lol_local.ini")
stop_2_copy_from_路徑 = Plugin.File.ReadINI("stop_copy_from", "stop_2", "C:\lol_local\lol_local.ini")
stop_3_copy_from_路徑 = Plugin.File.ReadINI("stop_copy_from", "stop_3", "C:\lol_local\lol_local.ini")
stop_all_copy_from_路徑 = Plugin.File.ReadINI("stop_copy_from", "stop_all", "C:\lol_local\lol_local.ini")
stop_1_copy_to_路徑 = Plugin.File.ReadINI("stop_copy_to", "stop_1", "C:\lol_local\lol_local.ini")
stop_2_copy_to_路徑 = Plugin.File.ReadINI("stop_copy_to", "stop_2", "C:\lol_local\lol_local.ini")
stop_3_copy_to_路徑 = Plugin.File.ReadINI("stop_copy_to", "stop_3", "C:\lol_local\lol_local.ini")
stop_all_copy_to_路徑 = Plugin.File.ReadINI("stop_copy_to", "stop_all", "C:\lol_local\lol_local.ini")
notepad路徑 = Plugin.File.ReadINI("nodepad", "nodepad", "C:\lol_local\lol_local.ini")

*/

ini路徑 = 自己資料夾路徑 & "lol_" & 主機 & ".ini"
lock_1路徑 = lol路徑 & "others\lock_1.ini"
lock_2路徑 = lol路徑 & "others\lock_2.ini"
level路徑 = lol路徑 & "others\level.ini"
error路徑 = lol路徑 & "others\error.ini"
stop_1_copy_from_路徑 = lol路徑 & "others\stop\stop_1.txt"
stop_2_copy_from_路徑 = lol路徑 & "others\stop\stop_2.txt"
stop_3_copy_from_路徑 = lol路徑 & "others\stop\stop_3.txt"
stop_all_copy_from_路徑 =  lol路徑 & "others\stop\stop_all.txt"
stop_1_copy_to_路徑 = 自己資料夾路徑 & "stop\stop_1.txt"
stop_2_copy_to_路徑 = 自己資料夾路徑 & "stop\stop_2.txt"
stop_3_copy_to_路徑 = 自己資料夾路徑 & "stop\stop_3.txt"
stop_all_copy_to_路徑 = 自己資料夾路徑 & "stop\stop_all.txt"
notepad路徑 = ini路徑 & " - Notepad++ [Administrator]"


TracePrint ini路徑
TracePrint lock_1路徑
TracePrint lock_2路徑
TracePrint level路徑
TracePrint error路徑
TracePrint stop_1_copy_from_路徑
TracePrint stop_2_copy_from_路徑
TracePrint stop_3_copy_from_路徑
TracePrint stop_all_copy_from_路徑
TracePrint stop_1_copy_to_路徑
TracePrint stop_2_copy_to_路徑
TracePrint stop_3_copy_to_路徑
TracePrint stop_all_copy_to_路徑
TracePrint notepad路徑
