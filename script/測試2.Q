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
UEsDBBQAAgAIAOg4IkoPw6FQhwMAAAgmAAAJABEAVUlQYWNrYWdlVVQNAAdI/GlYSPxpWEj8aVjtWEtPU0EUPrfl0RbsA6FAQSgvZacmLo2PEokmiIRWFyaaVKhC7IO01eBWfwlrNrqQnXHlWuMvkKUrd+ykfnPvXDslEOZx4drIIacDl577zZz3mSA59O1r4sfWh9QuHaAbFKT9Rpi6hGcWZ5viRAH+936j0XAfN86oreg3uIPbkNm6E9wNDoND4Aj4HLgH3AuOOqanGDjB5fbP1Ni2tEwV/NQpTXeojLVKb0iFkvAY913WMd99/+nm7rvV71YQv98KO88e0j26QvoUIsty8QPH4Lqr+L85ytGCwQ4iHD/JY0cVPwd9b1CBFilPJayq1EcBGz/Bc6+sXAdf3fj9l/iMTo/mK9WSQfgRk79qIG+RGZnKm9LHrS8/Tc6vELInIq+bd5r5L9DS88nazM2VrOrk6RkVNfcQRf7r4X2KLH5AyH+PaJ1qYN0dxDXOHxTwl4Gap1V6AD0UFWuvm/97+Ttl8TsE/BzwN1H3DexvqZ6/U7D/HLqPIriquZN+Dfwu4fxN/AzssEIv1fHtfjmmoP/uA/ZfMdQ/689DCvghcnp4kZ4gKPao/ajbZ/y9w3Vul6X72XQ2X66ls4Xq+vMTwp/Zfmok/xiZp4r8U8CnDrH8O8BjStb/woL/LyD21KOu1f/j/H2y+JFD4z+LfaxBD2rVcAjxf55YHpbH7xHwb6P737BrQBVcxh7UqlAS5w+TM5fL4vcK+PM4e9ks/yjXP5avrv89fxHV9wX2wPRe1sn/yvjRFvvnof869sD0kLHt4FaCpm8cTbMa9Scm4Gfs9zvxJ4N3iP9Z/dS8d5ORiQv4pvnDtP80pcyrer1SNpXX7+DbfX7JwfPrdu+r4312/lGOv4Tgf0vA3wR6EV24DkU18Pta4p/d/+jbPwILutjDR3znNO5/VM7P6pV7r+/H/Mfyldu3eTH/jWMdI/n6N0D+zn9J8nb+S2MdVDj/IPk7/w2Rv/PfMHk7/41gnVLQf4q8nf8msI4q4I9Qc/7b3tup+Xl/Zdp//AKz2aqCrPpWQ97v+hv0Gd+L+W+G+7Ss/42St/PfNM8psvgXyNv57xLWiwr4Y+Tt/MfOM6mAP07+zn9pas5/fvR/E8L5F23bl6D7ovb8xXBnFfQ/KeDfBd5r7enPsb/q+acEfL/vry7vrBnJX/tsJj+ylaP/mZbgbwXEXg2fqxo+mNKIv2nB/7wgVXyvqZ3x/wBQSwECFwsUAAIACADoOCJKD8OhUIcDAAAIJgAACQAJAAAAAAAAAAAAAIAAAAAAVUlQYWNrYWdlVVQFAAdI/GlYUEsFBgAAAAABAAEAQAAAAL8DAAAAAA==


[Script]
//大漠一開始的設定
call Plugin.Regdll.reg("c:\game_script\dm.dll")
Set dm = createobject("dm.dmsoft")






主機 = Plugin.File.ReadINI("computer", "computer", "C:\lol_local\lol_local.ini")
lol路徑 = "C:\Dropbox\lol\"
自己資料夾路徑 = lol路徑 & 主機 & "\"
ini路徑 = 自己資料夾路徑 & 主機 & ".ini"
champion路徑 = lol路徑 & "others\global_files\champion.ini"
level路徑 = lol路徑 & "others\global_files\level\level (輪班3).ini"

TracePrint champion路徑
Text = dm.ReadIni("英雄列表", "英雄3", champion路徑)
TracePrint Text






TracePrint level路徑

Text = dm.ReadIni("01-gin", "game2", level路徑)
TracePrint Text
