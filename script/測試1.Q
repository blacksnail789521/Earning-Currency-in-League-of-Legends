[General]
SyntaxVersion=2
BeginHotkey=112
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=2c01151d-65b9-40ec-b667-237ed4b75a63
Description=測試1
Enable=0
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

[UIPackage]
UEsDBBQAAgAIAIp4kkkoKTdJUAQAAAgyAAAJABEAVUlQYWNrYWdlVVQNAAdlpVZYZaVWWGWlVljtWUtPU0EU/m4LUh7yEqqCjyKi+EQU38ZEjEQTRSLVGBNNquKzFFOqwb07fwVrVy50qxvXGn+BJm6Me1ZK/eY+7EAg3HnogOGQ04HSud+cc+acM980iUA+fWz5Mv264yvmyWkkMVuuxRrpPS9UX5qBRPj3bLlcjt4ur8qKkl/UqjCGItbV1BpqLTVFraOupdZTG6iNQejRRG2hrqO2UtuoaWo7dX34vNlV9y57uYIJ/pSQwTkUOBbxHCqS5o6JnuUt8dmR3IsfP69/9pL8/f3a4L2ruIAD0JcUPC/CTy+BG43y/84ii4sGK6hjBYzwqzXws/T3E4xhGDmMc1SVViR8+1vC2ht3XlU4Rnn6P+qqLC1DE8Vxg/SDmN9vMN+DmZjON5U30x++m9ivkLJ/Zb5u3anUv8ScM1/cmEW1UnSdHG4jr7mGRta/+vCcEhc/IdW/a3iISaruCpo17E9K+FeImsNdXKYf8oq9N6r/DeEz4+JXSfhZ4k+x7xvE31O1v1qK/1mePvLUouZK2jTw10j2V/AHGYc7eKyO75+XmxT8XzMv/ncM/S+OUikF/BSCM7wsN5kUM1h5UuMYf2Zhn/tt6dJoZjRXmMyMjhUf3vtL+D2vbhnNv8HKU2T9GeOrjoj62x7mVNz9Vyvt/4vMPfWsm7v/m8PnxcWvWzD/R7mOB/SDWjfcwPyPOHBc/HoJ/wxP/0/8HlCkFrgGtS6Upv21CHh5XPwGCX+IthfM6o9y/xP16tQf+/Psvve5BuH3gk79V8ZvnBP/HP1f4hqEHwb9OESdoLI3Fpdejf7TJOEP+s8P8i8O3gL7z2tD5d4tzpxmCd+0fpieP01l8GmpNFEwna9/gl/p/CXLnV/yz746u8+vP8r51yLtvxHiTxE9z1O4jjRq4LfOyX9x/6Mf/zp4nuATu6gbF/nMv7j/UbFf9KvoXt8F/xP1Kjq32eB/WzluQfz+1w63/C8Nu/wvg+DOPS7+erjlfxvglv9thF3+18mxW8H/HbDL/7o4blLA70SF/72aeTvp8v7K9PwxRX1ETbGqvtSY77r/Jh3j2+B/PeGejrv/NsEu/9se1pS4+Jthl//t5LhDAX8L7PI/Yc82BfytcMv/MqjwPxfnvy7J/mE/9uP0fV6bfwncXgX/b5PwzxPvmTb7C+Kvan+3hO/6/qrv7QOj+QPvzOZ3TmeN5tvhnwe155v2rxHutzHm3iRf72rswQ6N/NuO+fxL3375+/e9i9m4zPiX6Jcu+ZfoVTb5l4hev0L92wm3/KsXdvnXIY67FezfBbf8S6y12lL9MBXBPw4azHfNP7JewD++afKPhGP/u+Dfe2CXf+/neEQh//bCLv8e4NingL8PFf5tg38dC58ZF38/7PKvo2FM4+L3wS7/OsHxuAL+AdjlX+J5hxXw++GWf4l6G/Ev1/cPq/wjC5fign8fgn3+fVIh/wbgln8fhvz917/nX0ck/N9QSwECFwsUAAIACACKeJJJKCk3SVAEAAAIMgAACQAJAAAAAAAAAAAAAIAAAAAAVUlQYWNrYWdlVVQFAAdlpVZYUEsFBgAAAAABAAEAQAAAAIgEAAAAAA==


[Script]
//大漠一開始的設定
call Plugin.Regdll.reg("c:\game_script\dm.dll")
Set dm = createobject("dm.dmsoft")


遊戲編號 = 1
sandbox = 遊戲編號
遊戲大廳 = "Sandbox:Box" & sandbox & ":ApolloRuntimeContentWindow"
遊戲主程式 = "Sandbox:Box" & sandbox & ":RiotWindowClass"



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





color = Plugin.Bkgnd.GetPixelColor(hwnd, 667, 514)
TracePrint color