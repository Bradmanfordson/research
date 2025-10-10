$hw = "hello world"

function Get-HW {
    return $hw
}
Export-ModuleMember -Variable $hw
Export-ModuleMember -Function Get-HW