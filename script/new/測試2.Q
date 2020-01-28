[General]
SyntaxVersion=2
BeginHotkey=113
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=9c0ff7e6-a110-45b7-8ce5-945b942db1e9
Description=測試2
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
UEsDBBQAAgAIAGCtlUrF1b3BigMAAAgmAAAJABEAVUlQYWNrYWdlVVQNAAf0fPpY9Hz6WPR8+ljtWL1PU1EUP68t0BYsLUL5FMqXsqmJkzFGSySaIBJaHEw0qVCFWFrSVoOLg/9JBycmBxlcnJwl/gXq5uTGJvV337vP3hII9+PBs5FDTi88et7v3vN9bpAc2v2S+FZ7P/SdDtBNCtJ+PULtwjOLs01xogD/e79er7uP62fUUvQbHOI2ZLZuA3eAI+AwOAo+B+4Ed4FjjumpG5zgcvtnamxZWqISfqqUojtUxFqm16RCSXiM+y7rmO/u/nhz/d3Hr1YQv9+KOM+W6R5dIX0Kk2W5+IFjcN1V/N8sZWneYAdRjp/ksaOKn4W+NylPC5SjDayq1EMBGz/Bc6+sXIivbvz+S3xGp0dzpfKGQfgRk79qIG+RGZnKm9KH2uefJudXCNkTkdfNO438F2jq+WRt5uZKVnVy9JQKmnuIIf918j5FFj8g5L+HtE4VsO4O4hrnDwr4S0DN0So9gB4KirXXzf9d/J2y+CEBPwv8LdR9A/tbqudvE+w/i+6jAC5r7qRXA79dOH8DPw07rNALdXy7X+5W0H/HAfuvGOqf9edhBfwwOT28SI8RFHvUetThM/7e4Tq3y9L9TCqTK1ZSmXx5/dkJ4U9vPzGSf4TMU0b+yeNTh1j+7eMxJet/EcH/5xF76lHX7P9x/j5Z/Oih8Z/BPtagB7VqOID4P08sD8vjdwr4t9H9b9o1oAwuYg9qVSiJ80fImctl8bsE/DmcvWiWf5TrH8tXN/6ev4Dq+xx7YHov6uR/ZfxYk/1z0H8Ve2B6SNt2cCtBwzeOphmN+tMt4Kft9zvxJ4N3iP9ZvdS4d5ORiQv4pvnDtP80pfTLarVUNJXX7+BbfX7JwvOrdu+r4312/lGOv4Tgf4vA3wJ6AV24DsU08Hua4p/d/+jbPwoLutiDR3znNO5/VM7P6pV7r+/H/Mfyldu3eTH/jWEdJfn610f+zn9J8nb+S2HtVzh/P/k7/w2Qv/PfIHk7/w1jnVTQ/xB5O/+NYx1RwB+mxvy3vbdT8fP+yrT/+AVms1UJWfWthrzf9TfoM74X898092lZ/xshb+e/KZ5TZPEvkLfz3yWsFxXwR8nb+Y+dZ0IBf4z8nf9S1Jj//Oj/xoXzL9i234DuC9rzF8OdUdD/hIB/F3ivtKc/x/6q558U8P2+v7q8s2Ykf+2TmfxwLUv/My3C3/KIvQo+VzV8cEgj/qYE//OCVPG9plbG/wNQSwECFwsUAAIACABgrZVKxdW9wYoDAAAIJgAACQAJAAAAAAAAAAAAAIAAAAAAVUlQYWNrYWdlVVQFAAf0fPpYUEsFBgAAAAABAAEAQAAAAMIDAAAAAA==


[Script]
//大漠一開始的設定
call Plugin.Regdll.reg("c:\game_script\dm.dll")
Set dm = createobject("dm.dmsoft")





hwnd = dm.FindWindow("Sandbox:Box1:RCLIENT","League of Legends")
TracePrint hwnd

hwnd = dm.FindWindow("Sandbox:Box1:CefBrowserWindow","")
TracePrint hwnd

hwnd = dm.FindWindow("Sandbox:Box1:Chrome_WidgetWin_0","")
TracePrint hwnd

hwnd = dm.FindWindow("Sandbox:Box1:Chrome_RenderWidgetHostHWND","Chrome Legacy Window")
TracePrint hwnd



Hwnd = Plugin.Window.Find("Sandbox:Box1:RCLIENT","League of Legends")
TracePrint Hwnd

Hwnd = Plugin.Window.Find("Sandbox:Box1:CefBrowserWindow","")
TracePrint Hwnd

Hwnd = Plugin.Window.Find("Sandbox:Box1:Chrome_WidgetWin_0","")
TracePrint Hwnd

Hwnd = Plugin.Window.Find("Sandbox:Box1:Chrome_RenderWidgetHostHWND","Chrome Legacy Window")
TracePrint Hwnd