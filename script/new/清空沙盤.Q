[General]
SyntaxVersion=2
BeginHotkey=45
BeginHotkeyMod=8
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=0606f6ac-55f1-48d2-bbce-2ceba16145a9
Description=清空沙盤
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



主機 = Plugin.File.ReadINI("computer", "computer", "C:\lol_local\lol_local.ini")

If 主機 = "01-gin" or 主機 = "02-gin_bonus" or 主機 = "06-carol_lab" Then 
	遊戲編號上限 = 3
Else
	遊戲編號上限 = 5
End If

If 主機 = "01-gin" Then 
	主機_settings = "Gin"
ElseIf 主機 = "02-gin_bonus" Then
	主機_settings = "Gin_bonus"
ElseIf 主機 = "03-gin_bonus_2" Then
	主機_settings = "Gin_bonus_2"
ElseIf 主機 = "04-gin_bonus_3" Then
	主機_settings = "Gin_bonus_3"
ElseIf 主機 = "05-gin_bonus_4" Then
	主機_settings = "Gin_bonus_4"
ElseIf 主機 = "06-carol_lab" Then
	主機_settings = "Carol_lab"
ElseIf 主機 = "07-carol" Then
	主機_settings = "Carol"
End If





LockMouse


//關閉所有程式(沙盤的程式以及其他的程式)
Rem 關閉所有程式 


//關掉所有沙盤的程式
MoveTo 1734, 1060
Delay 500
RightClick 1
Delay 500
KeyPress "A", 1
Delay 500


//檢查是否有沙盤的視窗存在(包括通知)
Rem 檢查是否有沙盤的視窗存在
	
color = GetPixelColor(428, 1060)
If color = "DCC0A7" Then 
	//沒有沙盤的視窗了
Else 
	//還有沙盤的視窗
	
	//關閉沙盤的視窗
	MoveTo 398, 1060
	Delay 500
	RightClick 1
	Delay 500
	MoveTo 398, 1023
	Delay 500
	LeftClick 1
	Delay 500
	
	Goto 檢查是否有沙盤的視窗存在
End If


//依序刪除沙盤內容
遊戲編號 = 1

For 遊戲編號上限

	MoveTo 1734, 1060
	Delay 500
	RightClick 1
	Delay 500
	KeyPress "" & 遊戲編號, 1
	Delay 500
	KeyPress "D", 1
	Delay 500
	
	color = GetPixelColor(835, 475)
	If color = "FFFFFF" Then 
		//沒有需要刪除的內容
		
		//按下"確定"
		MoveTo 1034,566
		Delay 500
		LeftClick 1
		Delay 500	
	Else 
		//有需要刪除的內容
		
		//刪除沙盤內容
		KeyDown "Alt", 1
		Delay 100
		KeyPress "D", 1
		Delay 100
		KeyUp "Alt", 1
		Delay 1000
	End If
	
	
	遊戲編號 = 遊戲編號 + 1
	
Next

/*
//修改port

//開啟各沙盤的檔案總管
遊戲編號 = 1

For 遊戲編號上限

	MoveTo 1734, 1060
	Delay 500
	RightClick 1
	Delay 500
	KeyPress "" & 遊戲編號, 1
	Delay 500
	KeyPress "W", 1
	Delay 500
	
	遊戲編號 = 遊戲編號 + 1
	
Next


//關掉所有沙盤的程式(也就是剛剛開啟的所有檔案總管)
MoveTo 1734, 1060
Delay 500
RightClick 1
Delay 500
KeyPress "A", 1
Delay 500


//複製"drive"資料夾到各個沙盤
遊戲編號 = 1

For 遊戲編號上限
	
	//先創建好資料夾
	Call Plugin.File.CreateFolder("C:\Sandbox\" & 主機_settings & "\Box" & 遊戲編號 & "\drive")
	Call Plugin.File.CreateFolder("C:\Sandbox\" & 主機_settings & "\Box" & 遊戲編號 & "\drive\C")
	Call Plugin.File.CreateFolder("C:\Sandbox\" & 主機_settings & "\Box" & 遊戲編號 & "\drive\C\Program Files (x86)")
	Call Plugin.File.CreateFolder("C:\Sandbox\" & 主機_settings & "\Box" & 遊戲編號 & "\drive\C\Program Files (x86)\GarenaLoLTW")
	Call Plugin.File.CreateFolder("C:\Sandbox\" & 主機_settings & "\Box" & 遊戲編號 & "\drive\C\Program Files (x86)\GarenaLoLTW\GameData")
	Call Plugin.File.CreateFolder("C:\Sandbox\" & 主機_settings & "\Box" & 遊戲編號 & "\drive\C\Program Files (x86)\GarenaLoLTW\GameData\Apps")
	Call Plugin.File.CreateFolder("C:\Sandbox\" & 主機_settings & "\Box" & 遊戲編號 & "\drive\C\Program Files (x86)\GarenaLoLTW\GameData\Apps\LoLTW")
	
	//複製"launcher_config.xml"
	Call Plugin.File.CopyFile("C:\Dropbox\lol\others\settings\100" & 遊戲編號 & "3\launcher_config.xml", "C:\Sandbox\" & 主機_settings & "\Box" & 遊戲編號 & "\drive\C\Program Files (x86)\GarenaLoLTW\GameData\Apps\LoLTW\launcher_config.xml")
	
	遊戲編號 = 遊戲編號 + 1
	
Next
*/


UnlockMouse