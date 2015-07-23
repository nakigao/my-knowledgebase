get-childitem -Path E:\inetpub\logs\LogFiles -recurse |
where-object {$_.lastwritetime -lt (get-date).addMonths(-2)} |
Foreach-Object { del $_.FullName }