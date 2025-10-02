# Alias Injection

While working on the GRTP I saw that the ordering of PowerShell's search is:
1. alias
2. function
3. cmdlet
4. external scripts (ps1, etc)
5. external executables (exe)

This made me wonder what I could do with aliases.

## First finding:
Turns out, you can make an alias name BASICALLY anything. There are very very little restrictions with this. 
For example, the following aliases are 100% valid:
``` powershell
Set-Alias -Name cmd -Value C:\Windows\System32\calc.exe
Set-Alias -Name cmd.exe -Value C:\Windows\System32\calc.exe
Set-Alias -Name .\cmd.exe -Value C:\Windows\System32\calc.exe
Set-Alias -Name C:\Windows\System32\cmd.exe -Value C:\Windows\System32\calc.exe
```
Yeah... This actually works. You effectively overwrite the path search with an alias because alias' are evaluated first. 



TODO:
- complete PoC for using aliases to inject into processes
- alias's with spaces for obfuscation
- functions for all the above
- attack thoughts and more PoC's 