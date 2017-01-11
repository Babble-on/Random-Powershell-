Set oIE1 = WScript.CreateObject ("InternetExplorer.Application")

oIE1.Navigate "https://www.google.com"
oIE1.Visible = 1
oIE1.AddressBar = 0
oIE1.StatusBar = 0
oIE1.ToolBar = 0
oIE1.MenuBar = 0