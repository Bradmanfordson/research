# Alias Shenanigans

While working on the GRTP I saw that the ordering of PowerShell's search is:
1. Alias
2. Function
3. Cmdlet
4. External scripts (ps1, etc)
5. External executables (exe)

This made me wonder what I could do with aliases and functions.


## First Observation:
Turns out, you can make an alias name BASICALLY anything. There are very very little restrictions with this. 
For example, the following aliases are 100% valid:
``` powershell
Set-Alias -Name cmd -Value C:\Windows\System32\calc.exe
Set-Alias -Name cmd.exe -Value C:\Windows\System32\calc.exe
Set-Alias -Name .\cmd.exe -Value C:\Windows\System32\calc.exe
Set-Alias -Name C:\Windows\System32\cmd.exe -Value C:\Windows\System32\calc.exe
```
Yeah... This actually works. You effectively overwrite the path search with an alias because alias' are evaluated first. 


## Second Observation:
You can make aliases with spaces in them.
Unfortunately, calling the aliases afterwards isn't quite as interesting as it sounds.
``` powershell
# Setting the Alias
Set-Alias -Name "Hello, World!" -Value calc.exe

# Calling/Using the Alias
& "Hello, World!"
```

## Third Observation
Aliases are higher on the search path than cmdlets. We can effectively overwrite cmdlets to do our own bidding.
For example, lets presume you have the following, simple, PowerShell Script:
`greet.ps1`
``` powershell
Write-Host "Hello, World!"
```

If you create an alias that overwrites `Write-Host` your alias will be evaluated when this script is ran (as long as it's in your context in the same powershell environment that the alias is set with)
So, if we do,
``` powershell
Set-Alias -Name Write-Host -Value calc.exe
```
The calculator will run when `greet.ps1` is ran instead of outputting "Hello, World!"


## Forth Observation
Functions are evaluated higher than cmdlets too. So instead of just opening up the calculator, we can incorporate a lot of functionality.
For example, take the following PowerShell function which overwrites the `Write-Host` cmdlet to open the calculator and then utilize the fully qualified module name to call the real `Write-Host`.
``` powershell
function Write-Host {
    param (
        [string]$UserInput
    )
    Start-Process calc.exe

    Microsoft.Powershell.Utility\Write-Host "$UserInput"
}
```
This can be a sneaky way to overwrite some legitimate functionality and still have it look legit (obviously not opening calculator but something actually interesting)


## Fifth Observation
Basically, same as observation 1, except this time we're overwriting the fully qualified module name:
``` powershell
Set-Alias -Name Microsoft.Powershell.Utility\Write-Host -Value calc.exe
```


## Sixth Observation
Windows has a `profile` feature just like *nix. The location can be found by running `$PROFILE` in Powershell. The location is typically C:\Users\<user>\Documents\WindowsPowerShell\profile.ps1.
We can combine what we've seen thusfar to make a profile which overwrites as much functionality as we want. 


TODO - finish observations
TODO - Write better.....
TODO - talk about -NoProfile
TODO - talk about loading data into profile into memory

