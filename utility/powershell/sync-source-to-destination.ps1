#
# PowerShell Script:
# Directory Sync via robocopy
#
# Usage:
# 1. exec PowerShell with administrator mode
# 2. Set-ExecutionPolicy RemoteSigned
# 3. `powershell .\SCRIPT_NAME` or `powershell -noexit .\SCRIPT_NAME`
#

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$scriptPath = Split-Path $(if ($PSVersionTable.PSVersion.Major -ge 3) { $PSCommandPath } else { & { $MyInvocation.ScriptName } })
$now = Get-Date -Format "yyyyMMdd"
$logFile = "$scriptPath\log\$now-robocopy-mirror.log"
# $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

try
{
    $sourcePath = '\\sourceservername\path\to'
    $destinationPaths = @(
    '\\destinationservername\path\to'
    # ... more ...
    )
    $robocopyOptions = @('"/MIR"', '"/E"', '"/LEV:10"', '"/R:0"', '"/FFT"', '"/IPG:15"', '"/NP"', '"/NFL"', '"/NDL"', '"/L"')
    $excludeFiles = @('"Thumbs.db"')
    foreach ($destinationPath in $destinationPaths) {
        robocopy "$sourcePath" "$destinationPath" $robocopyOptions /XF $excludeFiles /LOG+:$logFile
    }
}
finally
{
    # Write-Output "Done! $($stopwatch.Elapsed)"
}
