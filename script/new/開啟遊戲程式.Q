[General]
SyntaxVersion=2
BeginHotkey=122
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=331b068e-fe58-466f-940a-ea16afe098a6
Description=開啟遊戲程式
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



主機 = Plugin.File.ReadINI("computer", "computer", "C:\lol_local\lol_local.ini")
lol路徑 = "C:\Dropbox\lol\"
自己資料夾路徑 = lol路徑 & 主機 & "\"
status路徑 = 自己資料夾路徑 & 主機 &  ".ini"
開啟遊戲程式所對應的輪班名稱 = dm.ReadIni("子腳本執行設定", "開啟遊戲程式所對應的輪班名稱", status路徑)
ini路徑 = 自己資料夾路徑 & 主機 & " (輪班" & 開啟遊戲程式所對應的輪班名稱 & ").ini"
遊戲編號 = dm.ReadIni("子腳本執行設定", "遊戲編號", status路徑)




//清空腳本屬性
dm.WriteIni "子腳本執行設定", "遊戲編號", "", status路徑
dm.WriteIni "子腳本執行設定", "開啟遊戲程式所對應的輪班名稱", "", status路徑


LockMouse 

/*
//檢查有沒有開啟Forwarder
color = GetPixelColor(304, 1060)
If color = "DCC0A7" Then 
	//沒有開啟Forwarder
	
	//開啟Forwarder
	MoveTo 274, 1060
	Delay 500
	LeftClick 1
	Delay 500
	
	//移動到右上角
	MoveTo 952,483
	Delay 500
	LeftDown 1
	Delay 500
	MoveTo 1797, 16
	Delay 500
	LeftUp 1
	Delay 500
Else 
	//有開啟Forwarder
End If
*/

//關閉該沙盤的所有程式
Rem 關閉該沙盤的所有程式

MoveTo 1734, 1060
Delay 500
RightClick 1
Delay 500
KeyPress "" & 遊戲編號, 1
Delay 500
KeyPress "T", 1
Delay 500


//開啟GGC
KeyPress "Win", 1
Delay 500
KeyPress "Down", 1
Delay 500

For 遊戲編號
	KeyPress "Down", 1
	Delay 500
Next

KeyPress "Enter", 1
Delay 500


Rem 尋找Garena_登入介面

hwnd = dm.FindWindow("Sandbox:Box" & 遊戲編號 & ":UIHOST", "Garena 競時通")

If hwnd = 0 Then 
	//沒找到
	Delay 1000
	Goto 尋找Garena_登入介面
Else
	//找到了
	
	//激活窗口
	dm_ret = dm.SetWindowState(hwnd,1)
	Delay 1000
End If

//移到帳號欄位
MoveTo 940, 425
Delay 500
LeftClick 1
Delay 200
KeyDown "Ctrl", 1
Delay 200
KeyPress "A", 1
Delay 200
KeyUp "Ctrl", 1
Delay 500

//輸入帳號
GGC_帳號 = Plugin.File.ReadINI("GGC_帳號", "game" & 遊戲編號, ini路徑)
Call lib.鍵盤.KeyList(GGC_帳號, 0, 50)


//移到密碼欄位
MoveTo 940, 465
Delay 500
LeftClick 1
Delay 500

//輸入密碼
GGC_密碼 = Plugin.File.ReadINI("GGC_密碼", "game" & 遊戲編號, ini路徑)
Call lib.鍵盤.KeyList(GGC_密碼, 0, 50)

//按登入
MoveTo 842, 614
Delay 500
LeftClick 1
Delay 500



登入時間_起點 = dm.GetTime()


Rem 尋找Garena_主畫面

hwnd = dm.FindWindow("Sandbox:Box" & 遊戲編號 & ":UIHOST", "Garena 競時通 - " & GGC_帳號)

If hwnd = 0 Then 
	//沒找到
	
	//檢查登入時間
	登入時間_目前 = dm.GetTime()
	
	If 登入時間_目前 - 登入時間_起點 >= 15000 Then 
		//超過15秒了
		
		//重新來過
		Goto 關閉該沙盤的所有程式
	Else 
		//還沒超過15秒
	End If
	
	Goto 尋找Garena_主畫面
Else 
	//找到了
	
	//激活窗口
	dm_ret = dm.SetWindowState(hwnd,1)
	Delay 2000
End If


//尋找基準點(英雄聯盟的"英")
FindColor 0, 0, 1920, 1080, "1AF8F8", 基準點_x座標, 基準點_y座標
If 基準點_x座標 > 0 And 基準點_y座標 > 0 Then 
	//有找到
Else 
	//沒有找到
End If

//選英雄聯盟
MoveTo 基準點_x座標 + 24, 基準點_y座標 - 12
Delay 500
LeftClick 1
Delay 3000
//啟動英雄聯盟
MoveTo 基準點_x座標 - 119, 基準點_y座標 + 224
Delay 500
LeftClick 1
Delay 500


/*
Rem 檢查port的顏色

color = GetPixelColor(1758, 62)
If color = "FFFFFF" Then 
Else 
	Goto 檢查port的顏色
End If

//輸入100X3
MoveTo 1758, 62
Delay 500
LeftClick 1
Delay 500
KeyPress "BackSpace", 1
Delay 500
Call lib.鍵盤.KeyList("100" & 遊戲編號 & "3", 0, 50)
KeyPress "Enter", 1
Delay 200
*/


//關掉GGC
MoveTo 基準點_x座標 + 317, 基準點_y座標 - 372
Delay 500
LeftClick 1
Delay 500


UnlockMouse 


//更新"開啟遊戲程式進度"為"開好了"
dm.WriteIni "子腳本執行設定", "開啟遊戲程式進度", "開好了", status路徑