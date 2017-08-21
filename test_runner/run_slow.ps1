#!/usr/local/bin/powershell

$elapsed = [System.Diagnostics.Stopwatch]::StartNew()
$specs = @(curl -s http://localhost:8888/api/getspecs)
$psSpecs = $specs | ConvertFrom-Json

write-host "* starting tests:" -foregroundcolor "green"
$elapsed = [System.Diagnostics.Stopwatch]::StartNew()

foreach ($spec in $psSpecs) {
    write-host ".. ",$spec.specFile -foregroundcolor "cyan"
    $url = "http://localhost:8888/api/runspec/" + $spec.specFile
    # $job = Start-Job -ScriptBlock {param($spec) 
    #     write-host "* test result for: ", $spec.specFile -foregroundcolor "yellow"
    #     $url = "http://localhost:8888/api/runspec/" + $spec.specFile
         curl -s $url 
    # } -Arg $spec -Name $spec.specFile
}

# write-host "* waiting for test job completion ... " -foregroundcolor "green"  

# Get-Job | Wait-Job
$finishTime = $elapsed.Elapsed.ToString()
# Get-Job | Receive-Job

write-host "** total", $psSpecs.count, "test specs are executed" -foregroundcolor "magenta"
write-host "** total elapsed Time: $finishTime" -foregroundcolor "magenta"