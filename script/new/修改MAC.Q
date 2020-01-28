[General]
SyntaxVersion=2
BeginHotkey=145
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=17846a0c-9a5f-43a2-bcc3-f5370c1d7abc
Description=修改MAC
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


LockMouse 


//開啟Win7 MAC Address Changer
Rem 開啟Win7_MAC_Address_Changer


KeyPress "Win", 1
Delay 500
KeyPress "Down", 1
Delay 500
KeyPress "Enter", 1
Delay 500


//尋找基準點(Windows Vista)
FindColor 0, 0, 1920, 1080, "D19818", 基準點_x座標, 基準點_y座標
If 基準點_x座標 > 0 And 基準點_y座標 > 0 Then 
	//有找到
Else 
	//沒有找到
	Goto 開啟Win7_MAC_Address_Changer
End If


//選擇"Windows 7"
MoveTo 基準點_x座標 + 38, 基準點_y座標 + 26
Delay 500
LeftClick 1
Delay 500

//選擇"Randomize"
MoveTo 基準點_x座標 + 261, 基準點_y座標 + 39
Delay 500
LeftClick 1
Delay 500

//選擇"Change"
MoveTo 基準點_x座標 + 443, 基準點_y座標 + 107
Delay 500
LeftClick 1
Delay 500

//選擇"確定"(跳出來的視窗)
MoveTo 1115, 591
Delay 500
LeftClick 1
Delay 500

//關閉Win7 MAC Address Changer
MoveTo 基準點_x座標 + 504, 基準點_y座標 - 172
Delay 500
LeftClick 1
Delay 500


//選擇網路
MoveTo 1785, 1059
Delay 500
LeftClick 1
Delay 500

//選擇"開啟網路與共用中心"
MoveTo 1772, 1019
Delay 500
LeftClick 1
Delay 500

//視窗最大化
KeyDown "Win", 1
Delay 100
KeyPress "Up", 1
Delay 100
KeyUp "Win", 1
Delay 500

//選擇"變更介面卡設定"
MoveTo 70, 114
Delay 500
LeftClick 1
Delay 500

//選擇並且按下右鍵"區域網路"
MoveTo 144, 122
Delay 500
LeftClick 1
Delay 500
RightClick 1
Delay 500

//選擇"停用"
MoveTo 225, 135
Delay 500
LeftClick 1
Delay 5000

//選擇並且按下右鍵"區域網路"
MoveTo 144, 122
Delay 500
LeftClick 1
Delay 500
RightClick 1
Delay 500

//選擇"啟用"
MoveTo 225, 135
Delay 500
LeftClick 1
Delay 5000

//關閉"變更介面卡設定"
MoveTo 1902, 9
Delay 500
LeftClick 1
Delay 500


UnlockMouse