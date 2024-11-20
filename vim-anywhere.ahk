#Requires AutoHotkey v2.0

^!V:: ; Ctrl + Alt + V
{
  Send("^c")
  try{
    Run '"powershell.exe" "-WindowStyle" "Hidden" ".\run.ps1" '
  }   
  catch{
    MsgBox "The script failed to run."
  }
  Return
}
