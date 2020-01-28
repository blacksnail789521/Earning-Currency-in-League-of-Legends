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
UEsDBBQAAgAIAGCtlUpNfw2jVQQAAAgyAAAJABEAVUlQYWNrYWdlVVQNAAf0fPpY9Hz6WPR8+ljtWUlPVEEQ/t4My7DIJowKLoMb4IYo7sZEjEQTt8jowUSTUXEdBjOMBuNP8OJf4ODJkwc9eNGLZ42Jd028+Ae4yfj1W5yGQHi9YIuhSE3DMPW+rq6uqv56kgjk86fWb1OvO79jjpxAEjPlOtRI73mh+tICJMK/Z8rlcvR2eUWWlfyiVoUxFLGuptZS66gpaj11FbWB2khtCkKPZmordTW1jdpOTVM7qGvC582sLO8/L5cxzp8SMjiNAscinkJF0twx0bO8RT774uuzoy/fffGS/P3DquC9KziLvdCXFDwvwk8vghuN8v9OIYtzBjOoZwWM8Ks18LNc70cYxQXkMMZRVdqQ8P1vDWtvXLuqcIzy9H/UFVlchseLYwbpB2E/YGDvwUxM7U3lzdTHnyb+K6Tsktjr1p1K/UvMOvPFjVlUK0XXyeEm8ppzaGL9awjPKXHxE1L9u4r7mKDqzqBFw/+khH+ZqDncxkWuQ16x90b1vzF8Zlz8Kgk/S/xJ9n2D+Huq/ldL8T/F00eeWtScSbsGfo3kfwV/iHG4hYfq+P55uVlh/WvnxP+W4fqLo1RKAT+F4Awvy3UmxTSWn9Q6xp+ef839tnR+JDOSK0xkRkaL9+8sEf62VzeM7K+x8hRZf0b5qiOi/naEORV3/9VJ+/8cc08962bv/5bweXHx6+fN/xHO4x7XQa0brmX+Rxw4Ln6DhH+Sp/9Hfg8oUgucg1oXStP/OgS8PC5+o4Q/TN8LZvVHuf+JenX8j/95dt+7nINY94JO/VfGb5oV/xzXv8Q5iHUY8uMQdYLK3lhYejX6T7OEP+Q/P8i/OHjz7D+vHZV7tzg2LRK+af0wPX+aytDjUmm8YGqvf4Jf7vwly51f8s++OrvPrz/K+dcq7b9LxJ8kep6ncB1p0sBvm5X/4v5HP/718DzBJ/qo6xb4zN+4/1HxX/Sr6F7fBf8T9So6t9ngf5s4bkT8/tcBt/wvDbv8L4Pgzj0u/hq45X9r4Zb/rYNd/tfFcYvC+nfCLv/r5rheAb8LFf73avrthMv7K9PzxyT1ATXFqvpcw951/006xrfB/7aFezru/lsPu/xva1hT4uJvgF3+18NxuwL+Rtjlf8KfzQr4m+CW/2VQ4X8uzn/dkv8X/NiPce3z2vxL4PYqrP9mCf8M8Z5os78g/qr+b5HwXd9f9b+9Z2Q/+N7Mvmsqa2Rvh3/u07Y37V+XuN9GmXsTfL2tsQc7NfJvK+byL33/5e/fdy3wmX+Nf4l+6ZJ/iV5lk3+J6A0o1L8euOVfvbDLv/Zz3KHgfx/c8i8x12pL9cNUBP/YZ2Dvmn9kvYB//NDkHwnH6++Cf++EXf69h+NBhfzbBbv8e5BjvwL+blT4tw3+dTh8Zlz8PbDLvw6FMY2L3w+7/OsoxyMK+Hthl3+J5x1QwB+AW/4l6m3Ev1zfP6zwjyxcigv+vR/2+fcxhfwbhFv+fQDy919/n38dlPB/A1BLAQIXCxQAAgAIAGCtlUpNfw2jVQQAAAgyAAAJAAkAAAAAAAAAAAAAgAAAAABVSVBhY2thZ2VVVAUAB/R8+lhQSwUGAAAAAAEAAQBAAAAAjQQAAAAA


[Script]
//大漠一開始的設定
call Plugin.Regdll.reg("c:\game_script\dm.dll")
Set dm = createobject("dm.dmsoft")



遊戲編號 = 1
sandbox = 遊戲編號
遊戲大廳 = "Sandbox:Box" & sandbox & ":Chrome_RenderWidgetHostHWND"
//遊戲大廳 = "Sandbox:Box" & sandbox & ":RCLIENT"
//遊戲大廳 = "Sandbox:Box" & sandbox & ":RCLIENT"




//綁定遊戲大廳
Rem 綁定遊戲大廳_遊戲開始
//找到遊戲大廳的窗口句柄
hwnd = dm.FindWindow("Sandbox:Box1:RCLIENT","League of Legends")
//hwnd = Plugin.Window.Find("Sandbox:Box1:Chrome_WidgetWin_0","")

//一定要找到窗口才要激活以及綁定
If hwnd = 0 Then 
	Delay 1000
	Goto 綁定遊戲大廳_遊戲開始
Else 
	TracePrint hwnd
	//獲得最上層的視窗的句柄
	//最上層的視窗 = dm.GetForegroundWindow()
End If


//hwnd = 1377480
//hwnd = 1641116
//hwnd = 854274
//hwnd = 463262

//激活窗口並綁定
dm_ret = dm.SetWindowState(hwnd,1)
//dm_ret = dm.BindWindow(hwnd, "normal", "dx", "dx", 2)
//dm_ret = dm.BindWindow(hwnd, "dx", "dx", "dx", 2)
dm_ret = dm.BindWindow(hwnd, "gdi", "windows3", "dx", 0)
Delay 1000



dm_ret = dm.Capture(0, 0, 2000, 2000, "C:\pic\screen.bmp")

color = Plugin.Bkgnd.GetPixelColor(hwnd, 1110, 56)
TracePrint color

dm.MoveTo 120, 40
Delay 200
dm.LeftClick
Delay 1000

dm.MoveTo 177, 98
Delay 200
dm.LeftClick
Delay 1000

dm.MoveTo 389, 509
Delay 200
dm.LeftClick
Delay 1000

dm.MoveTo 614, 687
Delay 200
dm.LeftClick
Delay 3000

dm.MoveTo 438, 685
Delay 200
dm.LeftClick
Delay 1000