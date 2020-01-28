[General]
SyntaxVersion=2
BeginHotkey=114
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=119
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=b64bedf9-32c7-413e-bceb-05bcb2bf21b9
Description=03遊戲完整版
Enable=1
AutoRun=0
[Repeat]
Type=0
Number=1
[SetupUI]
Type=1
QUI=Form1
[Relative]
SetupOCXFile=
[Comment]

[Script]
//大漠一開始的設定
call Plugin.Regdll.reg("c:\game_script\dm.dll")
Set dm = createobject("dm.dmsoft")



//設定主機, lol路徑, 自己資料夾路徑, ini路徑, level路徑, notepad路徑, IP路徑, 遊戲編號, 沙盤編號, 遊戲大廳, 遊戲主程式
主機 = dm.ReadIni("computer", "computer", "C:\lol_local\lol_local.ini")
lol路徑 = "C:\Dropbox\lol\"
自己資料夾路徑 = lol路徑 & 主機 & "\"
ini路徑 = 自己資料夾路徑 & 主機 & ".ini"
level路徑 = lol路徑 & "others\level.ini"
notepad路徑 = ini路徑 & " - Notepad++ [Administrator]"
IP路徑 = 自己資料夾路徑 & "IP\"
gameplay_limit路徑 = lol路徑 & "others\gameplay_limit.ini"
遊戲編號 = dm.ReadIni("子腳本執行設定", "遊戲編號", ini路徑)
sandbox = 遊戲編號
遊戲大廳 = "Sandbox:Box" & sandbox & ":ApolloRuntimeContentWindow"
遊戲主程式 = "Sandbox:Box" & sandbox & ":RiotWindowClass"


//清空腳本屬性
dm.DeleteIni "子腳本執行設定", "遊戲編號", ini路徑


//綁定遊戲大廳
Rem 綁定遊戲大廳_遊戲開始
//找到遊戲大廳的窗口句柄
hwnd = dm.FindWindow(遊戲大廳, "PVP.net 用戶端")


//一定要找到窗口才要激活以及綁定
If hwnd = 0 Then 
	Delay 1000
	Goto 綁定遊戲大廳_遊戲開始
Else 
	//獲得最上層的視窗的句柄
	//最上層的視窗 = dm.GetForegroundWindow()
End If


//激活窗口並綁定
dm_ret = dm.SetWindowState(hwnd,1)
dm_ret = dm.BindWindow(hwnd, "normal", "dx", "dx", 2)



//激活原本最上層的視窗
//dm_ret = dm.SetWindowState(最上層的視窗, 12)


//還有一件事
dm.MoveTo 632, 625
Delay 200
dm.LeftClick
Delay 500

//好
dm.MoveTo 635, 547
Delay 200
dm.LeftClick
Delay 500

//按海克斯科技叉叉
dm.MoveTo 1239, 91
Delay 200
dm.LeftClick
Delay 200

//按左上角的英雄聯盟返回大廳
dm.MoveTo 401-320, 160-116
Delay 200
dm.LeftClick
Delay 500




''''''''''''''''''''''''''''''''''腳本重新開始的起點''''''''''''''''''''''''''''''''''
Rem 腳本重新開始的起點


//在遊戲大廳
dm.WriteIni "LOL_運行狀態", "game" & 遊戲編號, "遊戲大廳", ini路徑



//確認是否在大廳
Rem 確認是否在大廳
color = Plugin.Bkgnd.GetPixelColor(hwnd, 618, 16)
If color = "1F6EE2" Then 
	//關掉軍團以及聊天視窗
	dm.MoveTo 174, 777
	Delay 200
	dm.LeftClick
	Delay 200
	dm.MoveTo 174, 777
	Delay 200
	dm.LeftClick
	Delay 200
	Goto 確認是否購買希維爾
Else 
	Delay 200
	Goto 確認是否在大廳
End If



//確認是否購買希維爾
Rem 確認是否購買希維爾
購買希維爾 = dm.ReadIni("遊戲" & 遊戲編號 & "_新手訓練營_購買希維爾", "購買希維爾", ini路徑)
If 購買希維爾 = "O" Then
	Goto 已經購買希維爾
Else 
	//要先確認是不是6等才決定要不要買希維爾
	Goto 確認是否6等
End If



//確認是否6等
Rem 確認是否6等
六等 = dm.ReadIni("LOL_等級", "game" & 遊戲編號, ini路徑)
If 六等 = "6" Then 
	Goto 準備購買希維爾
Else 
	Goto 不是六等
End If



//準備購買希維爾
Rem 準備購買希維爾



//確認是否在商城
Rem 確認是否在商城

dm.MoveTo 876, 51
Delay 200
dm.LeftClick 
Delay 5000

color = Plugin.Bkgnd.GetPixelColor(hwnd, 490, 120)
If color = "0A0803" Then
Else 
	Goto 確認是否在商城
End If


//按英雄
dm.MoveTo 97, 116
Delay 200
dm.LeftClick
Delay 3000
//按搜尋
dm.MoveTo 66, 172
Delay 200
dm.LeftClick
Delay 2000
//輸入希維爾
dm_ret = dm.SendString(hwnd, "希維爾")
Delay 200
//按Enter
dm.KeyPress 13
Delay 2000
//點擊英雄
dm.MoveTo 331, 253
Delay 200
dm.LeftClick
Delay 2000
//按確認
dm.MoveTo 728, 504
Delay 200
dm.LeftClick
Delay 2000
//按完成
dm.MoveTo 573, 474
Delay 200
dm.LeftClick
Delay 2000
//按左上角的英雄聯盟返回大廳
dm.MoveTo 401-320, 160-116
Delay 200
dm.LeftClick
Delay 500
//更新"購買希維爾"為O
dm.WriteIni "遊戲" & 遊戲編號 & "_新手訓練營_購買希維爾", "購買希維爾", "O", ini路徑


Rem 不是六等

Rem 已經購買希維爾



//開始配對
dm.MoveTo 952-320, 154-116
Delay 300
dm.LeftClick
Delay 300
//檢查是否有訊息擋住"玩家vs電腦"
color = Plugin.Bkgnd.GetPixelColor(hwnd, 198, 154)
If color = "3E2719" Then 
	//TracePrint "沒被擋住"
Else 
	//TracePrint "被擋住了"
	dm.MoveTo 263, 40
	Delay 200
	dm.LeftClick 
	Delay 500
End If
//加倍結束，按叉叉
dm.MoveTo 1037, 117
Delay 300
dm.LeftClick
Delay 300
//選玩家VS電腦
dm.MoveTo 326, 176
Delay 300
dm.LeftClick
Delay 300
//選一般對戰
dm.MoveTo 498, 149
Delay 300
dm.LeftClick
Delay 300
//選召喚峽谷
dm.MoveTo 725, 156
Delay 300
dm.LeftClick
Delay 300
//選"初階"電腦
dm.MoveTo 859, 178
Delay 300
dm.LeftClick
Delay 300
dm.MoveTo 749, 709
Delay 300
dm.LeftClick
Delay 300



//LOL_運行狀態改成"等待配對"
Text = dm.ReadIni("LOL_運行狀態", "game" & 遊戲編號, ini路徑)
If Text = "等待配對" Then 
Else 
	dm.WriteIni "LOL_運行狀態", "game" & 遊戲編號, "等待配對", ini路徑
End If



//等待配對(檢查聯盟幣是不是暗的)
Rem 等待配對

color = Plugin.Bkgnd.GetPixelColor(hwnd, 1039, 25)
If color = "03033F" Then
	dm.MoveTo 865-320, 556-116
	Delay 200
    dm.LeftClick
	Delay 200
Else 
	Delay 200
	Goto 等待配對
End If



//LOL_運行狀態改成"已經按確認"
Text = dm.ReadIni("LOL_運行狀態", "game" & 遊戲編號, ini路徑)
If Text = "已經按確認" Then 
Else 
	dm.WriteIni "LOL_運行狀態", "game" & 遊戲編號, "已經按確認", ini路徑
End If



//已經按確認(檢查聯盟幣是不是暗的)
Rem 已經按確認

color = Plugin.Bkgnd.GetPixelColor(hwnd, 1039, 25)
If color = "03033F" Then 
	dm.MoveTo 865-320, 556-116
	Delay 200
    dm.LeftClick
	Delay 1000
	Goto 已經按確認
Else 
	Delay 3000
End If



//召喚師技能2是不是治癒
t0 = dm.GetTime()

Do While 1
	color = Plugin.Bkgnd.GetPixelColor(hwnd, 667, 514)	
	If color = "5FD17E" Then
		Exit Do
	End If
	
	t1 = dm.GetTime()	
	If t1 - t0 > 2000 Then 
		Goto 等待配對
	End If
	
	Delay 100
Loop



//選擇英雄中
dm.WriteIni "LOL_運行狀態", "game" & 遊戲編號, "選擇英雄中", ini路徑



//進入選角
Rem 進入選角

英雄1 = ""
英雄2 = ""
英雄3 = ""
喊路1 = ""
喊路2 = ""


//喊路
亂數1 = 產生亂數(1, 20)
亂數2 = 產生亂數(1, 20)

Call 喊路1_列表()
Call 喊路2_列表()

//喊路1
dm.MoveTo 637-320, 854-116
Delay 200
dm.LeftClick
Delay 200
dm_ret = dm.SendString(hwnd, 喊路1)
Delay 200
dm.KeyPress 13
Delay 600


Dim 可以選的英雄(5)

//選英雄
英雄1編號 = 產生亂數(0, 4)


英雄2編號 = 產生亂數(0, 4)
While (英雄2編號 = 英雄1編號)
	英雄2編號 = 產生亂數(0, 4)
Wend

英雄3編號 = 產生亂數(0, 4)
While (英雄3編號 = 英雄1編號 or 英雄3編號 = 英雄2編號)
	英雄3編號 = 產生亂數(0, 4)
Wend

英雄4編號 = 產生亂數(0, 4)
While (英雄4編號 = 英雄1編號 or 英雄4編號 = 英雄2編號 or 英雄4編號 = 英雄3編號)
	英雄4編號 = 產生亂數(0, 4)
Wend

英雄5編號 = 產生亂數(0, 4)
While (英雄5編號 = 英雄1編號 or 英雄5編號 = 英雄2編號 or 英雄5編號 = 英雄3編號 or 英雄5編號 = 英雄4編號)
	英雄5編號 = 產生亂數(0, 4)
Wend

Text = dm.ReadIni("遊戲" & 遊戲編號 & "_新手訓練營_購買希維爾", "購買希維爾", ini路徑)
If Text = "O" Then 
	//不是新手帳號
	Call 英雄列表()
Else 
	//新手帳號
	Call 英雄列表_新手帳號()
End If



//英雄1
//移到輸入角色的視窗
dm.MoveTo 1223-320, 249-116
Delay 500
dm.LeftClick
Delay 500
//打英雄名字
dm_ret = dm.SendString(hwnd, 英雄1)
Delay 500
//選擇英雄
dm.MoveTo 643-320, 330-116
Delay 500
dm.LeftClick
Delay 500
//鎖定英雄
dm.MoveTo 1187-320, 625-116
Delay 500
dm.LeftClick
Delay 500


//喊路2
dm.MoveTo 637-320, 854-116
Delay 200
dm.LeftClick
Delay 200
dm_ret = dm.SendString(hwnd, 喊路2)
Delay 200
dm.KeyPress 13
Delay 200


//英雄2
//移到輸入角色的視窗
dm.MoveTo 1223-320, 249-116
Delay 500
dm.LeftClick
Delay 500
//打英雄名字
dm_ret = dm.SendString(hwnd, 英雄2)
Delay 500
//選擇英雄
dm.MoveTo 643-320, 330-116
Delay 500
dm.LeftClick
Delay 500
//鎖定英雄
dm.MoveTo 1187-320, 625-116
Delay 500
dm.LeftClick
Delay 500


//英雄3
//移到輸入角色的視窗
dm.MoveTo 1223-320, 249-116
Delay 500
dm.LeftClick
Delay 500
//打英雄名字
dm_ret = dm.SendString(hwnd, 英雄3)
Delay 500
//選擇英雄
dm.MoveTo 643-320, 330-116
Delay 500
dm.LeftClick
Delay 500
//鎖定英雄
dm.MoveTo 1187-320, 625-116
Delay 500
dm.LeftClick
Delay 500


//英雄4
//移到輸入角色的視窗
dm.MoveTo 1223-320, 249-116
Delay 500
dm.LeftClick
Delay 500
//打英雄名字
dm_ret = dm.SendString(hwnd, 英雄4)
Delay 500
//選擇英雄
dm.MoveTo 643-320, 330-116
Delay 500
dm.LeftClick
Delay 500
//鎖定英雄
dm.MoveTo 1187-320, 625-116
Delay 500
dm.LeftClick
Delay 500


//英雄5
//移到輸入角色的視窗
dm.MoveTo 1223-320, 249-116
Delay 500
dm.LeftClick
Delay 500
//打英雄名字
dm_ret = dm.SendString(hwnd, 英雄5)
Delay 500
//選擇英雄
dm.MoveTo 643-320, 330-116
Delay 500
dm.LeftClick
Delay 500
//鎖定英雄
dm.MoveTo 1187-320, 625-116
Delay 500
dm.LeftClick
Delay 500


//隨機英雄
//選擇英雄
dm.MoveTo 643-320, 330-116
Delay 500
dm.LeftClick
Delay 500
//鎖定英雄
dm.MoveTo 1187-320, 625-116
Delay 500
dm.LeftClick
Delay 500



//選完英雄了
dm.WriteIni "LOL_運行狀態", "game" & 遊戲編號, "選完英雄了", ini路徑





Function 產生亂數(min, max)
	Randomize
	產生亂數 = CInt(Rnd * (max - min) + min)
End Function


//搶中路
Sub 喊路1_列表()
	If 亂數1 = 1 Then 
		喊路1 = "中路拜託"
	ElseIf 亂數1 = 2 Then 
		喊路1 = "我想走中路"
	ElseIf 亂數1 = 3 Then 
		喊路1 = "mid pls"
	ElseIf 亂數1 = 4 Then 
		喊路1 = "中路"
	ElseIf 亂數1 = 5 Then 
		喊路1 = "想走中路"
	ElseIf 亂數1 = 6 Then 
		喊路1 = "想走中路謝謝"
	ElseIf 亂數1 = 7 Then 
		喊路1 = "中路"
	ElseIf 亂數1 = 8 Then 
		喊路1 = "Mid"
	ElseIf 亂數1 = 9 Then 
		喊路1 = "中路拜託喔"
	ElseIf 亂數1 = 10 Then 
		喊路1 = "mid PLS"
	ElseIf 亂數1 = 11 Then 
		喊路1 = "想走中路感激"
	ElseIf 亂數1 = 12 Then 
		喊路1 = "打中路"
	ElseIf 亂數1 = 13 Then 
		喊路1 = "走中路pls"
	ElseIf 亂數1 = 14 Then 
		喊路1 = "中路 中路"
	ElseIf 亂數1 = 15 Then 
		喊路1 = "走中路"
	ElseIf 亂數1 = 16 Then 
		喊路1 = "走中路感謝"
	ElseIf 亂數1 = 17 Then 
		喊路1 = "中"
	ElseIf 亂數1 = 18 Then 
		喊路1 = "想打中路"
	ElseIf 亂數1 = 19 Then 
		喊路1 = "中 謝謝"
	ElseIf 亂數1 = 20 Then 
		喊路1 = "中 感激"
	End If
End Sub

//表示自己是新手
Sub 喊路2_列表()
	If 亂數2 = 1 Then 
		喊路2 = "剛接觸"
	ElseIf 亂數2 = 2 Then 
		喊路2 = "剛接觸喔"
	ElseIf 亂數2 = 3 Then 
		喊路2 = "我是新手"
	ElseIf 亂數2 = 4 Then 
		喊路2 = "我是新手喔"
	ElseIf 亂數2 = 5 Then 
		喊路2 = "新手喔見諒"
	ElseIf 亂數2 = 6 Then 
		喊路2 = "新手見諒"
	ElseIf 亂數2 = 7 Then 
		喊路2 = "新手 剛接觸"
	ElseIf 亂數2 = 8 Then 
		喊路2 = "新手見諒"
	ElseIf 亂數2 = 9 Then 
		喊路2 = "新手喔 多見諒"
	ElseIf 亂數2 = 10 Then 
		喊路2 = "菜鳥~"
	ElseIf 亂數2 = 11 Then 
		喊路2 = "我是新手喔~~"
	ElseIf 亂數2 = 12 Then 
		喊路2 = "很菜喔見諒"
	ElseIf 亂數2 = 13 Then 
		喊路2 = "我很爛喔見諒"
	ElseIf 亂數2 = 14 Then 
		喊路2 = "我很爛喔超級新手"
	ElseIf 亂數2 = 15 Then 
		喊路2 = "超級新手喔見諒"
	ElseIf 亂數2 = 16 Then 
		喊路2 = "剛完不久喔見諒"
	ElseIf 亂數2 = 17 Then 
		喊路2 = "新手新手~"
	ElseIf 亂數2 = 18 Then 
		喊路2 = "我新手多見諒"
	ElseIf 亂數2 = 19 Then 
		喊路2 = "我新手"
	ElseIf 亂數2 = 20 Then 
		喊路2 = "我新手~~"
	End If
End Sub

Sub 英雄列表()
	可以選的英雄(0) = "艾希"
	可以選的英雄(1) = "希維爾"
	可以選的英雄(2) = dm.ReadIni("英雄列表", "英雄3", level路徑)
	可以選的英雄(3) = dm.ReadIni("英雄列表", "英雄4", level路徑)
	可以選的英雄(4) = dm.ReadIni("英雄列表", "英雄5", level路徑)

	英雄1 = 可以選的英雄(英雄1編號)
	英雄2 = 可以選的英雄(英雄2編號)
	英雄3 = 可以選的英雄(英雄3編號)
	英雄4 = 可以選的英雄(英雄4編號)
	英雄5 = 可以選的英雄(英雄5編號)

End Sub


Sub 英雄列表_新手帳號()
	可以選的新手英雄1 = "吉茵珂絲"
	可以選的新手英雄2 = "法洛士"
	可以選的新手英雄3 = "艾希"
	可以選的新手英雄3 = "索拉卡"
	可以選的新手英雄3 = "雷茲"
	
	英雄1 = 可以選的英雄(英雄1編號)
	英雄2 = 可以選的英雄(英雄2編號)
	英雄3 = 可以選的英雄(英雄3編號)
	英雄4 = 可以選的英雄(英雄4編號)
	英雄5 = 可以選的英雄(英雄5編號)
End Sub




//檢查是否跳回大廳(檢查召喚師技能2是不是治癒)
Rem 檢查是否跳回大廳
color = Plugin.Bkgnd.GetPixelColor(hwnd, 667, 514)
If color = "5FD17E" Then 
	Delay 200
	Goto 檢查是否跳回大廳
Else 
	//已經離開選角畫面
	Delay 200
End If



//檢查有沒有人沒選角(檢查有沒有亮的聯盟幣)
Rem 檢查有沒有人沒選角
color = Plugin.Bkgnd.GetPixelColor(hwnd, 1039, 25)
If color = "0000DE" Then 
	Delay 200
	//有人跳game，重新配對
	dm.WriteIni "LOL_運行狀態", "game" & 遊戲編號, "有人跳game，重新配對", ini路徑
	Goto 等待配對
Else 
	Delay 20000
End If




//解除綁定窗口句柄
dm_ret = dm.UnBindWindow()



//接下來就是正式進入遊戲了


Rem 綁定遊戲主程式
//找到遊戲大廳的窗口句柄
hwnd = dm.FindWindow(遊戲主程式, "League of Legends (TM) Client")


//一定要找到窗口才要激活以及綁定
If hwnd = 0 Then 
	Delay 1000
	Goto 綁定遊戲主程式
End If


//激活窗口並綁定
dm_ret = dm.SetWindowState(hwnd,1)
dm_ret = dm.BindWindow(hwnd, "dx", "dx", "dx", 2)




//遊戲主程式載入中
dm.WriteIni "LOL_運行狀態", "game" & 遊戲編號, "遊戲主程式載入中", ini路徑



//初始化顏色變數
Dim color_before_split(6)
Dim color_after_split(6)
顏色是否相似 = True



//檢查是否進入遊戲
Rem 檢查是否進入遊戲
color_before = "473907"
color_after = dm.GetColorBGR(894, 630)
Call 判斷顏色是否相似
//473807
If 顏色是否相似 Then 
LockMouse
Else 
	//取得滑鼠座標
	//GetCursorPos 滑鼠x座標, 滑鼠y座標
	//獲得最上層的視窗的句柄
	//最上層的視窗 = dm.GetForegroundWindow()
	Delay 200
	Goto 檢查是否進入遊戲
End If



'''''''''''''''''''''''''''''''''''''''''''''開始遊戲'''''''''''''''''''''''''''''''''''''''''''''

//遊戲主程式載入成功
dm.WriteIni "LOL_運行狀態", "game" & 遊戲編號, "戰鬥中", ini路徑



//鎖定視角
dm.KeyPress 89
Delay 500



//讓滑鼠可以自由移動
KeyDown "Alt", 1
Delay 200
KeyPress "Tab", 1
Delay 200
KeyUp "Alt", 1
Delay 100
UnlockMouse



//還原滑鼠座標
//MoveTo 滑鼠x座標, 滑鼠y座標


//激活原本最上層的視窗
//dm_ret = dm.SetWindowState(最上層的視窗, 12)




//初始化購買商品的變數

第一個裝備_鞋子 = 產生亂數(22, 28)

第二個裝備 = 產生亂數(1, 21)


第三個裝備 = 產生亂數(1, 21)
While (第三個裝備 = 第二個裝備)
	第三個裝備 = 產生亂數(1, 21)
Wend

第四個裝備 = 產生亂數(1, 21)
While (第四個裝備 = 第二個裝備 or 第四個裝備 = 第三個裝備)
	第四個裝備 = 產生亂數(1, 21)
Wend

第五個裝備 = 產生亂數(1, 21)
While (第五個裝備 = 第二個裝備 or 第五個裝備 = 第三個裝備 or 第五個裝備 = 第四個裝備)
	第五個裝備 = 產生亂數(1, 21)
Wend

//第幾套裝備 = 產生亂數(1, 20)
//Call 裝備列表

裝備 = 1
子裝備 = 0
裝備編號 = 0

三相之力 = 1
嗜血者 = 1
奪魄之鐮 = 1
無盡之刃 = 1
死亡之舞 = 1
黑色切割者 = 1
魔提斯深淵 = 1
暮色黑刃 = 1
冰霜之錘 = 1
智慧末刃 = 1
多明尼克的問候 = 1
致死宣告 = 1
衝擊火砲 = 1
史提克彈簧刀 = 1
芮蘭颶風箭 = 1
幻影之舞 = 1
史特拉克手套 = 1
殞落王者之劍 = 1
妖夢鬼刀 = 1
夜色綠界 = 1
鬼索的狂暴之刃 = 1

輕靈之靴 = 1
狂戰士護脛 = 1
水星之靴 = 1


//初始化左下右上的變數
左下為0右上為1 = 0


//確認起手裝備
起手裝備 = ""
亂數 = 產生亂數(1, 5)
Call 確認起手裝備

Sub 確認起手裝備
	If 亂數 = 1 Then 
		起手裝備 = "多蘭之劍"
	End If
	If 亂數 = 2 Then 
		起手裝備 = "多蘭之劍"
	End If
	If 亂數 = 3 Then 
		起手裝備 = "多蘭之劍"
	End If
	If 亂數 = 4 Then 
		起手裝備 = "多蘭之盾"
	End If
	If 亂數 = 5 Then 
		起手裝備 = "汰除品"
	End If
End Sub



Goto 左下_買起手裝備跟眼_移動到塔前

/*
//確認自己是哪一方
color_before = "8f8965"
color_after = dm.GetColorBGR(859, 700)
Call 判斷顏色是否相似
If 顏色是否相似 Then 
	Delay 200
	Goto 左下_買起手裝備跟眼_移動到塔前
	//TracePrint "左下"
Else 
	Delay 200
	左下為0右上為1 = 1
	Goto 右上_買起手裝備跟眼_移動到塔前
	//TracePrint "右上"
End If
*/



Rem 重新綁定遊戲主程式

//解除綁定
dm_ret = dm.UnBindWindow()
Delay 1000

//找到遊戲大廳的窗口句柄
hwnd = dm.FindWindow(遊戲主程式, "League of Legends (TM) Client")

//一定要找到窗口才要激活以及綁定
If hwnd = 0 Then 
	Delay 1000
	Goto 重新綁定遊戲主程式
End If

//激活窗口並綁定
dm_ret = dm.SetWindowState(hwnd,1)
dm_ret = dm.BindWindow(hwnd, "dx", "dx", "dx", 2)




//左下_買起手裝備跟眼_移動到塔前
Rem 左下_買起手裝備跟眼_移動到塔前

//判斷是否有開起商城
color_before = dm.GetColorBGR(797, 21)

dm.KeyPress 80
Delay 200

color_after = dm.GetColorBGR(797, 21)

Call 判斷顏色是否相似
If 顏色是否相似 Then 
	//沒有開啟商城
	Goto 重新綁定遊戲主程式
Else 
	//有開啟商城
End If

dm.MoveTo 56, 80
Delay 200
dm.LeftClick
Delay 200
dm_ret = dm.SendString2(hwnd, 起手裝備)
Delay 200
dm.MoveTo 91, 118
Delay 200
dm.RightClick
Delay 500
dm.MoveTo 56, 80
Delay 200
dm.LeftClick
Delay 200
dm_ret = dm.SendString2(hwnd, "偵查圖騰")
Delay 200
dm.MoveTo 91, 118
Delay 200
dm.RightClick
Delay 200
dm.KeyPress 80
Delay 11000
//走到塔前
dm.MoveTo 907, 686
Delay 200
dm.RightClick
Delay 200
Delay 80000
Goto 左下_檢查血量

//先檢查有沒有結束遊戲了
Rem 左下_先檢查有沒有結束遊戲了

color_before = "1014b5"
color_after = dm.GetColorBGR(572, 472)
Call 判斷顏色是否相似
If 顏色是否相似 Then 
	Delay 200
	Goto 已經打完了	
Else 
End If


//有大點大
dm.MoveTo 510, 649
Delay 200
dm.LeftClick
Delay 200

//買裝備
Call 買裝備


//左下_是否開始戰鬥了
Rem 左下_是否開始戰鬥了

color = dm.GetColorBGR(607, 737)
If color = "00d700" Then
	//還沒戰鬥
	//TracePrint "還沒戰鬥"
	dm.MoveTo 995, 598
	Delay 100
	dm.KeyPress 65
	Delay 100
	Goto 左下_是否開始戰鬥了
Else 
	//戰鬥了
End If


//左下_檢查血量
Rem 左下_檢查血量

color = dm.GetColorBGR(508, 739)
If color = "08b900" Then
	//TracePrint "血量OK"
Else 
	//TracePrint "血量不OK"
	Goto 左下_血量不OK
End If


//左下_不會被敵人貼臉_1
Rem 左下_不會被敵人貼臉_1
//1a2eac
dm_ret = dm.FindColor(0,137,406,768,"ac2e1a",1.0,0,intX,intY)
If intX > 0 And intY > 0 Then 
	//TracePrint "有敵人!!!(1)"
	dm.MoveTo 854, 737
	Delay 200
	dm.RightClick
	Delay 200
	Goto 左下_檢查血量
Else 
	//TracePrint "沒有敵人!!!"
End If

//左下_不會被敵人貼臉_2
Rem 左下_不會被敵人貼臉_2
//1a2eac
dm_ret = dm.FindColor(0,151,489,768,"ac2e1a",1.0,0,intX,intY)
If intX > 0 And intY > 0 Then 
	//TracePrint "有敵人!!!(2)"
	dm.MoveTo 854, 737
	Delay 200
	dm.RightClick
	Delay 200
	Goto 左下_檢查血量
Else 
	//TracePrint "沒有敵人!!!"
End If

//左下_不會被敵人貼臉_3
Rem 左下_不會被敵人貼臉_3
//1a2eac
dm_ret = dm.FindColor(0,167,576,768,"ac2e1a",1.0,0,intX,intY)
If intX > 0 And intY > 0 Then 
	//TracePrint "有敵人!!!(3)"
	dm.MoveTo 854, 737
	Delay 200
	dm.RightClick
	Delay 200
	Goto 左下_檢查血量
Else 
	//TracePrint "沒有敵人!!!"
End If

//左下_不會被敵人貼臉_4
Rem 左下_不會被敵人貼臉_4
//1a2eac
dm_ret = dm.FindColor(0,210,615,768,"ac2e1a",1.0,0,intX,intY)
If intX > 0 And intY > 0 Then 
	//TracePrint "有敵人!!!(4)"
	dm.MoveTo 854, 737
	Delay 200
	dm.RightClick
	Delay 200
	Goto 左下_檢查血量
Else 
	//TracePrint "沒有敵人!!!"
End If

//左下_不會被敵人貼臉_5
Rem 左下_不會被敵人貼臉_5
//1a2eac
dm_ret = dm.FindColor(0,310,695,768,"ac2e1a",1.0,0,intX,intY)
If intX > 0 And intY > 0 Then 
	//TracePrint "有敵人!!!(5)"
	dm.MoveTo 854, 737
	Delay 200
	dm.RightClick
	Delay 200
	Goto 左下_檢查血量
Else 
	//TracePrint "沒有敵人!!!"
End If


//左下_不要超過小兵
Rem 左下_不要超過小兵
//c18844
dm_ret = dm.FindColor(453,0,1024,323,"4488c1",1.0,0,intX,intY)
If intX > 0 And intY > 0 Then 
	//TracePrint "有minions!!!"
	Goto 左下_可以攻擊了
Else 
	//TracePrint "沒有minions!!!"
	Goto 左下_檢查防禦塔
End If


//左下_檢查防禦塔
Rem 左下_檢查防禦塔
//d6954c
dm_ret = dm.FindColor(0,0,1024,150,"4c95d6",1.0,0,intX,intY)
If intX > 0 And intY > 0 Then 
	//TracePrint "有防禦塔"
	dm.KeyPress 83
Else 
	//TracePrint "沒有防禦塔"
	dm.MoveTo 854, 737
	Delay 100
	dm.RightClick
	Delay 100
	Goto 左下_檢查血量
End If


//左下_可以攻擊了
Rem 左下_可以攻擊了

dm.MoveTo 995, 598
Delay 100
dm.KeyPress 65
Delay 100

Goto 左下_檢查血量


//左下_血量不OK
Rem 左下_血量不OK

//TracePrint "不OK"
dm.MoveTo 840, 754
Delay 100
dm.RightClick
Delay 100
dm.MoveTo 840, 754
Delay 100
dm.RightClick
Delay 100
dm.MoveTo 840, 754
Delay 100
dm.RightClick
Delay 6000



t0 = dm.GetTime()
t1 = dm.GetTime()


//左下_回城
Rem 左下_回城
//1a2eac
dm_ret = dm.FindColor(0,0,1024,768,"ac2e1a",1.0,0,intX,intY)
If intX > 0 And intY > 0 Then 
	//TracePrint "有敵人!!!"
	t2 = dm.GetTime()
	If t2 - t0 >= 60000 Then
		Goto 左下_先檢查有沒有結束遊戲了
	Else
		dm.MoveTo 854, 737
		Delay 200
		dm.RightClick
		Delay 2000
		t1 = dm.GetTime()
		Goto 左下_回城
	End If
Else 
	//TracePrint "沒有敵人!!!"
	t2 = dm.GetTime()
	If t2 - t1 >= 9000 Then
		Goto 左下_先檢查有沒有結束遊戲了
	ElseIf t2 - t1 >= 3000 Then
		Goto 左下_回城
	Else 
		dm.KeyPress 66
		Delay 200
		Goto 左下_回城
	End If
End If








//右上_買起手裝備跟眼_移動到塔前
Rem 右上_買起手裝備跟眼_移動到塔前

dm.KeyPress 80
Delay 200
dm.MoveTo 56, 80
Delay 200
dm.LeftClick
Delay 200
dm_ret = dm.SendString2(hwnd, 起手裝備)
Delay 200
dm.MoveTo 91, 118
Delay 200
dm.RightClick
Delay 500
dm.MoveTo 56, 80
Delay 200
dm.LeftClick
Delay 200
dm_ret = dm.SendString2(hwnd, "偵查圖騰")
Delay 200
dm.MoveTo 91, 118
Delay 200
dm.RightClick
Delay 200
dm.KeyPress 80
Delay 11000
//走到塔前
dm.MoveTo 943, 650
Delay 200
dm.RightClick
Delay 200
Delay 80000
Goto 右上_檢查血量


//右上_先檢查有沒有結束遊戲了
Rem 右上_先檢查有沒有結束遊戲了

color_before = "1014b5"
color_after = dm.GetColorBGR(572, 472)
Call 判斷顏色是否相似
If 顏色是否相似 Then 
	Delay 200
	Goto 已經打完了	
Else 
End If


//有大點大
dm.MoveTo 510, 649
Delay 200
dm.LeftClick
Delay 200


//買裝備
Call 買裝備


//右上_是否開始戰鬥了
Rem 右上_是否開始戰鬥了

color = dm.GetColorBGR(607, 737)
If color = "00d700" Then
	//還沒戰鬥
	//TracePrint "還沒戰鬥"
	dm.MoveTo 854, 737
	Delay 100
	dm.KeyPress 65
	Delay 100
	Goto 右上_是否開始戰鬥了
Else 
	//戰鬥了
End If


//右上_檢查血量
Rem 右上_檢查血量

color = dm.GetColorBGR(508, 739)
If color = "08b900" Then
	//TracePrint "血量OK"
Else 
	//TracePrint "血量不OK"
	Goto 右上_血量不OK
End If


//右上_不會被敵人貼臉_1
Rem 右上_不會被敵人貼臉_1
//1a2eac
dm_ret = dm.FindColor(333,0,1024,229,"ac2e1a",1.0,0,intX,intY)
If intX > 0 And intY > 0 Then 
	//TracePrint "有敵人!!!(1)"
	dm.MoveTo 995, 598
	Delay 200
	dm.RightClick
	Delay 200
	Goto 右上_檢查血量
Else 
	//TracePrint "沒有敵人!!!"
End If

//右上_不會被敵人貼臉_2
Rem 右上_不會被敵人貼臉_2
//1a2eac
dm_ret = dm.FindColor(327,0,1024,312,"ac2e1a",1.0,0,intX,intY)
If intX > 0 And intY > 0 Then 
	//TracePrint "有敵人!!!(2)"
	dm.MoveTo 995, 598
	Delay 200
	dm.RightClick
	Delay 200
	Goto 右上_檢查血量
Else 
	//TracePrint "沒有敵人!!!"
End If

//右上_不會被敵人貼臉_3
Rem 右上_不會被敵人貼臉_3
//1a2eac
dm_ret = dm.FindColor(370,0,1024,417,"ac2e1a",1.0,0,intX,intY)
If intX > 0 And intY > 0 Then 
	//TracePrint "有敵人!!!(3)"
	dm.MoveTo 995, 598
	Delay 200
	dm.RightClick
	Delay 200
	Goto 右上_檢查血量
Else 
	//TracePrint "沒有敵人!!!"
End If

//右上_不會被敵人貼臉_4
Rem 右上_不會被敵人貼臉_4
//1a2eac
dm_ret = dm.FindColor(481,0,1024,474,"ac2e1a",1.0,0,intX,intY)
If intX > 0 And intY > 0 Then 
	//TracePrint "有敵人!!!(4)"
	dm.MoveTo 995, 598
	Delay 200
	dm.RightClick
	Delay 200
	Goto 右上_檢查血量
Else 
	//TracePrint "沒有敵人!!!"
End If

//右上_不會被敵人貼臉_5
Rem 右上_不會被敵人貼臉_5
//1a2eac
dm_ret = dm.FindColor(598,0,1024,514,"ac2e1a",1.0,0,intX,intY)
If intX > 0 And intY > 0 Then 
	//TracePrint "有敵人!!!(5)"
	dm.MoveTo 995, 598
	Delay 200
	dm.RightClick
	Delay 200
	Goto 右上_檢查血量
Else 
	//TracePrint "沒有敵人!!!"
End If


//右上_不要超過小兵
Rem 右上_不要超過小兵

dm_ret = dm.FindColor(0,241,573,768,"4488c1",1.0,0,intX,intY) 
If intX > 0 And intY > 0 Then 
	//TracePrint "有minions!!!"
	Goto 右上_可以攻擊了
Else 
	//TracePrint "沒有minions!!!"
	Goto 右上_檢查防禦塔
End If


//右上_檢查防禦塔
Rem 右上_檢查防禦塔

dm_ret = dm.FindColor(0,100,1024,768,"4c95d6",1.0,0,intX,intY)
If intX > 0 And intY > 0 Then 
	//TracePrint "有防禦塔"
	dm.KeyPress 83
Else 
	//TracePrint "沒有防禦塔"
	dm.MoveTo 995, 598
	Delay 100
	dm.RightClick
	Delay 100
	Goto 右上_檢查血量
End If


//右上_可以攻擊了
Rem 右上_可以攻擊了

dm.MoveTo 854, 737
Delay 100
dm.KeyPress 65
Delay 100

Goto 右上_檢查血量


//右上_血量不OK
Rem 右上_血量不OK

//TracePrint "不OK"
dm.MoveTo 1009, 594
Delay 100
dm.RightClick
Delay 100
dm.MoveTo 1009, 594
Delay 100
dm.RightClick
Delay 100
dm.MoveTo 1009, 594
Delay 100
dm.RightClick
Delay 6000



t0 = dm.GetTime()
t1 = dm.GetTime()

//右上_回城
Rem 右上_回城

dm_ret = dm.FindColor(0,0,1024,768,"ac2e1a",1.0,0,intX,intY)
If intX > 0 And intY > 0 Then 
	//TracePrint "有敵人!!!"
	t2 = dm.GetTime()
	If t2 - t0 >= 60000 Then
		Goto 右上_先檢查有沒有結束遊戲了
	Else
		dm.MoveTo 995, 598
		Delay 200
		dm.RightClick
		Delay 2000
		t1 = dm.GetTime()
		Goto 右上_回城
	End If
Else 
	//TracePrint "沒有敵人!!!"
	t2 = dm.GetTime()
	If t2 - t1 >= 9000 Then 
		Goto 右上_先檢查有沒有結束遊戲了
	ElseIf t2 - t1 >= 3000 Then
		Goto 右上_回城
	Else 
		dm.KeyPress 66
		Delay 200
		Goto 右上_回城
	End If
End If


//已經打完了，準備退出遊戲
Rem 已經打完了


//按確認，退出遊戲
dm.MoveTo 517, 479
Delay 200
dm.LeftClick
Delay 10000

dm_ret = dm.UnBindWindow()


Rem 綁定遊戲大廳_遊戲結束
//找到遊戲大廳的窗口句柄
hwnd = dm.FindWindow(遊戲大廳, "PVP.net 用戶端")


//一定要找到窗口才要激活以及綁定
If hwnd = 0 Then 
	Delay 1000
	Goto 綁定遊戲大廳_遊戲結束
Else 
	//獲得最上層的視窗的句柄
	//最上層的視窗 = dm.GetForegroundWindow()
End If


//激活窗口並綁定
dm_ret = dm.SetWindowState(hwnd,1)
dm_ret = dm.BindWindow(hwnd, "normal", "dx", "dx", 2)


//激活原本最上層的視窗
//dm_ret = dm.SetWindowState(最上層的視窗, 12)



//確認是否到了結算畫面
Rem 確認是否到了結算畫面
color = Plugin.Bkgnd.GetPixelColor(hwnd, 888, 654)
If color = "FFFFFF" Then 
Else 
	Delay 2000
	Goto 確認是否到了結算畫面
End If



//抓取關閉升等視窗前的顏色
判斷等級_before = Plugin.Bkgnd.GetPixelColor(hwnd, 600, 200)


//關閉升等視窗
dm.MoveTo 643, 170
Delay 200
dm.LeftClick 
Delay 1000


//抓取關閉升等視窗後的顏色
判斷等級_after = Plugin.Bkgnd.GetPixelColor(hwnd, 600, 200)


//檢查是否升等(檢查判斷等級的顏色是否有改變)
Rem 檢查是否升等

If 判斷等級_after = 判斷等級_before Then 
	//確認沒升等
	Goto 確認沒升等
Else 
	//確認升等了
	Goto 等級加一
End If


//等級加一
Rem 等級加一
Text = dm.ReadIni("LOL_等級", "game" & 遊戲編號, ini路徑)
等級 = CInt(Text)
等級 = 等級 + 1
dm.WriteIni "LOL_等級", "game" & 遊戲編號, 等級, ini路徑
dm.WriteIni 主機, "game" & 遊戲編號, 等級, level路徑

If 等級 = 30 Then 
	dm.WriteIni "30", 主機 & "_game" & 遊戲編號, 30, level路徑
End If



Rem 確認沒升等



//檢查打完幾場停止
Rem 檢查打完幾場停止

Text = dm.ReadIni(主機, "game" & 遊戲編號, gameplay_limit路徑)
多打幾場 = CInt(Text)

If Text = "X" Then 
Else
	多打幾場 = 多打幾場 - 1
	dm.WriteIni 主機, "game" & 遊戲編號, 多打幾場, gameplay_limit路徑
End If



//確認是否按了返回大廳
Rem 確認是否按了返回大廳

color = Plugin.Bkgnd.GetPixelColor(hwnd, 618, 16)
If color = "1F6EE2" Then 
	Goto 取得權力點圖片
Else 
	//按返回大廳
	dm.MoveTo 912, 742
	Delay 200
	dm.LeftClick
	Delay 200
	//按返回大廳
	dm.MoveTo 912, 742
	Delay 200
	dm.LeftClick
	Delay 200
	//按返回大廳
	dm.MoveTo 912, 742
	Delay 200
	dm.LeftClick
	Delay 200
	//按返回大廳
	dm.MoveTo 912, 742
	Delay 200
	dm.LeftClick
	Delay 200
	//按返回大廳
	dm.MoveTo 912, 742
	Delay 200
	dm.LeftClick
	Delay 200
	
	//按積分叉叉
	dm.MoveTo 1541-320, 202-116
	Delay 200
	dm.LeftClick
	Delay 200
	
	//按海克斯科技叉叉
	dm.MoveTo 1559-320, 211-116
	Delay 200
	dm.LeftClick
	Delay 200

	Goto 確認是否按了返回大廳
End If



//取得權力點圖片
Rem 取得權力點圖片

Call Plugin.Pic.PrintScreen(1457, 131, 1500, 148, IP路徑 & "game" & 遊戲編號 & ".bmp")





//檢查遊戲狀態
Rem 檢查遊戲狀態

Text = dm.ReadIni("LOL_運行狀態", "game" & 遊戲編號, ini路徑)
	
If Text = "腳本開始運行" Then 
	Delay 1000
	//回到腳本的一開始
	Goto 腳本重新開始的起點
End If

If Text = "打完停止" Then 
	//狀態變為"已停止"
	Call Plugin.File.WriteINI("LOL_運行狀態", "game" & 遊戲編號, "已停止", ini路徑)
	Delay 1000
	//結束腳本
	EndScript
Else
	//狀態變為"打完了_準備下一場"
	Call Plugin.File.WriteINI("LOL_運行狀態", "game" & 遊戲編號, "打完了_準備下一場", ini路徑)
End If

Delay 1000

Goto 檢查遊戲狀態






Sub 買裝備
	If 裝備 = 1 Then 
		裝備編號 = 第一個裝備_鞋子
		Call 買對應的裝備
	End If
	If 裝備 = 2 Then 
		裝備編號 = 第二個裝備
		Call 買對應的裝備
	End If
	If 裝備 = 3 Then 
		裝備編號 = 第三個裝備
		Call 買對應的裝備
	End If
	If 裝備 = 4 Then 
		裝備編號 = 第四個裝備
		Call 買對應的裝備
	End If
	If 裝備 = 5 Then 
		裝備編號 = 第五個裝備
		Call 買對應的裝備
	End If
	If 裝備 = 6 Then 
		//買完全部裝備了
		dm.MoveTo 797, 21
		Delay 200
		dm.LeftClick
		Delay 10000
		If 左下為0右上為1 = 0 Then 
    		Goto 左下_是否開始戰鬥了
		Else 
			Goto 右上_是否開始戰鬥了
		End If
	End If
End Sub

Sub 買對應的裝備
	If 裝備編號 = 1 Then 
		dm.KeyPress 80
		Delay 200
		Call 買三相之力
	End If
	If 裝備編號 = 2 Then 
		dm.KeyPress 80
		Delay 200
		Call 買嗜血者
	End If
	If 裝備編號 = 3 Then 
		dm.KeyPress 80
		Delay 200
		Call 買奪魄之鐮
	End If
	If 裝備編號 = 4 Then 
		dm.KeyPress 80
		Delay 200
		Call 買無盡之刃
	End If
	If 裝備編號 = 5 Then 
		dm.KeyPress 80
		Delay 200
		Call 買死亡之舞
	End If
	If 裝備編號 = 6 Then 
		dm.KeyPress 80
		Delay 200
		Call 買黑色切割者
	End If
	If 裝備編號 = 7 Then 
		dm.KeyPress 80
		Delay 200
		Call 買魔提斯深淵
	End If
	If 裝備編號 = 8 Then 
		dm.KeyPress 80
		Delay 200
		Call 買暮色黑刃
	End If
	If 裝備編號 = 9 Then 
		dm.KeyPress 80
		Delay 200
		Call 買冰霜之錘
	End If
	If 裝備編號 = 10 Then 
		dm.KeyPress 80
		Delay 200
		Call 買智慧末刃
	End If
	If 裝備編號 = 11 Then 
		dm.KeyPress 80
		Delay 200
		Call 買多明尼克的問候
	End If
	If 裝備編號 = 12 Then 
		dm.KeyPress 80
		Delay 200
		Call 買致死宣告
	End If
	If 裝備編號 = 13 Then 
		dm.KeyPress 80
		Delay 200
		Call 買衝擊火砲
	End If
	If 裝備編號 = 14 Then 
		dm.KeyPress 80
		Delay 200
		Call 買史提克彈簧刀
	End If
	If 裝備編號 = 15 Then 
		dm.KeyPress 80
		Delay 200
		Call 買芮蘭颶風箭
	End If
	If 裝備編號 = 16 Then 
		dm.KeyPress 80
		Delay 200
		Call 買幻影之舞
	End If
	If 裝備編號 = 17 Then 
		dm.KeyPress 80
		Delay 200
		Call 買史特拉克手套
	End If
	If 裝備編號 = 18 Then 
		dm.KeyPress 80
		Delay 200
		Call 買殞落王者之劍
	End If
	If 裝備編號 = 19 Then 
		dm.KeyPress 80
		Delay 200
		Call 買妖夢鬼刀
	End If
	If 裝備編號 = 20 Then 
		dm.KeyPress 80
		Delay 200
		Call 買夜色綠界
	End If
	If 裝備編號 = 21 Then 
		dm.KeyPress 80
		Delay 200
		Call 買鬼索的狂暴之刃
	End If
	If 裝備編號 = 22 Then 
		dm.KeyPress 80
		Delay 200
		Call 買輕靈之靴
	End If
	If 裝備編號 = 23 Then 
		dm.KeyPress 80
		Delay 200
		Call 買水星之靴
	End If
	If 裝備編號 = 24 Then 
		dm.KeyPress 80
		Delay 200
		Call 買狂戰士護脛
	End If
	If 裝備編號 = 25 Then 
		dm.KeyPress 80
		Delay 200
		Call 買狂戰士護脛
	End If
	If 裝備編號 = 26 Then 
		dm.KeyPress 80
		Delay 200
		Call 買狂戰士護脛
	End If
	If 裝備編號 = 27 Then 
		dm.KeyPress 80
		Delay 200
		Call 買狂戰士護脛
	End If
	If 裝備編號 = 28 Then 
		dm.KeyPress 80
		Delay 200
		Call 買狂戰士護脛
	End If
End Sub


//買三相之力
Sub 買三相之力
	If 三相之力 = 1 Then 
		//短劍(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 三相之力01
		Else 
			三相之力 = 三相之力 + 1
			Call 買三相之力
		End If	
	End If
	
	If 三相之力 = 2 Then 
		//短劍(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 三相之力02
		Else 
			三相之力 = 三相之力 + 1
			Call 買三相之力
		End If
	End If
	
	If 三相之力 = 3 Then 
		//刺針劍(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 三相之力03
		Else 
			三相之力 = 三相之力 + 1
			Call 買三相之力
		End If
	End If
	
	If 三相之力 = 4 Then 
		//藍水晶(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 三相之力04
		Else 
			三相之力 = 三相之力 + 1
			Call 買三相之力
		End If
	End If
	
	If 三相之力 = 5 Then 
  		//閃耀劍(2)
  		子裝備 = 裝備 + 1
  		If 子裝備 <= 5 Then 
			Call 三相之力05
		Else 
			三相之力 = 三相之力 + 1
			Call 買三相之力
		End If
	End If
	
	If 三相之力 = 6 Then 
  		//紅水晶(3)
  		子裝備 = 裝備 + 2
  		If 子裝備 <= 5 Then 
			Call 三相之力06
		Else 
			三相之力 = 三相之力 + 1
			Call 買三相之力
		End If
	End If
	
	If 三相之力 = 7 Then 
  		//長劍(4)
  		子裝備 = 裝備 + 3
  		If 子裝備 <= 5 Then 
			Call 三相之力07
		Else 
			三相之力 = 三相之力 + 1
			Call 買三相之力
		End If
	End If
	
	If 三相之力 = 8 Then 
  		//淨蝕之槌(3)
  		子裝備 = 裝備 + 2
  		If 子裝備 <= 5 Then 
			Call 三相之力08
		Else 
			三相之力 = 三相之力 + 1
			Call 買三相之力
		End If
	End If
	
	If 三相之力 = 9 Then 
  		//三相之力(1)
  		子裝備 = 裝備
  		If 子裝備 <= 5 Then 
			Call 三相之力09
		Else 
			三相之力 = 三相之力 + 1
			Call 買三相之力
		End If
	End If
	
	If 三相之力 = 10 Then 
		//買完三相之力了
		裝備 = 裝備 + 1
		dm.KeyPress 80
		Delay 200
		Call 買裝備
	End If
End Sub
//短劍(1)
Sub 三相之力01
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "短劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完三相之力了
	Else 
 		//TracePrint "買成功了"
		三相之力 = 三相之力 + 1
		Call 買三相之力	
	End If
End Sub
//短劍(2)
Sub 三相之力02
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "短劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完三相之力了
	Else 
 		//TracePrint "買成功了"
		三相之力 = 三相之力 + 1
		Call 買三相之力	
	End If
End Sub
//刺針劍(1)
Sub 三相之力03
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "刺針劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完三相之力了
	Else 
 		//TracePrint "買成功了"
		三相之力 = 三相之力 + 1
		Call 買三相之力	
	End If
End Sub
//藍水晶(2)
Sub 三相之力04
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "藍水晶")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完三相之力了
	Else 
 		//TracePrint "買成功了"
		三相之力 = 三相之力 + 1
		Call 買三相之力	
	End If
End Sub
//閃耀劍(2)
Sub 三相之力05
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "閃耀劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick 
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完三相之力了
	Else 
 		//TracePrint "買成功了"
		三相之力 = 三相之力 + 1
		Call 買三相之力	
	End If	
End Sub
//紅水晶(3)
Sub 三相之力06
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "紅水晶")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完三相之力了
	Else 
 		//TracePrint "買成功了"
		三相之力 = 三相之力 + 1
		Call 買三相之力	
	End If
End Sub
//長劍(4)
Sub 三相之力07
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完三相之力了
	Else 
 		//TracePrint "買成功了"
		三相之力 = 三相之力 + 1
		Call 買三相之力	
	End If	
End Sub
//淨蝕之槌(3)
Sub 三相之力08
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "淨蝕之槌")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完三相之力了
	Else 
 		//TracePrint "買成功了"
		三相之力 = 三相之力 + 1
		Call 買三相之力	
	End If	
End Sub
//三相之力(1)
Sub 三相之力09
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "三相之力")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完三相之力了
	Else 
 		//TracePrint "買成功了"
		三相之力 = 三相之力 + 1
		Call 買三相之力	
	End If	
End Sub
//關掉商城，準備去戰鬥
Sub 買完三相之力了
	dm.MoveTo 797, 21
	Delay 200
	dm.LeftClick
	Delay 10000
	If 左下為0右上為1 = 0 Then 
    	Goto 左下_是否開始戰鬥了
	Else 
		Goto 右上_是否開始戰鬥了
	End If	
End Sub

//買嗜血者
Sub 買嗜血者
	If 嗜血者 = 1 Then 
		//長劍(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 嗜血者01
		Else 
			嗜血者 = 嗜血者 + 1
			Call 買嗜血者
		End If	
	End If
	
	If 嗜血者 = 2 Then 
		//吸血鬼權杖(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 嗜血者02
		Else 
			嗜血者 = 嗜血者 + 1
			Call 買嗜血者
		End If
	End If
	
	If 嗜血者 = 3 Then 
		//長劍(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 嗜血者03
		Else 
			嗜血者 = 嗜血者 + 1
			Call 買嗜血者
		End If
	End If
	
	If 嗜血者 = 4 Then 
		//暴風之劍(3)
		子裝備 = 裝備 + 2
		If 子裝備 <= 5 Then 
			Call 嗜血者04
		Else 
			嗜血者 = 嗜血者 + 1
			Call 買嗜血者
		End If
	End If
	
	If 嗜血者 = 5 Then 
  		//嗜血者(1)
  		子裝備 = 裝備
  		If 子裝備 <= 5 Then 
			Call 嗜血者05
		Else 
			嗜血者 = 嗜血者 + 1
			Call 買嗜血者
		End If
	End If
	
	If 嗜血者 = 6 Then 
		//買完嗜血者了
		裝備 = 裝備 + 1
		dm.KeyPress 80
		Delay 200
		Call 買裝備
	End If	
End Sub
//長劍(1)
Sub 嗜血者01
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完嗜血者了
	Else 
 		//TracePrint "買成功了"
		嗜血者 = 嗜血者 + 1
		Call 買嗜血者	
	End If	
End Sub
//吸血鬼權杖(1)
Sub 嗜血者02
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "吸血鬼權杖")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完嗜血者了
	Else 
 		//TracePrint "買成功了"
		嗜血者 = 嗜血者 + 1
		Call 買嗜血者	
	End If	
End Sub
//長劍(2)
Sub 嗜血者03
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完嗜血者了
	Else 
 		//TracePrint "買成功了"
		嗜血者 = 嗜血者 + 1
		Call 買嗜血者	
	End If	
End Sub
//暴風之劍(3)
Sub 嗜血者04
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "暴風之劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完嗜血者了
	Else 
 		//TracePrint "買成功了"
		嗜血者 = 嗜血者 + 1
		Call 買嗜血者	
	End If	
End Sub
//嗜血者(1)
Sub 嗜血者05
	Call 第幾個子裝備
	TracePrint 子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "嗜血者")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		TracePrint "買失敗了"
 		Call 買完嗜血者了
	Else 
 		TracePrint "買成功了"
		嗜血者 = 嗜血者 + 1
		Call 買嗜血者	
	End If	
End Sub
//關掉商城，準備去戰鬥
Sub 買完嗜血者了
	dm.MoveTo 797, 21
	Delay 200
	dm.LeftClick 
	Delay 10000
	If 左下為0右上為1 = 0 Then 
    	Goto 左下_是否開始戰鬥了
	Else 
		Goto 右上_是否開始戰鬥了
	End If	
End Sub

//買奪魄之鐮
Sub 買奪魄之鐮
	If 奪魄之鐮 = 1 Then 
		//長劍(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 奪魄之鐮01
		Else 
			奪魄之鐮 = 奪魄之鐮 + 1
			Call 買奪魄之鐮
		End If	
	End If
	
	If 奪魄之鐮 = 2 Then 
		//長劍(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 奪魄之鐮02
		Else 
			奪魄之鐮 = 奪魄之鐮 + 1
			Call 買奪魄之鐮
		End If
	End If
	
	If 奪魄之鐮 = 3 Then 
		//考菲爾德的戰槌(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 奪魄之鐮03
		Else 
			奪魄之鐮 = 奪魄之鐮 + 1
			Call 買奪魄之鐮
		End If
	End If
	
	If 奪魄之鐮 = 4 Then 
		//靈巧披風(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 奪魄之鐮04
		Else 
			奪魄之鐮 = 奪魄之鐮 + 1
			Call 買奪魄之鐮
		End If
	End If
	
	If 奪魄之鐮 = 5 Then 
  		//暴風之劍(3)
  		子裝備 = 裝備 + 2
  		If 子裝備 <= 5 Then 
			Call 奪魄之鐮05
		Else 
			奪魄之鐮 = 奪魄之鐮 + 1
			Call 買奪魄之鐮
		End If
	End If
	
	If 奪魄之鐮 = 6 Then 
  		//奪魄之鐮(1)
  		子裝備 = 裝備
  		If 子裝備 <= 5 Then 
			Call 奪魄之鐮06
		Else 
			奪魄之鐮 = 奪魄之鐮 + 1
			Call 買奪魄之鐮
		End If
	End If
	
	If 奪魄之鐮 = 7 Then 
		//買完奪魄之鐮了
		裝備 = 裝備 + 1
		dm.KeyPress 80
		Delay 200
		Call 買裝備
	End If	
End Sub
//長劍(1)
Sub 奪魄之鐮01
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完奪魄之鐮了
	Else 
 		//TracePrint "買成功了"
		奪魄之鐮 = 奪魄之鐮 + 1
		Call 買奪魄之鐮	
	End If	
End Sub
//長劍(2)
Sub 奪魄之鐮02
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完奪魄之鐮了
	Else 
 		//TracePrint "買成功了"
		奪魄之鐮 = 奪魄之鐮 + 1
		Call 買奪魄之鐮	
	End If	
End Sub
//考菲爾德的戰槌(1)
Sub 奪魄之鐮03
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "考菲爾德的戰槌")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完奪魄之鐮了
	Else 
 		//TracePrint "買成功了"
		奪魄之鐮 = 奪魄之鐮 + 1
		Call 買奪魄之鐮	
	End If	
End Sub
//靈巧披風(2)
Sub 奪魄之鐮04
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "靈巧披風")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完奪魄之鐮了
	Else 
 		//TracePrint "買成功了"
		奪魄之鐮 = 奪魄之鐮 + 1
		Call 買奪魄之鐮	
	End If	
End Sub
//暴風之劍(3)
Sub 奪魄之鐮05
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "暴風之劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick 
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完奪魄之鐮了
	Else 
 		//TracePrint "買成功了"
		奪魄之鐮 = 奪魄之鐮 + 1
		Call 買奪魄之鐮	
	End If	
End Sub
//奪魄之鐮(1)
Sub 奪魄之鐮06
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "奪魄之鐮")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完奪魄之鐮了
	Else 
 		//TracePrint "買成功了"
		奪魄之鐮 = 奪魄之鐮 + 1
		Call 買奪魄之鐮	
	End If	
End Sub
//關掉商城，準備去戰鬥
Sub 買完奪魄之鐮了
	dm.MoveTo 797, 21
	Delay 200
	dm.LeftClick 
	Delay 10000
	If 左下為0右上為1 = 0 Then 
    	Goto 左下_是否開始戰鬥了
	Else 
		Goto 右上_是否開始戰鬥了
	End If	
End Sub

//買無盡之刃
Sub 買無盡之刃
	If 無盡之刃 = 1 Then 
		//十字鎬(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 無盡之刃01
		Else 
			無盡之刃 = 無盡之刃 + 1
			Call 買無盡之刃
		End If	
	End If
	
	If 無盡之刃 = 2 Then 
		//靈巧披風(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 無盡之刃02
		Else 
			無盡之刃 = 無盡之刃 + 1
			Call 買無盡之刃
		End If
	End If
	
	If 無盡之刃 = 3 Then 
		//暴風之劍(3)
		子裝備 = 裝備 + 2
		If 子裝備 <= 5 Then 
			Call 無盡之刃03
		Else 
			無盡之刃 = 無盡之刃 + 1
			Call 買無盡之刃
		End If
	End If
	
	If 無盡之刃 = 4 Then 
		//無盡之刃(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 無盡之刃04
		Else 
			無盡之刃 = 無盡之刃 + 1
			Call 買無盡之刃
		End If
	End If
	
	If 無盡之刃 = 5 Then 
		//買完無盡之刃了
		裝備 = 裝備 + 1
		dm.KeyPress 80
		Delay 200
		Call 買裝備
	End If
End Sub
//十字鎬(1)
Sub 無盡之刃01
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "十字鎬")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完無盡之刃了
	Else 
 		//TracePrint "買成功了"
		無盡之刃 = 無盡之刃 + 1
		Call 買無盡之刃	
	End If	
End Sub
//靈巧披風(2)
Sub 無盡之刃02
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "靈巧披風")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完無盡之刃了
	Else 
 		//TracePrint "買成功了"
		無盡之刃 = 無盡之刃 + 1
		Call 買無盡之刃	
	End If	
End Sub
//暴風之劍(3)
Sub 無盡之刃03
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "暴風之劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完無盡之刃了
	Else 
 		//TracePrint "買成功了"
		無盡之刃 = 無盡之刃 + 1
		Call 買無盡之刃	
	End If	
End Sub
//無盡之刃(1)
Sub 無盡之刃04
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "無盡之刃")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完無盡之刃了
	Else 
 		//TracePrint "買成功了"
		無盡之刃 = 無盡之刃 + 1
		Call 買無盡之刃	
	End If	
End Sub
//關掉商城，準備去戰鬥
Sub 買完無盡之刃了
	dm.MoveTo 797, 21
	Delay 200
	dm.LeftClick 
	Delay 10000
	If 左下為0右上為1 = 0 Then 
    	Goto 左下_是否開始戰鬥了
	Else 
		Goto 右上_是否開始戰鬥了
	End If	
End Sub

//買死亡之舞
Sub 買死亡之舞
	If 死亡之舞 = 1 Then 
		//長劍(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 死亡之舞01
		Else 
			死亡之舞 = 死亡之舞 + 1
			Call 買死亡之舞
		End If	
	End If
	
	If 死亡之舞 = 2 Then 
		//吸血鬼權杖(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 死亡之舞02
		Else 
			死亡之舞 = 死亡之舞 + 1
			Call 買死亡之舞
		End If
	End If
	
	If 死亡之舞 = 3 Then 
		//長劍(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 死亡之舞03
		Else 
			死亡之舞 = 死亡之舞 + 1
			Call 買死亡之舞
		End If
	End If
	
	If 死亡之舞 = 4 Then 
		//長劍(3)
		子裝備 = 裝備 + 2
		If 子裝備 <= 5 Then 
			Call 死亡之舞04
		Else 
			死亡之舞 = 死亡之舞 + 1
			Call 買死亡之舞
		End If
	End If
	
	If 死亡之舞 = 5 Then 
  		//考菲爾德的戰槌(2)
  		子裝備 = 裝備 + 1
  		If 子裝備 <= 5 Then 
			Call 死亡之舞05
		Else 
			死亡之舞 = 死亡之舞 + 1
			Call 買死亡之舞
		End If
	End If
	
	If 死亡之舞 = 6 Then 
  		//十字鎬(3)
  		子裝備 = 裝備 + 2
  		If 子裝備 <= 5 Then 
			Call 死亡之舞06
		Else 
			死亡之舞 = 死亡之舞 + 1
			Call 買死亡之舞
		End If
	End If
	
	If 死亡之舞 = 7 Then 
  		//死亡之舞(1)
  		子裝備 = 裝備
  		If 子裝備 <= 5 Then 
			Call 死亡之舞07
		Else 
			死亡之舞 = 死亡之舞 + 1
			Call 買死亡之舞
		End If
	End If
	
	If 死亡之舞 = 8 Then 
		//買完死亡之舞了
		裝備 = 裝備 + 1
		dm.KeyPress 80
		Delay 200
		Call 買裝備
	End If	
End Sub
//長劍(1)
Sub 死亡之舞01
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完死亡之舞了
	Else 
 		//TracePrint "買成功了"
		死亡之舞 = 死亡之舞 + 1
		Call 買死亡之舞	
	End If	
End Sub
//吸血鬼權杖(1)
Sub 死亡之舞02
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "吸血鬼權杖")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完死亡之舞了
	Else 
 		//TracePrint "買成功了"
		死亡之舞 = 死亡之舞 + 1
		Call 買死亡之舞	
	End If	
End Sub
//長劍(2)
Sub 死亡之舞03
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完死亡之舞了
	Else 
 		//TracePrint "買成功了"
		死亡之舞 = 死亡之舞 + 1
		Call 買死亡之舞	
	End If	
End Sub
//長劍(3)
Sub 死亡之舞04
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完死亡之舞了
	Else 
 		//TracePrint "買成功了"
		死亡之舞 = 死亡之舞 + 1
		Call 買死亡之舞	
	End If	
End Sub
//考菲爾德的戰槌(2)
Sub 死亡之舞05
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "考菲爾德的戰槌")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick 
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完死亡之舞了
	Else 
 		//TracePrint "買成功了"
		死亡之舞 = 死亡之舞 + 1
		Call 買死亡之舞	
	End If	
End Sub
//十字鎬(3)
Sub 死亡之舞06
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "十字鎬")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完死亡之舞了
	Else 
 		//TracePrint "買成功了"
		死亡之舞 = 死亡之舞 + 1
		Call 買死亡之舞	
	End If	
End Sub
//死亡之舞(1)
Sub 死亡之舞07
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "死亡之舞")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完死亡之舞了
	Else 
 		//TracePrint "買成功了"
		死亡之舞 = 死亡之舞 + 1
		Call 買死亡之舞	
	End If	
End Sub
//關掉商城，準備去戰鬥
Sub 買完死亡之舞了
	dm.MoveTo 797, 21
	Delay 200
	dm.LeftClick 
	Delay 10000
	If 左下為0右上為1 = 0 Then 
    	Goto 左下_是否開始戰鬥了
	Else 
		Goto 右上_是否開始戰鬥了
	End If	
End Sub

//買黑色切割者
Sub 買黑色切割者
	If 黑色切割者 = 1 Then 
		//紅水晶(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 黑色切割者01
		Else 
			黑色切割者 = 黑色切割者 + 1
			Call 買黑色切割者
		End If	
	End If
	
	If 黑色切割者 = 2 Then 
		//長劍(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 黑色切割者02
		Else 
			黑色切割者 = 黑色切割者 + 1
			Call 買黑色切割者
		End If
	End If
	
	If 黑色切割者 = 3 Then 
		//淨蝕之槌(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 黑色切割者03
		Else 
			黑色切割者 = 黑色切割者 + 1
			Call 買黑色切割者
		End If
	End If
	
	If 黑色切割者 = 4 Then 
		//長劍(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 黑色切割者04
		Else 
			黑色切割者 = 黑色切割者 + 1
			Call 買黑色切割者
		End If
	End If
	
	If 黑色切割者 = 5 Then 
  		//長劍(3)
  		子裝備 = 裝備 + 2
  		If 子裝備 <= 5 Then 
			Call 黑色切割者05
		Else 
			黑色切割者 = 黑色切割者 + 1
			Call 買黑色切割者
		End If
	End If
	
	If 黑色切割者 = 6 Then 
  		//考菲爾德的戰槌(2)
  		子裝備 = 裝備 + 1
  		If 子裝備 <= 5 Then 
			Call 黑色切割者06
		Else 
			黑色切割者 = 黑色切割者 + 1
			Call 買黑色切割者
		End If
	End If
	
	If 黑色切割者 = 7 Then 
  		//黑色切割者(1)
  		子裝備 = 裝備
  		If 子裝備 <= 5 Then 
			Call 黑色切割者07
		Else 
			黑色切割者 = 黑色切割者 + 1
			Call 買黑色切割者
		End If
	End If
	
	If 黑色切割者 = 8 Then 
		//買完黑色切割者了
		裝備 = 裝備 + 1
		dm.KeyPress 80
		Delay 200
		Call 買裝備
	End If	
End Sub
//紅水晶(1)
Sub 黑色切割者01
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "紅水晶")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完黑色切割者了
	Else 
 		//TracePrint "買成功了"
		黑色切割者 = 黑色切割者 + 1
		Call 買黑色切割者	
	End If	
End Sub
//長劍(2)
Sub 黑色切割者02
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完黑色切割者了
	Else 
 		//TracePrint "買成功了"
		黑色切割者 = 黑色切割者 + 1
		Call 買黑色切割者	
	End If	
End Sub
//淨蝕之槌(1)
Sub 黑色切割者03
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "淨蝕之槌")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完黑色切割者了
	Else 
 		//TracePrint "買成功了"
		黑色切割者 = 黑色切割者 + 1
		Call 買黑色切割者	
	End If	
End Sub
//長劍(2)
Sub 黑色切割者04
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完黑色切割者了
	Else 
 		//TracePrint "買成功了"
		黑色切割者 = 黑色切割者 + 1
		Call 買黑色切割者	
	End If	
End Sub
//長劍(3)
Sub 黑色切割者05
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick 
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完黑色切割者了
	Else 
 		//TracePrint "買成功了"
		黑色切割者 = 黑色切割者 + 1
		Call 買黑色切割者	
	End If	
End Sub
//考菲爾德的戰槌(2)
Sub 黑色切割者06
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "考菲爾德的戰槌")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完黑色切割者了
	Else 
 		//TracePrint "買成功了"
		黑色切割者 = 黑色切割者 + 1
		Call 買黑色切割者	
	End If	
End Sub
//黑色切割者(1)
Sub 黑色切割者07
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "黑色切割者")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完黑色切割者了
	Else 
 		//TracePrint "買成功了"
		黑色切割者 = 黑色切割者 + 1
		Call 買黑色切割者	
	End If	
End Sub
//關掉商城，準備去戰鬥
Sub 買完黑色切割者了
	dm.MoveTo 797, 21
	Delay 200
	dm.LeftClick 
	Delay 10000
	If 左下為0右上為1 = 0 Then 
    	Goto 左下_是否開始戰鬥了
	Else 
		Goto 右上_是否開始戰鬥了
	End If	
End Sub

//買魔提斯深淵
Sub 買魔提斯深淵
	If 魔提斯深淵 = 1 Then 
		//長劍(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 魔提斯深淵01
		Else 
			魔提斯深淵 = 魔提斯深淵 + 1
			Call 買魔提斯深淵
		End If	
	End If
	
	If 魔提斯深淵 = 2 Then 
		//抗魔斗篷(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 魔提斯深淵02
		Else 
			魔提斯深淵 = 魔提斯深淵 + 1
			Call 買魔提斯深淵
		End If
	End If
	
	If 魔提斯深淵 = 3 Then 
		//吸魔劍(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 魔提斯深淵03
		Else 
			魔提斯深淵 = 魔提斯深淵 + 1
			Call 買魔提斯深淵
		End If
	End If
	
	If 魔提斯深淵 = 4 Then 
		//長劍(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 魔提斯深淵04
		Else 
			魔提斯深淵 = 魔提斯深淵 + 1
			Call 買魔提斯深淵
		End If
	End If
	
	If 魔提斯深淵 = 5 Then 
  		//長劍(3)
  		子裝備 = 裝備 + 2
  		If 子裝備 <= 5 Then 
			Call 魔提斯深淵05
		Else 
			魔提斯深淵 = 魔提斯深淵 + 1
			Call 買魔提斯深淵
		End If
	End If
	
	If 魔提斯深淵 = 6 Then 
  		//考菲爾德的戰槌(2)
  		子裝備 = 裝備 + 1
  		If 子裝備 <= 5 Then 
			Call 魔提斯深淵06
		Else 
			魔提斯深淵 = 魔提斯深淵 + 1
			Call 買魔提斯深淵
		End If
	End If
	
	If 魔提斯深淵 = 7 Then 
  		//魔提斯深淵(1)
  		子裝備 = 裝備
  		If 子裝備 <= 5 Then 
			Call 魔提斯深淵07
		Else 
			魔提斯深淵 = 魔提斯深淵 + 1
			Call 買魔提斯深淵
		End If
	End If
	
	If 魔提斯深淵 = 8 Then 
		//買完魔提斯深淵了
		裝備 = 裝備 + 1
		dm.KeyPress 80
		Delay 200
		Call 買裝備
	End If	
End Sub
//長劍(1)
Sub 魔提斯深淵01
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完魔提斯深淵了
	Else 
 		//TracePrint "買成功了"
		魔提斯深淵 = 魔提斯深淵 + 1
		Call 買魔提斯深淵	
	End If	
End Sub
//抗魔斗篷(2)
Sub 魔提斯深淵02
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "抗魔斗篷")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完魔提斯深淵了
	Else 
 		//TracePrint "買成功了"
		魔提斯深淵 = 魔提斯深淵 + 1
		Call 買魔提斯深淵	
	End If	
End Sub
//吸魔劍(1)
Sub 魔提斯深淵03
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "吸魔劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完魔提斯深淵了
	Else 
 		//TracePrint "買成功了"
		魔提斯深淵 = 魔提斯深淵 + 1
		Call 買魔提斯深淵	
	End If	
End Sub
//長劍(2)
Sub 魔提斯深淵04
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完魔提斯深淵了
	Else 
 		//TracePrint "買成功了"
		魔提斯深淵 = 魔提斯深淵 + 1
		Call 買魔提斯深淵	
	End If	
End Sub
//長劍(3)
Sub 魔提斯深淵05
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick 
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完魔提斯深淵了
	Else 
 		//TracePrint "買成功了"
		魔提斯深淵 = 魔提斯深淵 + 1
		Call 買魔提斯深淵	
	End If	
End Sub
//考菲爾德的戰槌(2)
Sub 魔提斯深淵06
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "考菲爾德的戰槌")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完魔提斯深淵了
	Else 
 		//TracePrint "買成功了"
		魔提斯深淵 = 魔提斯深淵 + 1
		Call 買魔提斯深淵	
	End If	
End Sub
//魔提斯深淵(1)
Sub 魔提斯深淵07
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "魔提斯深淵")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完魔提斯深淵了
	Else 
 		//TracePrint "買成功了"
		魔提斯深淵 = 魔提斯深淵 + 1
		Call 買魔提斯深淵	
	End If	
End Sub
//關掉商城，準備去戰鬥
Sub 買完魔提斯深淵了
	dm.MoveTo 797, 21
	Delay 200
	dm.LeftClick 
	Delay 10000
	If 左下為0右上為1 = 0 Then 
    	Goto 左下_是否開始戰鬥了
	Else 
		Goto 右上_是否開始戰鬥了
	End If	
End Sub

//買暮色黑刃
Sub 買暮色黑刃
	If 暮色黑刃 = 1 Then 
		//長劍(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 暮色黑刃01
		Else 
			暮色黑刃 = 暮色黑刃 + 1
			Call 買暮色黑刃
		End If	
	End If
	
	If 暮色黑刃 = 2 Then 
		//長劍(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 暮色黑刃02
		Else 
			暮色黑刃 = 暮色黑刃 + 1
			Call 買暮色黑刃
		End If
	End If
	
	If 暮色黑刃 = 3 Then 
		//殘暴之力(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 暮色黑刃03
		Else 
			暮色黑刃 = 暮色黑刃 + 1
			Call 買暮色黑刃
		End If
	End If
	
	If 暮色黑刃 = 4 Then 
  		//暴風之劍(2)
  		子裝備 = 裝備 + 1
  		If 子裝備 <= 5 Then 
			Call 暮色黑刃04
		Else 
			暮色黑刃 = 暮色黑刃 + 1
			Call 買暮色黑刃
		End If
	End If
	
	If 暮色黑刃 = 5 Then 
  		//暮色黑刃(1)
  		子裝備 = 裝備
  		If 子裝備 <= 5 Then 
			Call 暮色黑刃05
		Else 
			暮色黑刃 = 暮色黑刃 + 1
			Call 買暮色黑刃
		End If
	End If
	
	If 暮色黑刃 = 6 Then 
		//買完暮色黑刃了
		裝備 = 裝備 + 1
		dm.KeyPress 80
		Delay 200
		Call 買裝備
	End If	
End Sub
//長劍(1)
Sub 暮色黑刃01
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完暮色黑刃了
	Else 
 		//TracePrint "買成功了"
		暮色黑刃 = 暮色黑刃 + 1
		Call 買暮色黑刃	
	End If	
End Sub
//長劍(2)
Sub 暮色黑刃02
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完暮色黑刃了
	Else 
 		//TracePrint "買成功了"
		暮色黑刃 = 暮色黑刃 + 1
		Call 買暮色黑刃	
	End If	
End Sub
//殘暴之力(1)
Sub 暮色黑刃03
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "殘暴之力")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完暮色黑刃了
	Else 
 		//TracePrint "買成功了"
		暮色黑刃 = 暮色黑刃 + 1
		Call 買暮色黑刃	
	End If	
End Sub
//暴風之劍(2)
Sub 暮色黑刃04
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "暴風之劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick 
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完暮色黑刃了
	Else 
 		//TracePrint "買成功了"
		暮色黑刃 = 暮色黑刃 + 1
		Call 買暮色黑刃	
	End If	
End Sub
//暮色黑刃(1)
Sub 暮色黑刃05
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "暮色黑刃")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完暮色黑刃了
	Else 
 		//TracePrint "買成功了"
		暮色黑刃 = 暮色黑刃 + 1
		Call 買暮色黑刃	
	End If	
End Sub
//關掉商城，準備去戰鬥
Sub 買完暮色黑刃了
	dm.MoveTo 797, 21
	Delay 200
	dm.LeftClick 
	Delay 10000
	If 左下為0右上為1 = 0 Then 
    	Goto 左下_是否開始戰鬥了
	Else 
		Goto 右上_是否開始戰鬥了
	End If	
End Sub

//買冰霜之錘
Sub 買冰霜之錘
	If 冰霜之錘 = 1 Then 
		//長劍(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 冰霜之錘01
		Else 
			冰霜之錘 = 冰霜之錘 + 1
			Call 買冰霜之錘
		End If	
	End If
	
	If 冰霜之錘 = 2 Then 
		//紅水晶(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 冰霜之錘02
		Else 
			冰霜之錘 = 冰霜之錘 + 1
			Call 買冰霜之錘
		End If
	End If
	
	If 冰霜之錘 = 3 Then 
		//約瑞姆之拳(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 冰霜之錘03
		Else 
			冰霜之錘 = 冰霜之錘 + 1
			Call 買冰霜之錘
		End If
	End If
	
	If 冰霜之錘 = 4 Then 
		//紅水晶(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 冰霜之錘04
		Else 
			冰霜之錘 = 冰霜之錘 + 1
			Call 買冰霜之錘
		End If
	End If
	
	If 冰霜之錘 = 5 Then 
  		//巨人腰帶(3)
  		子裝備 = 裝備 + 2
  		If 子裝備 <= 5 Then 
			Call 冰霜之錘05
		Else 
			冰霜之錘 = 冰霜之錘 + 1
			Call 買冰霜之錘
		End If
	End If
	
	If 冰霜之錘 = 6 Then 
  		//冰霜之錘(1)
  		子裝備 = 裝備
  		If 子裝備 <= 5 Then 
			Call 冰霜之錘06
		Else 
			冰霜之錘 = 冰霜之錘 + 1
			Call 買冰霜之錘
		End If
	End If
	
	If 冰霜之錘 = 7 Then 
		//買完冰霜之錘了
		裝備 = 裝備 + 1
		dm.KeyPress 80
		Delay 200
		Call 買裝備
	End If	
End Sub
//長劍(1)
Sub 冰霜之錘01
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完冰霜之錘了
	Else 
 		//TracePrint "買成功了"
		冰霜之錘 = 冰霜之錘 + 1
		Call 買冰霜之錘	
	End If	
End Sub
//紅水晶(2)
Sub 冰霜之錘02
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "紅水晶")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完冰霜之錘了
	Else 
 		//TracePrint "買成功了"
		冰霜之錘 = 冰霜之錘 + 1
		Call 買冰霜之錘	
	End If	
End Sub
//約瑞姆之拳(1)
Sub 冰霜之錘03
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "約瑞姆之拳")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完冰霜之錘了
	Else 
 		//TracePrint "買成功了"
		冰霜之錘 = 冰霜之錘 + 1
		Call 買冰霜之錘	
	End If	
End Sub
//紅水晶(2)
Sub 冰霜之錘04
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "紅水晶")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完冰霜之錘了
	Else 
 		//TracePrint "買成功了"
		冰霜之錘 = 冰霜之錘 + 1
		Call 買冰霜之錘	
	End If	
End Sub
//巨人腰帶(3)
Sub 冰霜之錘05
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "巨人腰帶")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick 
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完冰霜之錘了
	Else 
 		//TracePrint "買成功了"
		冰霜之錘 = 冰霜之錘 + 1
		Call 買冰霜之錘	
	End If	
End Sub
//冰霜之錘(1)
Sub 冰霜之錘06
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "冰霜之錘")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完冰霜之錘了
	Else 
 		//TracePrint "買成功了"
		冰霜之錘 = 冰霜之錘 + 1
		Call 買冰霜之錘	
	End If	
End Sub
//關掉商城，準備去戰鬥
Sub 買完冰霜之錘了
	dm.MoveTo 797, 21
	Delay 200
	dm.LeftClick 
	Delay 10000
	If 左下為0右上為1 = 0 Then 
    	Goto 左下_是否開始戰鬥了
	Else 
		Goto 右上_是否開始戰鬥了
	End If	
End Sub

//買智慧末刃
Sub 買智慧末刃
	If 智慧末刃 = 1 Then 
		//短劍(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 智慧末刃01
		Else 
			智慧末刃 = 智慧末刃 + 1
			Call 買智慧末刃
		End If	
	End If
	
	If 智慧末刃 = 2 Then 
		//短劍(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 智慧末刃02
		Else 
			智慧末刃 = 智慧末刃 + 1
			Call 買智慧末刃
		End If
	End If
	
	If 智慧末刃 = 3 Then 
		//反曲弓(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 智慧末刃03
		Else 
			智慧末刃 = 智慧末刃 + 1
			Call 買智慧末刃
		End If
	End If
	
	If 智慧末刃 = 4 Then 
		//抗魔斗篷(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 智慧末刃04
		Else 
			智慧末刃 = 智慧末刃 + 1
			Call 買智慧末刃
		End If
	End If
	
	If 智慧末刃 = 5 Then 
		//負極斗篷(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 智慧末刃05
		Else 
			智慧末刃 = 智慧末刃 + 1
			Call 買智慧末刃
		End If
	End If
	
	If 智慧末刃 = 6 Then 
  		//短劍(3)
  		子裝備 = 裝備 + 2
  		If 子裝備 <= 5 Then 
			Call 智慧末刃06
		Else 
			智慧末刃 = 智慧末刃 + 1
			Call 買智慧末刃
		End If
	End If
	
	If 智慧末刃 = 7 Then 
  		//智慧末刃(1)
  		子裝備 = 裝備
  		If 子裝備 <= 5 Then 
			Call 智慧末刃07
		Else 
			智慧末刃 = 智慧末刃 + 1
			Call 買智慧末刃
		End If
	End If
	
	If 智慧末刃 = 8 Then 
		//買完智慧末刃了
		裝備 = 裝備 + 1
		dm.KeyPress 80
		Delay 200
		Call 買裝備
	End If	
End Sub
//短劍(1)
Sub 智慧末刃01
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "短劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完智慧末刃了
	Else 
 		//TracePrint "買成功了"
		智慧末刃 = 智慧末刃 + 1
		Call 買智慧末刃	
	End If	
End Sub
//短劍(2)
Sub 智慧末刃02
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "短劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完智慧末刃了
	Else 
 		//TracePrint "買成功了"
		智慧末刃 = 智慧末刃 + 1
		Call 買智慧末刃	
	End If	
End Sub
//反曲弓(1)
Sub 智慧末刃03
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "反曲弓")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完智慧末刃了
	Else 
 		//TracePrint "買成功了"
		智慧末刃 = 智慧末刃 + 1
		Call 買智慧末刃	
	End If	
End Sub
//抗魔斗篷(2)
Sub 智慧末刃04
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "抗魔斗篷")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完智慧末刃了
	Else 
 		//TracePrint "買成功了"
		智慧末刃 = 智慧末刃 + 1
		Call 買智慧末刃	
	End If	
End Sub
//負極斗篷(2)
Sub 智慧末刃05
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "負極斗篷")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完智慧末刃了
	Else 
 		//TracePrint "買成功了"
		智慧末刃 = 智慧末刃 + 1
		Call 買智慧末刃	
	End If	
End Sub
//短劍(3)
Sub 智慧末刃06
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "短劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick 
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完智慧末刃了
	Else 
 		//TracePrint "買成功了"
		智慧末刃 = 智慧末刃 + 1
		Call 買智慧末刃	
	End If	
End Sub
//智慧末刃(1)
Sub 智慧末刃07
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "智慧末刃")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完智慧末刃了
	Else 
 		//TracePrint "買成功了"
		智慧末刃 = 智慧末刃 + 1
		Call 買智慧末刃	
	End If	
End Sub
//關掉商城，準備去戰鬥
Sub 買完智慧末刃了
	dm.MoveTo 797, 21
	Delay 200
	dm.LeftClick 
	Delay 10000
	If 左下為0右上為1 = 0 Then 
    	Goto 左下_是否開始戰鬥了
	Else 
		Goto 右上_是否開始戰鬥了
	End If	
End Sub

//買多明尼克的問候
Sub 買多明尼克的問候
	If 多明尼克的問候 = 1 Then 
		//長劍(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 多明尼克的問候01
		Else 
			多明尼克的問候 = 多明尼克的問候 + 1
			Call 買多明尼克的問候
		End If	
	End If
	
	If 多明尼克的問候 = 2 Then 
		//巨人殺手(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 多明尼克的問候02
		Else 
			多明尼克的問候 = 多明尼克的問候 + 1
			Call 買多明尼克的問候
		End If
	End If
	
	If 多明尼克的問候 = 3 Then 
		//十字鎬(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 多明尼克的問候03
		Else 
			多明尼克的問候 = 多明尼克的問候 + 1
			Call 買多明尼克的問候
		End If
	End If
	
	If 多明尼克的問候 = 4 Then 
		//最後耳語(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 多明尼克的問候04
		Else 
			多明尼克的問候 = 多明尼克的問候 + 1
			Call 買多明尼克的問候
		End If
	End If
	
	If 多明尼克的問候 = 5 Then 
  		//多明尼克的問候(1)
  		子裝備 = 裝備
  		If 子裝備 <= 5 Then 
			Call 多明尼克的問候05
		Else 
			多明尼克的問候 = 多明尼克的問候 + 1
			Call 買多明尼克的問候
		End If
	End If
	
	If 多明尼克的問候 = 6 Then 
		//買完多明尼克的問候了
		裝備 = 裝備 + 1
		dm.KeyPress 80
		Delay 200
		Call 買裝備
	End If	
End Sub
//長劍(1)
Sub 多明尼克的問候01
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完多明尼克的問候了
	Else 
 		//TracePrint "買成功了"
		多明尼克的問候 = 多明尼克的問候 + 1
		Call 買多明尼克的問候	
	End If	
End Sub
//巨人殺手(1)
Sub 多明尼克的問候02
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "巨人殺手")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完多明尼克的問候了
	Else 
 		//TracePrint "買成功了"
		多明尼克的問候 = 多明尼克的問候 + 1
		Call 買多明尼克的問候	
	End If	
End Sub
//十字鎬(2)
Sub 多明尼克的問候03
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "十字鎬")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完多明尼克的問候了
	Else 
 		//TracePrint "買成功了"
		多明尼克的問候 = 多明尼克的問候 + 1
		Call 買多明尼克的問候	
	End If	
End Sub
//最後耳語(2)
Sub 多明尼克的問候04
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "最後耳語")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完多明尼克的問候了
	Else 
 		//TracePrint "買成功了"
		多明尼克的問候 = 多明尼克的問候 + 1
		Call 買多明尼克的問候	
	End If	
End Sub
//多明尼克的問候(1)
Sub 多明尼克的問候05
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "多明尼克的問候")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完多明尼克的問候了
	Else 
 		//TracePrint "買成功了"
		多明尼克的問候 = 多明尼克的問候 + 1
		Call 買多明尼克的問候	
	End If	
End Sub
//關掉商城，準備去戰鬥
Sub 買完多明尼克的問候了
	dm.MoveTo 797, 21
	Delay 200
	dm.LeftClick 
	Delay 10000
	If 左下為0右上為1 = 0 Then 
    	Goto 左下_是否開始戰鬥了
	Else 
		Goto 右上_是否開始戰鬥了
	End If	
End Sub

//買致死宣告
Sub 買致死宣告
	If 致死宣告 = 1 Then 
		//長劍(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 致死宣告01
		Else 
			致死宣告 = 致死宣告 + 1
			Call 買致死宣告
		End If	
	End If
	
	If 致死宣告 = 2 Then 
		//死刑宣告(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 致死宣告02
		Else 
			致死宣告 = 致死宣告 + 1
			Call 買致死宣告
		End If
	End If
	
	If 致死宣告 = 3 Then 
		//十字鎬(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 致死宣告03
		Else 
			致死宣告 = 致死宣告 + 1
			Call 買致死宣告
		End If
	End If
	
	If 致死宣告 = 4 Then 
		//最後耳語(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 致死宣告04
		Else 
			致死宣告 = 致死宣告 + 1
			Call 買致死宣告
		End If
	End If
	
	If 致死宣告 = 5 Then 
  		//致死宣告(1)
  		子裝備 = 裝備
  		If 子裝備 <= 5 Then 
			Call 致死宣告05
		Else 
			致死宣告 = 致死宣告 + 1
			Call 買致死宣告
		End If
	End If
	
	If 致死宣告 = 6 Then 
		//買完致死宣告了
		裝備 = 裝備 + 1
		dm.KeyPress 80
		Delay 200
		Call 買裝備
	End If	
End Sub
//長劍(1)
Sub 致死宣告01
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完致死宣告了
	Else 
 		//TracePrint "買成功了"
		致死宣告 = 致死宣告 + 1
		Call 買致死宣告	
	End If	
End Sub
//死刑宣告(1)
Sub 致死宣告02
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "死刑宣告")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完致死宣告了
	Else 
 		//TracePrint "買成功了"
		致死宣告 = 致死宣告 + 1
		Call 買致死宣告	
	End If	
End Sub
//十字鎬(2)
Sub 致死宣告03
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "十字鎬")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完致死宣告了
	Else 
 		//TracePrint "買成功了"
		致死宣告 = 致死宣告 + 1
		Call 買致死宣告	
	End If	
End Sub
//最後耳語(2)
Sub 致死宣告04
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "最後耳語")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完致死宣告了
	Else 
 		//TracePrint "買成功了"
		致死宣告 = 致死宣告 + 1
		Call 買致死宣告	
	End If	
End Sub
//致死宣告(1)
Sub 致死宣告05
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "致死宣告")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完致死宣告了
	Else 
 		//TracePrint "買成功了"
		致死宣告 = 致死宣告 + 1
		Call 買致死宣告	
	End If	
End Sub
//關掉商城，準備去戰鬥
Sub 買完致死宣告了
	dm.MoveTo 797, 21
	Delay 200
	dm.LeftClick 
	Delay 10000
	If 左下為0右上為1 = 0 Then 
    	Goto 左下_是否開始戰鬥了
	Else 
		Goto 右上_是否開始戰鬥了
	End If	
End Sub

//買衝擊火砲
Sub 買衝擊火砲
	If 衝擊火砲 = 1 Then 
		//短劍(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 衝擊火砲01
		Else 
			衝擊火砲 = 衝擊火砲 + 1
			Call 買衝擊火砲
		End If	
	End If
	
	If 衝擊火砲 = 2 Then 
		//科奇碎片(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 衝擊火砲02
		Else 
			衝擊火砲 = 衝擊火砲 + 1
			Call 買衝擊火砲
		End If
	End If
	
	If 衝擊火砲 = 3 Then 
		//格鬥手套(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 衝擊火砲03
		Else 
			衝擊火砲 = 衝擊火砲 + 1
			Call 買衝擊火砲
		End If
	End If
	
	If 衝擊火砲 = 4 Then 
		//短劍(3)
		子裝備 = 裝備 + 2
		If 子裝備 <= 5 Then 
			Call 衝擊火砲04
		Else 
			衝擊火砲 = 衝擊火砲 + 1
			Call 買衝擊火砲
		End If
	End If
	
	If 衝擊火砲 = 5 Then 
  		//狂熱雙刀(2)
  		子裝備 = 裝備 + 1
  		If 子裝備 <= 5 Then 
			Call 衝擊火砲05
		Else 
			衝擊火砲 = 衝擊火砲 + 1
			Call 買衝擊火砲
		End If
	End If
	
	If 衝擊火砲 = 6 Then 
  		//衝擊火砲(1)
  		子裝備 = 裝備
  		If 子裝備 <= 5 Then 
			Call 衝擊火砲06
		Else 
			衝擊火砲 = 衝擊火砲 + 1
			Call 買衝擊火砲
		End If
	End If
	
	If 衝擊火砲 = 7 Then 
		//買完衝擊火砲了
		裝備 = 裝備 + 1
		dm.KeyPress 80
		Delay 200
		Call 買裝備
	End If	
End Sub
//短劍(1)
Sub 衝擊火砲01
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "短劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完衝擊火砲了
	Else 
 		//TracePrint "買成功了"
		衝擊火砲 = 衝擊火砲 + 1
		Call 買衝擊火砲	
	End If	
End Sub
//科奇碎片(1)
Sub 衝擊火砲02
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "科奇碎片")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完衝擊火砲了
	Else 
 		//TracePrint "買成功了"
		衝擊火砲 = 衝擊火砲 + 1
		Call 買衝擊火砲	
	End If	
End Sub
//格鬥手套(2)
Sub 衝擊火砲03
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "格鬥手套")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完衝擊火砲了
	Else 
 		//TracePrint "買成功了"
		衝擊火砲 = 衝擊火砲 + 1
		Call 買衝擊火砲	
	End If	
End Sub
//短劍(3)
Sub 衝擊火砲04
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "短劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完衝擊火砲了
	Else 
 		//TracePrint "買成功了"
		衝擊火砲 = 衝擊火砲 + 1
		Call 買衝擊火砲	
	End If	
End Sub
//狂熱雙刀(2)
Sub 衝擊火砲05
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "狂熱雙刀")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick 
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完衝擊火砲了
	Else 
 		//TracePrint "買成功了"
		衝擊火砲 = 衝擊火砲 + 1
		Call 買衝擊火砲	
	End If	
End Sub
//衝擊火砲(1)
Sub 衝擊火砲06
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "衝擊火砲")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完衝擊火砲了
	Else 
 		//TracePrint "買成功了"
		衝擊火砲 = 衝擊火砲 + 1
		Call 買衝擊火砲	
	End If	
End Sub
//關掉商城，準備去戰鬥
Sub 買完衝擊火砲了
	dm.MoveTo 797, 21
	Delay 200
	dm.LeftClick 
	Delay 10000
	If 左下為0右上為1 = 0 Then 
    	Goto 左下_是否開始戰鬥了
	Else 
		Goto 右上_是否開始戰鬥了
	End If	
End Sub

//買史提克彈簧刀
Sub 買史提克彈簧刀
	If 史提克彈簧刀 = 1 Then 
		//短劍(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 史提克彈簧刀01
		Else 
			史提克彈簧刀 = 史提克彈簧刀 + 1
			Call 買史提克彈簧刀
		End If	
	End If
	
	If 史提克彈簧刀 = 2 Then 
		//科奇碎片(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 史提克彈簧刀02
		Else 
			史提克彈簧刀 = 史提克彈簧刀 + 1
			Call 買史提克彈簧刀
		End If
	End If
	
	If 史提克彈簧刀 = 3 Then 
		//格鬥手套(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 史提克彈簧刀03
		Else 
			史提克彈簧刀 = 史提克彈簧刀 + 1
			Call 買史提克彈簧刀
		End If
	End If
	
	If 史提克彈簧刀 = 4 Then 
		//短劍(3)
		子裝備 = 裝備 + 2
		If 子裝備 <= 5 Then 
			Call 史提克彈簧刀04
		Else 
			史提克彈簧刀 = 史提克彈簧刀 + 1
			Call 買史提克彈簧刀
		End If
	End If
	
	If 史提克彈簧刀 = 5 Then 
  		//狂熱雙刀(2)
  		子裝備 = 裝備 + 1
  		If 子裝備 <= 5 Then 
			Call 史提克彈簧刀05
		Else 
			史提克彈簧刀 = 史提克彈簧刀 + 1
			Call 買史提克彈簧刀
		End If
	End If
	
	If 史提克彈簧刀 = 6 Then 
  		//史提克彈簧刀(1)
  		子裝備 = 裝備
  		If 子裝備 <= 5 Then 
			Call 史提克彈簧刀06
		Else 
			史提克彈簧刀 = 史提克彈簧刀 + 1
			Call 買史提克彈簧刀
		End If
	End If
	
	If 史提克彈簧刀 = 7 Then 
		//買完史提克彈簧刀了
		裝備 = 裝備 + 1
		dm.KeyPress 80
		Delay 200
		Call 買裝備
	End If	
End Sub
//短劍(1)
Sub 史提克彈簧刀01
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "短劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完史提克彈簧刀了
	Else 
 		//TracePrint "買成功了"
		史提克彈簧刀 = 史提克彈簧刀 + 1
		Call 買史提克彈簧刀	
	End If	
End Sub
//科奇碎片(1)
Sub 史提克彈簧刀02
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "科奇碎片")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完史提克彈簧刀了
	Else 
 		//TracePrint "買成功了"
		史提克彈簧刀 = 史提克彈簧刀 + 1
		Call 買史提克彈簧刀	
	End If	
End Sub
//格鬥手套(2)
Sub 史提克彈簧刀03
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "格鬥手套")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完史提克彈簧刀了
	Else 
 		//TracePrint "買成功了"
		史提克彈簧刀 = 史提克彈簧刀 + 1
		Call 買史提克彈簧刀	
	End If	
End Sub
//短劍(3)
Sub 史提克彈簧刀04
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "短劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完史提克彈簧刀了
	Else 
 		//TracePrint "買成功了"
		史提克彈簧刀 = 史提克彈簧刀 + 1
		Call 買史提克彈簧刀	
	End If	
End Sub
//狂熱雙刀(2)
Sub 史提克彈簧刀05
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "狂熱雙刀")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick 
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完史提克彈簧刀了
	Else 
 		//TracePrint "買成功了"
		史提克彈簧刀 = 史提克彈簧刀 + 1
		Call 買史提克彈簧刀	
	End If	
End Sub
//史提克彈簧刀(1)
Sub 史提克彈簧刀06
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "史提克彈簧刀")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完史提克彈簧刀了
	Else 
 		//TracePrint "買成功了"
		史提克彈簧刀 = 史提克彈簧刀 + 1
		Call 買史提克彈簧刀	
	End If	
End Sub
//關掉商城，準備去戰鬥
Sub 買完史提克彈簧刀了
	dm.MoveTo 797, 21
	Delay 200
	dm.LeftClick 
	Delay 10000
	If 左下為0右上為1 = 0 Then 
    	Goto 左下_是否開始戰鬥了
	Else 
		Goto 右上_是否開始戰鬥了
	End If	
End Sub

//買芮蘭颶風箭
Sub 買芮蘭颶風箭
	If 芮蘭颶風箭 = 1 Then 
		//短劍(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 芮蘭颶風箭01
		Else 
			芮蘭颶風箭 = 芮蘭颶風箭 + 1
			Call 買芮蘭颶風箭
		End If	
	End If
	
	If 芮蘭颶風箭 = 2 Then 
		//短劍(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 芮蘭颶風箭02
		Else 
			芮蘭颶風箭 = 芮蘭颶風箭 + 1
			Call 買芮蘭颶風箭
		End If
	End If
	
	If 芮蘭颶風箭 = 3 Then 
		//反曲弓(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 芮蘭颶風箭03
		Else 
			芮蘭颶風箭 = 芮蘭颶風箭 + 1
			Call 買芮蘭颶風箭
		End If
	End If
	
	If 芮蘭颶風箭 = 4 Then 
		//格鬥手套(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 芮蘭颶風箭04
		Else 
			芮蘭颶風箭 = 芮蘭颶風箭 + 1
			Call 買芮蘭颶風箭
		End If
	End If
	
	If 芮蘭颶風箭 = 5 Then 
  		//短劍(3)
  		子裝備 = 裝備 + 2
  		If 子裝備 <= 5 Then 
			Call 芮蘭颶風箭05
		Else 
			芮蘭颶風箭 = 芮蘭颶風箭 + 1
			Call 買芮蘭颶風箭
		End If
	End If
	
	If 芮蘭颶風箭 = 6 Then 
  		//狂熱雙刀(2)
  		子裝備 = 裝備 + 1
  		If 子裝備 <= 5 Then 
			Call 芮蘭颶風箭06
		Else 
			芮蘭颶風箭 = 芮蘭颶風箭 + 1
			Call 買芮蘭颶風箭
		End If
	End If
	
	If 芮蘭颶風箭 = 7 Then 
  		//芮蘭颶風箭(1)
  		子裝備 = 裝備
  		If 子裝備 <= 5 Then 
			Call 芮蘭颶風箭07
		Else 
			芮蘭颶風箭 = 芮蘭颶風箭 + 1
			Call 買芮蘭颶風箭
		End If
	End If
	
	If 芮蘭颶風箭 = 8 Then 
		//買完芮蘭颶風箭了
		裝備 = 裝備 + 1
		dm.KeyPress 80
		Delay 200
		Call 買裝備
	End If	
End Sub
//短劍(1)
Sub 芮蘭颶風箭01	
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "短劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完芮蘭颶風箭了
	Else 
 		//TracePrint "買成功了"
		芮蘭颶風箭 = 芮蘭颶風箭 + 1
		Call 買芮蘭颶風箭	
	End If	
End Sub
//短劍(2)
Sub 芮蘭颶風箭02
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "短劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完芮蘭颶風箭了
	Else 
 		//TracePrint "買成功了"
		芮蘭颶風箭 = 芮蘭颶風箭 + 1
		Call 買芮蘭颶風箭	
	End If	
End Sub
//反曲弓(1)
Sub 芮蘭颶風箭03
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "反曲弓")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完芮蘭颶風箭了
	Else 
 		//TracePrint "買成功了"
		芮蘭颶風箭 = 芮蘭颶風箭 + 1
		Call 買芮蘭颶風箭	
	End If	
End Sub
//格鬥手套(2)
Sub 芮蘭颶風箭04
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "格鬥手套")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完芮蘭颶風箭了
	Else 
 		//TracePrint "買成功了"
		芮蘭颶風箭 = 芮蘭颶風箭 + 1
		Call 買芮蘭颶風箭	
	End If	
End Sub
//短劍(3)
Sub 芮蘭颶風箭05
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "短劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick 
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完芮蘭颶風箭了
	Else 
 		//TracePrint "買成功了"
		芮蘭颶風箭 = 芮蘭颶風箭 + 1
		Call 買芮蘭颶風箭	
	End If	
End Sub
//狂熱雙刀(2)
Sub 芮蘭颶風箭06
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "狂熱雙刀")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完芮蘭颶風箭了
	Else 
 		//TracePrint "買成功了"
		芮蘭颶風箭 = 芮蘭颶風箭 + 1
		Call 買芮蘭颶風箭	
	End If	
End Sub
//芮蘭颶風箭(1)
Sub 芮蘭颶風箭07
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "芮蘭颶風箭")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完芮蘭颶風箭了
	Else 
 		//TracePrint "買成功了"
		芮蘭颶風箭 = 芮蘭颶風箭 + 1
		Call 買芮蘭颶風箭	
	End If	
End Sub
//關掉商城，準備去戰鬥
Sub 買完芮蘭颶風箭了
	dm.MoveTo 797, 21
	Delay 200
	dm.LeftClick 
	Delay 10000
	If 左下為0右上為1 = 0 Then 
    	Goto 左下_是否開始戰鬥了
	Else 
		Goto 右上_是否開始戰鬥了
	End If	
End Sub

//買幻影之舞
Sub 買幻影之舞
	If 幻影之舞 = 1 Then 
		//格鬥手套(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 幻影之舞01
		Else 
			幻影之舞 = 幻影之舞 + 1
			Call 買幻影之舞
		End If	
	End If
	
	If 幻影之舞 = 2 Then 
		//短劍(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 幻影之舞02
		Else 
			幻影之舞 = 幻影之舞 + 1
			Call 買幻影之舞
		End If
	End If
	
	If 幻影之舞 = 3 Then 
		//狂熱雙刀(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 幻影之舞03
		Else 
			幻影之舞 = 幻影之舞 + 1
			Call 買幻影之舞
		End If
	End If
	
	If 幻影之舞 = 4 Then 
		//短劍(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 幻影之舞04
		Else 
			幻影之舞 = 幻影之舞 + 1
			Call 買幻影之舞
		End If
	End If
	
	If 幻影之舞 = 5 Then 
  		//短劍(3)
  		子裝備 = 裝備 + 2
  		If 子裝備 <= 5 Then 
			Call 幻影之舞05
		Else 
			幻影之舞 = 幻影之舞 + 1
			Call 買幻影之舞
		End If
	End If
	
	If 幻影之舞 = 6 Then 
  		//幻影之舞(1)
  		子裝備 = 裝備
  		If 子裝備 <= 5 Then 
			Call 幻影之舞06
		Else 
			幻影之舞 = 幻影之舞 + 1
			Call 買幻影之舞
		End If
	End If
	
	If 幻影之舞 = 7 Then 
		//買完幻影之舞了
		裝備 = 裝備 + 1
		dm.KeyPress 80
		Delay 200
		Call 買裝備
	End If	
End Sub
//格鬥手套(1)
Sub 幻影之舞01
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "格鬥手套")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完幻影之舞了
	Else 
 		//TracePrint "買成功了"
		幻影之舞 = 幻影之舞 + 1
		Call 買幻影之舞	
	End If	
End Sub
//短劍(2)
Sub 幻影之舞02
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "短劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完幻影之舞了
	Else 
 		//TracePrint "買成功了"
		幻影之舞 = 幻影之舞 + 1
		Call 買幻影之舞	
	End If	
End Sub
//狂熱雙刀(1)
Sub 幻影之舞03
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "狂熱雙刀")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完幻影之舞了
	Else 
 		//TracePrint "買成功了"
		幻影之舞 = 幻影之舞 + 1
		Call 買幻影之舞	
	End If	
End Sub
//短劍(2)
Sub 幻影之舞04
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "短劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完幻影之舞了
	Else 
 		//TracePrint "買成功了"
		幻影之舞 = 幻影之舞 + 1
		Call 買幻影之舞	
	End If	
End Sub
//短劍(3)
Sub 幻影之舞05
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "短劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick 
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完幻影之舞了
	Else 
 		//TracePrint "買成功了"
		幻影之舞 = 幻影之舞 + 1
		Call 買幻影之舞	
	End If	
End Sub
//幻影之舞(1)
Sub 幻影之舞06
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "幻影之舞")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完幻影之舞了
	Else 
 		//TracePrint "買成功了"
		幻影之舞 = 幻影之舞 + 1
		Call 買幻影之舞	
	End If	
End Sub
//關掉商城，準備去戰鬥
Sub 買完幻影之舞了
	dm.MoveTo 797, 21
	Delay 200
	dm.LeftClick 
	Delay 10000
	If 左下為0右上為1 = 0 Then 
    	Goto 左下_是否開始戰鬥了
	Else 
		Goto 右上_是否開始戰鬥了
	End If	
End Sub

//買史特拉克手套
Sub 買史特拉克手套
	If 史特拉克手套 = 1 Then 
		//長劍(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 史特拉克手套01
		Else 
			史特拉克手套 = 史特拉克手套 + 1
			Call 買史特拉克手套
		End If	
	End If
	
	If 史特拉克手套 = 2 Then 
		//紅水晶(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 史特拉克手套02
		Else 
			史特拉克手套 = 史特拉克手套 + 1
			Call 買史特拉克手套
		End If
	End If
	
	If 史特拉克手套 = 3 Then 
		//約瑞姆之拳(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 史特拉克手套03
		Else 
			史特拉克手套 = 史特拉克手套 + 1
			Call 買史特拉克手套
		End If
	End If
	
	If 史特拉克手套 = 4 Then 
		//長劍(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 史特拉克手套04
		Else 
			史特拉克手套 = 史特拉克手套 + 1
			Call 買史特拉克手套
		End If
	End If
	
	If 史特拉克手套 = 5 Then 
  		//史特拉克手套(1)
  		子裝備 = 裝備
  		If 子裝備 <= 5 Then 
			Call 史特拉克手套05
		Else 
			史特拉克手套 = 史特拉克手套 + 1
			Call 買史特拉克手套
		End If
	End If
	
	If 史特拉克手套 = 6 Then 
		//買完史特拉克手套了
		裝備 = 裝備 + 1
		dm.KeyPress 80
		Delay 200
		Call 買裝備
	End If	
End Sub
//長劍(1)
Sub 史特拉克手套01
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完史特拉克手套了
	Else 
 		//TracePrint "買成功了"
		史特拉克手套 = 史特拉克手套 + 1
		Call 買史特拉克手套	
	End If	
End Sub
//紅水晶(2)
Sub 史特拉克手套02
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "紅水晶")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完史特拉克手套了
	Else 
 		//TracePrint "買成功了"
		史特拉克手套 = 史特拉克手套 + 1
		Call 買史特拉克手套	
	End If	
End Sub
//約瑞姆之拳(1)
Sub 史特拉克手套03
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "約瑞姆之拳")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完史特拉克手套了
	Else 
 		//TracePrint "買成功了"
		史特拉克手套 = 史特拉克手套 + 1
		Call 買史特拉克手套	
	End If	
End Sub
//長劍(2)
Sub 史特拉克手套04
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完史特拉克手套了
	Else 
 		//TracePrint "買成功了"
		史特拉克手套 = 史特拉克手套 + 1
		Call 買史特拉克手套	
	End If	
End Sub
//史特拉克手套(1)
Sub 史特拉克手套05
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "史特拉克手套")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完史特拉克手套了
	Else 
 		//TracePrint "買成功了"
		史特拉克手套 = 史特拉克手套 + 1
		Call 買史特拉克手套	
	End If	
End Sub
//關掉商城，準備去戰鬥
Sub 買完史特拉克手套了
	dm.MoveTo 797, 21
	Delay 200
	dm.LeftClick 
	Delay 10000
	If 左下為0右上為1 = 0 Then 
    	Goto 左下_是否開始戰鬥了
	Else 
		Goto 右上_是否開始戰鬥了
	End If	
End Sub

//買殞落王者之劍
Sub 買殞落王者之劍
	If 殞落王者之劍 = 1 Then 
		//長劍(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 殞落王者之劍01
		Else 
			殞落王者之劍 = 殞落王者之劍 + 1
			Call 買殞落王者之劍
		End If	
	End If
	
	If 殞落王者之劍 = 2 Then 
		//吸血鬼權杖(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 殞落王者之劍02
		Else 
			殞落王者之劍 = 殞落王者之劍 + 1
			Call 買殞落王者之劍
		End If
	End If
	
	If 殞落王者之劍 = 3 Then 
		//長劍(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 殞落王者之劍03
		Else 
			殞落王者之劍 = 殞落王者之劍 + 1
			Call 買殞落王者之劍
		End If
	End If
	
	If 殞落王者之劍 = 4 Then 
		//比爾吉沃特彎刀(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 殞落王者之劍04
		Else 
			殞落王者之劍 = 殞落王者之劍 + 1
			Call 買殞落王者之劍
		End If
	End If
	
	If 殞落王者之劍 = 5 Then 
		//短劍(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 殞落王者之劍05
		Else 
			殞落王者之劍 = 殞落王者之劍 + 1
			Call 買殞落王者之劍
		End If
	End If
	
	If 殞落王者之劍 = 6 Then 
		//短劍(3)
		子裝備 = 裝備 + 2
		If 子裝備 <= 5 Then 
			Call 殞落王者之劍06
		Else 
			殞落王者之劍 = 殞落王者之劍 + 1
			Call 買殞落王者之劍
		End If
	End If
	
	If 殞落王者之劍 = 7 Then 
		//反曲弓(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 殞落王者之劍07
		Else 
			殞落王者之劍 = 殞落王者之劍 + 1
			Call 買殞落王者之劍
		End If
	End If
	
	If 殞落王者之劍 = 8 Then 
  		//殞落王者之劍(1)
  		子裝備 = 裝備
  		If 子裝備 <= 5 Then 
			Call 殞落王者之劍08
		Else 
			殞落王者之劍 = 殞落王者之劍 + 1
			Call 買殞落王者之劍
		End If
	End If
	
	If 殞落王者之劍 = 9 Then 
		//買完殞落王者之劍了
		裝備 = 裝備 + 1
		dm.KeyPress 80
		Delay 200
		Call 買裝備
	End If	
End Sub
//長劍(1)
Sub 殞落王者之劍01
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完殞落王者之劍了
	Else 
 		//TracePrint "買成功了"
		殞落王者之劍 = 殞落王者之劍 + 1
		Call 買殞落王者之劍	
	End If	
End Sub
//吸血鬼權杖(1)
Sub 殞落王者之劍02
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "吸血鬼權杖")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完殞落王者之劍了
	Else 
 		//TracePrint "買成功了"
		殞落王者之劍 = 殞落王者之劍 + 1
		Call 買殞落王者之劍	
	End If	
End Sub
//長劍(2)
Sub 殞落王者之劍03
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完殞落王者之劍了
	Else 
 		//TracePrint "買成功了"
		殞落王者之劍 = 殞落王者之劍 + 1
		Call 買殞落王者之劍	
	End If	
End Sub
//比爾吉沃特彎刀(1)
Sub 殞落王者之劍04
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "比爾吉沃特彎刀")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完殞落王者之劍了
	Else 
 		//TracePrint "買成功了"
		殞落王者之劍 = 殞落王者之劍 + 1
		Call 買殞落王者之劍	
	End If	
End Sub
//短劍(2)
Sub 殞落王者之劍05
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "短劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完殞落王者之劍了
	Else 
 		//TracePrint "買成功了"
		殞落王者之劍 = 殞落王者之劍 + 1
		Call 買殞落王者之劍	
	End If	
End Sub
//短劍(3)
Sub 殞落王者之劍06
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "短劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完殞落王者之劍了
	Else 
 		//TracePrint "買成功了"
		殞落王者之劍 = 殞落王者之劍 + 1
		Call 買殞落王者之劍	
	End If	
End Sub
//反曲弓(2)
Sub 殞落王者之劍07
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "反曲弓")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完殞落王者之劍了
	Else 
 		//TracePrint "買成功了"
		殞落王者之劍 = 殞落王者之劍 + 1
		Call 買殞落王者之劍	
	End If	
End Sub
//殞落王者之劍(1)
Sub 殞落王者之劍08
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "殞落王者之劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完殞落王者之劍了
	Else 
 		//TracePrint "買成功了"
		殞落王者之劍 = 殞落王者之劍 + 1
		Call 買殞落王者之劍	
	End If	
End Sub
//關掉商城，準備去戰鬥
Sub 買完殞落王者之劍了
	dm.MoveTo 797, 21
	Delay 200
	dm.LeftClick 
	Delay 10000
	If 左下為0右上為1 = 0 Then 
    	Goto 左下_是否開始戰鬥了
	Else 
		Goto 右上_是否開始戰鬥了
	End If	
End Sub

//買妖夢鬼刀
Sub 買妖夢鬼刀
	If 妖夢鬼刀 = 1 Then 
		//長劍(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 妖夢鬼刀01
		Else 
			妖夢鬼刀 = 妖夢鬼刀 + 1
			Call 買妖夢鬼刀
		End If	
	End If
	
	If 妖夢鬼刀 = 2 Then 
		//長劍(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 妖夢鬼刀02
		Else 
			妖夢鬼刀 = 妖夢鬼刀 + 1
			Call 買妖夢鬼刀
		End If
	End If
	
	If 妖夢鬼刀 = 3 Then 
		//考菲爾德的戰槌(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 妖夢鬼刀03
		Else 
			妖夢鬼刀 = 妖夢鬼刀 + 1
			Call 買妖夢鬼刀
		End If
	End If
	
	If 妖夢鬼刀 = 4 Then 
		//長劍(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 妖夢鬼刀04
		Else 
			妖夢鬼刀 = 妖夢鬼刀 + 1
			Call 買妖夢鬼刀
		End If
	End If
	
	If 妖夢鬼刀 = 5 Then 
		//長劍(3)
		子裝備 = 裝備 + 2
		If 子裝備 <= 5 Then 
			Call 妖夢鬼刀05
		Else 
			妖夢鬼刀 = 妖夢鬼刀 + 1
			Call 買妖夢鬼刀
		End If
	End If
	
	If 妖夢鬼刀 = 6 Then 
		//殘暴之力(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 妖夢鬼刀06
		Else 
			妖夢鬼刀 = 妖夢鬼刀 + 1
			Call 買妖夢鬼刀
		End If
	End If
	
	If 妖夢鬼刀 = 7 Then 
  		//妖夢鬼刀(1)
  		子裝備 = 裝備
  		If 子裝備 <= 5 Then 
			Call 妖夢鬼刀07
		Else 
			妖夢鬼刀 = 妖夢鬼刀 + 1
			Call 買妖夢鬼刀
		End If
	End If
	
	If 妖夢鬼刀 = 8 Then 
		//買完妖夢鬼刀了
		裝備 = 裝備 + 1
		dm.KeyPress 80
		Delay 200
		Call 買裝備
	End If	
End Sub
//長劍(1)
Sub 妖夢鬼刀01
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完妖夢鬼刀了
	Else 
 		//TracePrint "買成功了"
		妖夢鬼刀 = 妖夢鬼刀 + 1
		Call 買妖夢鬼刀	
	End If	
End Sub
//長劍(2)
Sub 妖夢鬼刀02
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完妖夢鬼刀了
	Else 
 		//TracePrint "買成功了"
		妖夢鬼刀 = 妖夢鬼刀 + 1
		Call 買妖夢鬼刀	
	End If	
End Sub
//考菲爾德的戰槌(1)
Sub 妖夢鬼刀03
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "考菲爾德的戰槌")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完妖夢鬼刀了
	Else 
 		//TracePrint "買成功了"
		妖夢鬼刀 = 妖夢鬼刀 + 1
		Call 買妖夢鬼刀	
	End If	
End Sub
//長劍(2)
Sub 妖夢鬼刀04
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完妖夢鬼刀了
	Else 
 		//TracePrint "買成功了"
		妖夢鬼刀 = 妖夢鬼刀 + 1
		Call 買妖夢鬼刀	
	End If	
End Sub
//長劍(3)
Sub 妖夢鬼刀05
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完妖夢鬼刀了
	Else 
 		//TracePrint "買成功了"
		妖夢鬼刀 = 妖夢鬼刀 + 1
		Call 買妖夢鬼刀	
	End If	
End Sub
//殘暴之力(2)
Sub 妖夢鬼刀06
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "殘暴之力")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完妖夢鬼刀了
	Else 
 		//TracePrint "買成功了"
		妖夢鬼刀 = 妖夢鬼刀 + 1
		Call 買妖夢鬼刀	
	End If	
End Sub
//妖夢鬼刀(1)
Sub 妖夢鬼刀07
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "妖夢鬼刀")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完妖夢鬼刀了
	Else 
 		//TracePrint "買成功了"
		妖夢鬼刀 = 妖夢鬼刀 + 1
		Call 買妖夢鬼刀	
	End If	
End Sub
//關掉商城，準備去戰鬥
Sub 買完妖夢鬼刀了
	dm.MoveTo 797, 21
	Delay 200
	dm.LeftClick 
	Delay 10000
	If 左下為0右上為1 = 0 Then 
    	Goto 左下_是否開始戰鬥了
	Else 
		Goto 右上_是否開始戰鬥了
	End If	
End Sub

//買夜色綠界
Sub 買夜色綠界
	If 夜色綠界 = 1 Then 
		//長劍(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 夜色綠界01
		Else 
			夜色綠界 = 夜色綠界 + 1
			Call 買夜色綠界
		End If	
	End If
	
	If 夜色綠界 = 2 Then 
		//長劍(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 夜色綠界02
		Else 
			夜色綠界 = 夜色綠界 + 1
			Call 買夜色綠界
		End If
	End If
	
	If 夜色綠界 = 3 Then 
		//殘暴之力(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 夜色綠界03
		Else 
			夜色綠界 = 夜色綠界 + 1
			Call 買夜色綠界
		End If
	End If
	
	If 夜色綠界 = 4 Then 
		//抗魔斗篷(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 夜色綠界04
		Else 
			夜色綠界 = 夜色綠界 + 1
			Call 買夜色綠界
		End If
	End If
	
	If 夜色綠界 = 5 Then 
		//十字鎬(3)
		子裝備 = 裝備 + 2
		If 子裝備 <= 5 Then 
			Call 夜色綠界05
		Else 
			夜色綠界 = 夜色綠界 + 1
			Call 買夜色綠界
		End If
	End If
	
	If 夜色綠界 = 6 Then 
  		//夜色綠界(1)
  		子裝備 = 裝備
  		If 子裝備 <= 5 Then 
			Call 夜色綠界06
		Else 
			夜色綠界 = 夜色綠界 + 1
			Call 買夜色綠界
		End If
	End If
	
	If 夜色綠界 = 7 Then 
		//買完夜色綠界了
		裝備 = 裝備 + 1
		dm.KeyPress 80
		Delay 200
		Call 買裝備
	End If	
End Sub
//長劍(1)
Sub 夜色綠界01
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完夜色綠界了
	Else 
 		//TracePrint "買成功了"
		夜色綠界 = 夜色綠界 + 1
		Call 買夜色綠界	
	End If	
End Sub
//長劍(2)
Sub 夜色綠界02
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "長劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完夜色綠界了
	Else 
 		//TracePrint "買成功了"
		夜色綠界 = 夜色綠界 + 1
		Call 買夜色綠界	
	End If	
End Sub
//殘暴之力(1)
Sub 夜色綠界03
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "殘暴之力")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完夜色綠界了
	Else 
 		//TracePrint "買成功了"
		夜色綠界 = 夜色綠界 + 1
		Call 買夜色綠界	
	End If	
End Sub
//抗魔斗篷(2)
Sub 夜色綠界04
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "抗魔斗篷")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完夜色綠界了
	Else 
 		//TracePrint "買成功了"
		夜色綠界 = 夜色綠界 + 1
		Call 買夜色綠界	
	End If	
End Sub
//十字鎬(3)
Sub 夜色綠界05
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "十字鎬")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完夜色綠界了
	Else 
 		//TracePrint "買成功了"
		夜色綠界 = 夜色綠界 + 1
		Call 買夜色綠界	
	End If	
End Sub
//夜色綠界(1)
Sub 夜色綠界06
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "夜色綠界")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完夜色綠界了
	Else 
 		//TracePrint "買成功了"
		夜色綠界 = 夜色綠界 + 1
		Call 買夜色綠界	
	End If	
End Sub
//關掉商城，準備去戰鬥
Sub 買完夜色綠界了
	dm.MoveTo 797, 21
	Delay 200
	dm.LeftClick 
	Delay 10000
	If 左下為0右上為1 = 0 Then 
    	Goto 左下_是否開始戰鬥了
	Else 
		Goto 右上_是否開始戰鬥了
	End If	
End Sub

//買鬼索的狂暴之刃
Sub 買鬼索的狂暴之刃
	If 鬼索的狂暴之刃 = 1 Then 
		//短劍(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 鬼索的狂暴之刃01
		Else 
			鬼索的狂暴之刃 = 鬼索的狂暴之刃 + 1
			Call 買鬼索的狂暴之刃
		End If	
	End If
	
	If 鬼索的狂暴之刃 = 2 Then 
		//短劍(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 鬼索的狂暴之刃02
		Else 
			鬼索的狂暴之刃 = 鬼索的狂暴之刃 + 1
			Call 買鬼索的狂暴之刃
		End If
	End If
	
	If 鬼索的狂暴之刃 = 3 Then 
		//反曲弓(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 鬼索的狂暴之刃03
		Else 
			鬼索的狂暴之刃 = 鬼索的狂暴之刃 + 1
			Call 買鬼索的狂暴之刃
		End If
	End If
	
	If 鬼索的狂暴之刃 = 4 Then 
		//十字鎬(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 鬼索的狂暴之刃04
		Else 
			鬼索的狂暴之刃 = 鬼索的狂暴之刃 + 1
			Call 買鬼索的狂暴之刃
		End If
	End If
	
	If 鬼索的狂暴之刃 = 5 Then 
		//爆裂魔杖(3)
		子裝備 = 裝備 + 2
		If 子裝備 <= 5 Then 
			Call 鬼索的狂暴之刃05
		Else 
			鬼索的狂暴之刃 = 鬼索的狂暴之刃 + 1
			Call 買鬼索的狂暴之刃
		End If
	End If
	
	If 鬼索的狂暴之刃 = 6 Then 
  		//鬼索的狂暴之刃(1)
  		子裝備 = 裝備
  		If 子裝備 <= 5 Then 
			Call 鬼索的狂暴之刃06
		Else 
			鬼索的狂暴之刃 = 鬼索的狂暴之刃 + 1
			Call 買鬼索的狂暴之刃
		End If
	End If
	
	If 鬼索的狂暴之刃 = 7 Then 
		//買完鬼索的狂暴之刃了
		裝備 = 裝備 + 1
		dm.KeyPress 80
		Delay 200
		Call 買裝備
	End If	
End Sub
//短劍(1)
Sub 鬼索的狂暴之刃01
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "短劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完鬼索的狂暴之刃了
	Else 
 		//TracePrint "買成功了"
		鬼索的狂暴之刃 = 鬼索的狂暴之刃 + 1
		Call 買鬼索的狂暴之刃	
	End If	
End Sub
//短劍(2)
Sub 鬼索的狂暴之刃02
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "短劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完鬼索的狂暴之刃了
	Else 
 		//TracePrint "買成功了"
		鬼索的狂暴之刃 = 鬼索的狂暴之刃 + 1
		Call 買鬼索的狂暴之刃	
	End If	
End Sub
//反曲弓(1)
Sub 鬼索的狂暴之刃03
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "反曲弓")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完鬼索的狂暴之刃了
	Else 
 		//TracePrint "買成功了"
		鬼索的狂暴之刃 = 鬼索的狂暴之刃 + 1
		Call 買鬼索的狂暴之刃	
	End If	
End Sub
//十字鎬(2)
Sub 鬼索的狂暴之刃04
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "十字鎬")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完鬼索的狂暴之刃了
	Else 
 		//TracePrint "買成功了"
		鬼索的狂暴之刃 = 鬼索的狂暴之刃 + 1
		Call 買鬼索的狂暴之刃	
	End If	
End Sub
//爆裂魔杖(3)
Sub 鬼索的狂暴之刃05
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "爆裂魔杖")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完鬼索的狂暴之刃了
	Else 
 		//TracePrint "買成功了"
		鬼索的狂暴之刃 = 鬼索的狂暴之刃 + 1
		Call 買鬼索的狂暴之刃	
	End If	
End Sub
//鬼索的狂暴之刃(1)
Sub 鬼索的狂暴之刃06
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "鬼索的狂暴之刃")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完鬼索的狂暴之刃了
	Else 
 		//TracePrint "買成功了"
		鬼索的狂暴之刃 = 鬼索的狂暴之刃 + 1
		Call 買鬼索的狂暴之刃	
	End If	
End Sub
//關掉商城，準備去戰鬥
Sub 買完鬼索的狂暴之刃了
	dm.MoveTo 797, 21
	Delay 200
	dm.LeftClick 
	Delay 10000
	If 左下為0右上為1 = 0 Then 
    	Goto 左下_是否開始戰鬥了
	Else 
		Goto 右上_是否開始戰鬥了
	End If	
End Sub

//買輕靈之靴
Sub 買輕靈之靴
	If 輕靈之靴 = 1 Then 
		//速度之靴(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 輕靈之靴01
		Else 
			輕靈之靴 = 輕靈之靴 + 1
			Call 買輕靈之靴
		End If	
	End If
	
	If 輕靈之靴 = 2 Then 
		//輕靈之靴(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 輕靈之靴02
		Else 
			輕靈之靴 = 輕靈之靴 + 1
			Call 買輕靈之靴
		End If
	End If
	
	If 輕靈之靴 = 3 Then 
		//買完輕靈之靴了
		裝備 = 裝備 + 1
		dm.KeyPress 80
		Delay 200
		Call 買裝備
	End If	
End Sub
//速度之靴(1)
Sub 輕靈之靴01
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "速度之靴")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完輕靈之靴了
	Else 
 		//TracePrint "買成功了"
		輕靈之靴 = 輕靈之靴 + 1
		Call 買輕靈之靴	
	End If	
End Sub
//輕靈之靴(1)
Sub 輕靈之靴02
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "輕靈之靴")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完輕靈之靴了
	Else 
 		//TracePrint "買成功了"
		輕靈之靴 = 輕靈之靴 + 1
		Call 買輕靈之靴	
	End If	
End Sub
//關掉商城，準備去戰鬥
Sub 買完輕靈之靴了
	dm.MoveTo 797, 21
	Delay 200
	dm.LeftClick 
	Delay 10000
	If 左下為0右上為1 = 0 Then 
    	Goto 左下_是否開始戰鬥了
	Else 
		Goto 右上_是否開始戰鬥了
	End If	
End Sub

//買水星之靴
Sub 買水星之靴
	If 水星之靴 = 1 Then 
		//速度之靴(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 水星之靴01
		Else 
			水星之靴 = 水星之靴 + 1
			Call 買水星之靴
		End If	
	End If
	
	If 水星之靴 = 2 Then 
		//抗魔斗篷(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 水星之靴02
		Else 
			水星之靴 = 水星之靴 + 1
			Call 買水星之靴
		End If
	End If
	
	If 水星之靴 = 3 Then 
		//水星之靴(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 水星之靴03
		Else 
			水星之靴 = 水星之靴 + 1
			Call 買水星之靴
		End If
	End If
	
	If 水星之靴 = 4 Then 
		//買完水星之靴了
		裝備 = 裝備 + 1
		dm.KeyPress 80
		Delay 200
		Call 買裝備
	End If	
End Sub
//速度之靴(1)
Sub 水星之靴01
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "速度之靴")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完水星之靴了
	Else 
 		//TracePrint "買成功了"
		水星之靴 = 水星之靴 + 1
		Call 買水星之靴	
	End If	
End Sub
//抗魔斗篷(2)
Sub 水星之靴02
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "抗魔斗篷")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完水星之靴了
	Else 
 		//TracePrint "買成功了"
		水星之靴 = 水星之靴 + 1
		Call 買水星之靴	
	End If	
End Sub
//水星之靴(1)
Sub 水星之靴03
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "水星之靴")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完水星之靴了
	Else 
 		//TracePrint "買成功了"
		水星之靴 = 水星之靴 + 1
		Call 買水星之靴	
	End If	
End Sub
//關掉商城，準備去戰鬥
Sub 買完水星之靴了
	dm.MoveTo 797, 21
	Delay 200
	dm.LeftClick 
	Delay 10000
	If 左下為0右上為1 = 0 Then 
    	Goto 左下_是否開始戰鬥了
	Else 
		Goto 右上_是否開始戰鬥了
	End If	
End Sub

//買狂戰士護脛
Sub 買狂戰士護脛
	If 狂戰士護脛 = 1 Then 
		//速度之靴(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 狂戰士護脛01
		Else 
			狂戰士護脛 = 狂戰士護脛 + 1
			Call 買狂戰士護脛
		End If	
	End If
	
	If 狂戰士護脛 = 2 Then 
		//短劍(2)
		子裝備 = 裝備 + 1
		If 子裝備 <= 5 Then 
			Call 狂戰士護脛02
		Else 
			狂戰士護脛 = 狂戰士護脛 + 1
			Call 買狂戰士護脛
		End If
	End If
	
	If 狂戰士護脛 = 3 Then 
		//狂戰士護脛(1)
		子裝備 = 裝備
		If 子裝備 <= 5 Then 
			Call 狂戰士護脛03
		Else 
			狂戰士護脛 = 狂戰士護脛 + 1
			Call 買狂戰士護脛
		End If
	End If
	
	If 狂戰士護脛 = 4 Then 
		//買完狂戰士護脛了
		裝備 = 裝備 + 1
		dm.KeyPress 80
		Delay 200
		Call 買裝備
	End If	
End Sub
//速度之靴(1)
Sub 狂戰士護脛01
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "速度之靴")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完狂戰士護脛了
	Else 
 		//TracePrint "買成功了"
		狂戰士護脛 = 狂戰士護脛 + 1
		Call 買狂戰士護脛	
	End If	
End Sub
//短劍(2)
Sub 狂戰士護脛02
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "短劍")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完狂戰士護脛了
	Else 
 		//TracePrint "買成功了"
		狂戰士護脛 = 狂戰士護脛 + 1
		Call 買狂戰士護脛	
	End If	
End Sub
//狂戰士護脛(1)
Sub 狂戰士護脛03
	Call 第幾個子裝備
	color_before = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	dm.MoveTo 56, 80
	Delay 200
	dm.LeftClick
	Delay 200
	dm_ret = dm.SendString2(hwnd, "狂戰士護脛")
	Delay 200
	dm.MoveTo 91, 118
	Delay 200
	dm.RightClick
	Delay 500
	color_after = dm.GetColorBGR(子裝備取色的x座標, 子裝備取色的y座標)
	Delay 200
	Call 判斷顏色是否相似
	If 顏色是否相似 Then 
 		//TracePrint "買失敗了"
 		Call 買完狂戰士護脛了
	Else 
 		//TracePrint "買成功了"
		狂戰士護脛 = 狂戰士護脛 + 1
		Call 買狂戰士護脛	
	End If	
End Sub
//關掉商城，準備去戰鬥
Sub 買完狂戰士護脛了
	dm.MoveTo 797, 21
	Delay 200
	dm.LeftClick 
	Delay 10000
	If 左下為0右上為1 = 0 Then 
    	Goto 左下_是否開始戰鬥了
	Else 
		Goto 右上_是否開始戰鬥了
	End If	
End Sub



Sub 第幾個子裝備
	If 子裝備 = 1 Then 
		子裝備取色的x座標 = 90
		子裝備取色的y座標 = 611
	End If
	If 子裝備 = 2 Then 
		子裝備取色的x座標 = 133
		子裝備取色的y座標 = 611
	End If
	If 子裝備 = 3 Then 
		子裝備取色的x座標 = 47
		子裝備取色的y座標 = 655
	End If
	If 子裝備 = 4 Then 
		子裝備取色的x座標 = 90
		子裝備取色的y座標 = 655
	End If
	If 子裝備 = 5 Then 
		子裝備取色的x座標 = 133
		子裝備取色的y座標 = 655
	End If
End Sub



Sub 判斷顏色是否相似
	//初始化顏色是否相似
	顏色是否相似 = True

	//把顏色取出來
	i = 0
	For 6
		color_before_split(i) = Mid(color_before, i + 1, 1)
		color_after_split(i) = Mid(color_after, i + 1, 1)
		//TracePrint color_before_split(i)
		i = i + 1
	Next
	
	//把顏色全部轉成數字
	i = 0
	For 6
		If color_before_split(i) = "a" Then 
			color_before_split(i) = 10
		End If
		If color_before_split(i) = "b" Then 
			color_before_split(i) = 11
		End If
		If color_before_split(i) = "c" Then 
			color_before_split(i) = 12
		End If
		If color_before_split(i) = "d" Then 
			color_before_split(i) = 13
		End If
		If color_before_split(i) = "e" Then 
			color_before_split(i) = 14
		End If
		If color_before_split(i) = "f" Then 
			color_before_split(i) = 15
		End If
		If color_after_split(i) = "a" Then 
			color_after_split(i) = 10
		End If
		If color_after_split(i) = "b" Then 
			color_after_split(i) = 11
		End If
		If color_after_split(i) = "c" Then 
			color_after_split(i) = 12
		End If
		If color_after_split(i) = "d" Then 
			color_after_split(i) = 13
		End If
		If color_after_split(i) = "e" Then 
			color_after_split(i) = 14
		End If
		If color_after_split(i) = "f" Then 
			color_after_split(i) = 15
		End If
		
		i = i + 1
	Next
	
	//判斷顏色是否相似
	i = 0
	For 6
		If -2 <= color_before_split(i) - color_after_split(i) <= 2 Then 
		Else 
			顏色是否相似 = False
		End If
	
		i = i + 1
	Next
End Sub
