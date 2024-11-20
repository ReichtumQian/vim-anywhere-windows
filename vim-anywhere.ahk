#Requires AutoHotkey v2.0

^!V:: ; Ctrl + Alt + V
{
  A_Clipboard := ""
  Send("^c")
  try{
    Run '"powershell.exe" "-WindowStyle" "Hidden" ".\run.ps1" '
  }   
  catch{
    MsgBox "The script failed to run."
  }
  Return
}
