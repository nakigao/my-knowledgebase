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
$now = Get-Date -Format "yyyyMMddHHmmss"
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

try
{
    # variable for project
    $projectName = 'xxxxxxxxxx'

    # variable for local
    $localPath = "C:\local\to\$projectName"

    # variable for remote
    $remotePaths = @(
        "`"\\path\to\one\$projectName`"",
        "`"\\path\to\two\$projectName`""
    )

    # robocopy setup
    $robocopyOptions = @("`"/MIR`"", "`"/LEV:10`"", "`"/R:3`"", "`"/W:3`"")#, "`"/L`"")
    $excludeFiles = @(
        "`"Thumbs.db`"",
        "`"web.config`"",
        "`".gitkeep`"",
        "`".gitignore`"",
    )
    $excludeDirectories = @(
            "`"$localPath\.idea`"",
            "`"$localPath\.git`"",
            "`"$localPath\bin`""
    )

    # do sync
    foreach ($remotePath in $remotePaths) {
        robocopy "$localPath" "$remotePath" $robocopyOptions /XF $excludeFiles /XD $excludeDirectories
    }
}
finally
{
    Write-Output "Done! $($stopwatch.Elapsed)"
}