#!/usr/local/bin/powershell

$elapsed = [System.Diagnostics.Stopwatch]::StartNew()
$specs = @(curl -s http://localhost:8888/api/specs)
$psSpecs = $specs | ConvertFrom-Json
$jobs = @()

write-host "* starting tests:" -foregroundcolor "green"
$elapsed = [System.Diagnostics.Stopwatch]::StartNew()

foreach ($spec in $psSpecs) {
    write-host ".. ",$spec.specFile
    $url = "http://localhost:8888/api/runspec/" + $spec.specFile
    
    $job = Start-Job -ScriptBlock {param($spec) 
        write-host "* test result for: ", $spec.specFile -foregroundcolor "yellow"
        $url = "http://localhost:8888/api/runspec/" + $spec.specFile
        curl -s $url 
    } -Arg $spec
    $jobs += $job

}

write-host "* waiting for test results... " -foregroundcolor "green"

foreach ($executedJob in $jobs){
    Wait-Job $executedJob
    Receive-Job $executedJob
}

write-host "** total", $psSpecs.count, "test specs are executed" -foregroundcolor "magenta"
write-host "** total elapsed Time: $($elapsed.Elapsed.ToString())" -foregroundcolor "magenta"