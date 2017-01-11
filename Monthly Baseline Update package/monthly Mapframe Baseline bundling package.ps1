

################## Monthly Baseline bundling  for Mapframe Baseline Update ##############################################
################################################################################################
################## Server Location ###############################################################
$svr= ""
###################################################################################################
################### Select  Date for pdf copy ###################################################################
###$date =((get-date).AddDays(-122).ToString("yyyMMdd"))
$date=((get-date).adddays(-365))
###################################################################################################
################### Select  Date for folder creation ###################################################################
$todaydate =(get-date -Format y)
$backupname =(get-date -Format m)
$name = (get-date)
###################################################################################################
###################### Copy Location #############################################################
$dest = "D:\Mapframe"
##################################################################################################
######################## build unzip and zip functions ############################################
##################################################################################################
############################# unzip ###############################################################
function expand-ZIPfile ($file, $destination)
{
$zip= (Get-ChildItem -filter "*.zip" -recurse | select-object -first 1)
c:\unzip.exe -o -q "$zip" -d $all
Remove-Item $zip -Force
start-sleep -seconds 1
}
####################################################################################
#################################################################################
################################## zip ############################################
function Task ($file, $destination)
{
$PDFs = (Get-ChildItem -filter "*.PDF" | Select-object -first 500)
write-zip -path $pdfs -OutputPath ($name + ".zip")  -Level 9 -NoClobber
remove-item $PDFs -Force
Start-Sleep -Milliseconds 1750
if (!(test-path -Path "*.PDF")){break}
}
##################################################################################################
################################## zip zips ############################################
function zipped ($file, $destination)
{
$PDFs = (Get-ChildItem -filter "*.zip")
write-zip -path $pdfs -OutputPath ($name + ".UPDate")  -Level 9 -NoClobber
remove-item $PDFs -Force
Start-Sleep -Milliseconds 1750
if (!(test-path -Path "*.zip")){break}
}
##################################################################################################
##################################################################################################
######################## Make zipped monthly Dirs ###########################################################
mkdir -Path "$dest\4-monthly update zipped\$todaydate"
mkdir -Path "$dest\4-monthly update zipped\$todaydate\ALL"
mkdir -Path "$dest\4-monthly update zipped\$todaydate\ALLlst"
mkdir -Path "$dest\4-monthly update zipped\$todaydate\HAZ"
mkdir -Path "$dest\4-monthly update zipped\$todaydate\HAZlst"
mkdir -Path "$dest\4-monthly update zipped\$todaydate\HBG"
mkdir -Path "$dest\4-monthly update zipped\$todaydate\HBGlst"
mkdir -Path "$dest\4-monthly update zipped\$todaydate\LAN"
mkdir -Path "$dest\4-monthly update zipped\$todaydate\LANlst"
mkdir -Path "$dest\4-monthly update zipped\$todaydate\LEH"
mkdir -Path "$dest\4-monthly update zipped\$todaydate\LEHlst"
mkdir -Path "$dest\4-monthly update zipped\$todaydate\RDG"
mkdir -Path "$dest\4-monthly update zipped\$todaydate\RDGlst"
mkdir -Path "$dest\4-monthly update zipped\$todaydate\WeST"
mkdir -Path "$dest\4-monthly update zipped\$todaydate\WeSTlst"
##################################################################################################
######################## Make monthly backup Dirs ###########################################################
mkdir -Path "$dest\6-monthly backups\$todaydate"
mkdir -Path "$dest\6-monthly backups\$todaydate\ALL"
mkdir -Path "$dest\6-monthly backups\$todaydate\ALLlst"
mkdir -Path "$dest\6-monthly backups\$todaydate\HAZ"
mkdir -Path "$dest\6-monthly backups\$todaydate\HAZlst"
mkdir -Path "$dest\6-monthly backups\$todaydate\HBG"
mkdir -Path "$dest\6-monthly backups\$todaydate\HBGlst"
mkdir -Path "$dest\6-monthly backups\$todaydate\LAN"
mkdir -Path "$dest\6-monthly backups\$todaydate\LANlst"
mkdir -Path "$dest\6-monthly backups\$todaydate\LEH"
mkdir -Path "$dest\6-monthly backups\$todaydate\LEHlst"
mkdir -Path "$dest\6-monthly backups\$todaydate\RDG"
mkdir -Path "$dest\6-monthly backups\$todaydate\RDGlst"
mkdir -Path "$dest\6-monthly backups\$todaydate\WeST"
mkdir -Path "$dest\6-monthly backups\$todaydate\WeSTlst"
###############################################################################################
#### copy mbs files with a date greater then $date from the server to the junk dir ##########
set-location -path $svr\all
Get-ChildItem -file -Include *.mbs -Recurse | ? {$_.LastWriteTime -gt $date}| copy-item -Destination "$dest\7-junk\ALL"
set-location -path $svr\Harrisburg
Get-ChildItem -file -Include *.mbs -Recurse | ? {$_.LastWriteTime -gt $date} | copy-item -Destination "$dest\7-junk\HBG"
set-location -path $svr\Hazleton
Get-ChildItem -file -Include *.mbs -Recurse | ? {$_.LastWriteTime -gt $date} | copy-item -Destination "$dest\7-junk\HAZ"
set-location -path $svr\Lancaster
Get-ChildItem -file -Include *.mbs -Recurse | ? {$_.LastWriteTime -gt $date} | copy-item -Destination "$dest\7-junk\LAN"
set-location -path $svr\Lehigh
Get-ChildItem -File -Include *.mbs -Recurse | ? {$_.LastWriteTime -gt $date} | copy-item -Destination "$dest\7-junk\LEH"
set-location -path $svr\Reading
Get-ChildItem -File -Include *.mbs -Recurse | ? {$_.LastWriteTime -gt $date} | copy-item -Destination "$dest\7-junk\RDG"
set-location -path $svr\West
Get-ChildItem -File -Include *.mbs -Recurse | ? {$_.LastWriteTime -gt $date} | copy-item -Destination "$dest\7-junk\West"
Set-Location -Path $dest
#######################################################################################################
#######################################################################################################
################ Create .lst file all ####################################################################
Set-Location "$dest\7-junk\ALL"
Get-ChildItem -file "*.mbs" | Select-Object -Last 1 | select name  | out-file "temp.txt"
$lst = ((get-content "temp.txt" -TotalCount 4)[-1])
$lst = "lastupdate=" + "$lst"
$lst2 = "[ASBUILTFILESDOWNLOADED]"
$lst2 | out-file "asbuiltinventory.lst"
$lst | out-file -Append "asbuiltinventory.lst"
Remove-Item "temp.txt"
Copy-Item "asbuiltinventory.lst" -Destination "$dest\4-monthly update zipped\$todaydate\ALLlst"
Copy-Item "asbuiltinventory.lst" -Destination "$dest\6-monthly backups\$todaydate\ALLlst"
#######################################################################################################
################ Create .lst file haz ####################################################################
Set-Location "$dest\7-junk\haz"
Get-ChildItem -file "*.mbs" | Select-Object -Last 1 | select name  | out-file "temp.txt"
$lst = ((get-content "temp.txt" -TotalCount 4)[-1])
$lst = "lastupdate=" + "$lst"
$lst2 = "[ASBUILTFILESDOWNLOADED]"
$lst2 | out-file "asbuiltinventory.lst"
$lst | out-file -Append "asbuiltinventory.lst"
Remove-Item "temp.txt"
Copy-Item "asbuiltinventory.lst" -Destination "$dest\4-monthly update zipped\$todaydate\Hazlst"
Copy-Item "asbuiltinventory.lst" -Destination "$dest\6-monthly backups\$todaydate\Hazlst"
#######################################################################################################
################ Create .lst file hbg ####################################################################
Set-Location "$dest\7-junk\hbg"
Get-ChildItem -file "*.mbs" | Select-Object -Last 1 | select name  | out-file "temp.txt"
$lst = ((get-content "temp.txt" -TotalCount 4)[-1])
$lst = "lastupdate=" + "$lst"
$lst2 = "[ASBUILTFILESDOWNLOADED]"
$lst2 | out-file "asbuiltinventory.lst"
$lst | out-file -Append "asbuiltinventory.lst"
Remove-Item "temp.txt"
Copy-Item "asbuiltinventory.lst" -Destination "$dest\4-monthly update zipped\$todaydate\hbglst"
Copy-Item "asbuiltinventory.lst" -Destination "$dest\6-monthly backups\$todaydate\hbglst"
#######################################################################################################
################ Create .lst file lan ####################################################################
Set-Location "$dest\7-junk\lan"
Get-ChildItem -file "*.mbs" | Select-Object -Last 1 | select name  | out-file "temp.txt"
$lst = ((get-content "temp.txt" -TotalCount 4)[-1])
$lst = "lastupdate=" + "$lst"
$lst2 = "[ASBUILTFILESDOWNLOADED]"
$lst2 | out-file "asbuiltinventory.lst"
$lst | out-file -Append "asbuiltinventory.lst"
Remove-Item "temp.txt"
Copy-Item "asbuiltinventory.lst" -Destination "$dest\4-monthly update zipped\$todaydate\lanlst"
Copy-Item "asbuiltinventory.lst" -Destination "$dest\6-monthly backups\$todaydate\lanlst"
#######################################################################################################
################ Create .lst file leh ####################################################################
Set-Location "$dest\7-junk\leh"
Get-ChildItem -file "*.mbs" | Select-Object -Last 1 | select name  | out-file "temp.txt"
$lst = ((get-content "temp.txt" -TotalCount 4)[-1])
$lst = "lastupdate=" + "$lst"
$lst2 = "[ASBUILTFILESDOWNLOADED]"
$lst2 | out-file "asbuiltinventory.lst"
$lst | out-file -Append "asbuiltinventory.lst"
Remove-Item "temp.txt"
Copy-Item "asbuiltinventory.lst" -Destination "$dest\4-monthly update zipped\$todaydate\lehlst"
Copy-Item "asbuiltinventory.lst" -Destination "$dest\6-monthly backups\$todaydate\lehlst"
#######################################################################################################
################ Create .lst file rdg ####################################################################
Set-Location "$dest\7-junk\rdg"
Get-ChildItem -file "*.mbs" | Select-Object -Last 1 | select name  | out-file "temp.txt"
$lst = ((get-content "temp.txt" -TotalCount 4)[-1])
$lst = "lastupdate=" + "$lst"
$lst2 = "[ASBUILTFILESDOWNLOADED]"
$lst2 | out-file "asbuiltinventory.lst"
$lst | out-file -Append "asbuiltinventory.lst"
Remove-Item "temp.txt"
Copy-Item "asbuiltinventory.lst" -Destination "$dest\4-monthly update zipped\$todaydate\rdglst"
Copy-Item "asbuiltinventory.lst" -Destination "$dest\6-monthly backups\$todaydate\rdglst"
#######################################################################################################
################ Create .lst file wst ####################################################################
Set-Location "$dest\7-junk\wst"
Get-ChildItem -file "*.mbs" | Select-Object -Last 1 | select name  | out-file "temp.txt"
$lst = ((get-content "temp.txt" -TotalCount 4)[-1])
$lst = "lastupdate=" + "$lst"
$lst2 = "[ASBUILTFILESDOWNLOADED]"
$lst2 | out-file "asbuiltinventory.lst"
$lst | out-file -Append "asbuiltinventory.lst"
Remove-Item "temp.txt"
Copy-Item "asbuiltinventory.lst" -Destination "$dest\4-monthly update zipped\$todaydate\westlst"
Copy-Item "asbuiltinventory.lst" -Destination "$dest\6-monthly backups\$todaydate\westlst"
###################### rename .mbs files in junk ti .zip ############################################
Set-Location "$dest"
Get-ChildItem -Path "7-junk" -recurse -filter "*.mbs" | Rename-item -NewName {$_.Name -replace ".mbs",".zip"} -Force
##############################################################################################
##############################################################################################
#############################################################################################
################## begin unpack loops for junk folders ########################################
########################################################################################
$all = "$dest\7-junk\all"
##############################################################################################
Set-Location -Path $all
$allzip= Get-ChildItem -Filter "*.zip"
foreach ($i in $allzip)
{
Expand-ZIPFile
}
##############################################################################################
$all = "$dest\7-junk\HBG"
##############################################################################################
Set-Location -Path $all
$allzip= Get-ChildItem -Filter "*.zip"
foreach ($i in $allzip)
{
Expand-ZIPFile
}
##############################################################################################
$all = "$dest\7-junk\HAZ"
##############################################################################################
Set-Location -Path $all
$allzip= Get-ChildItem -Filter "*.zip"
foreach ($i in $allzip)
{
Expand-ZIPFile
}
##############################################################################################
$all = "$dest\7-junk\LAN"
##############################################################################################
Set-Location -Path $all
$allzip= Get-ChildItem -Filter "*.zip"
foreach ($i in $allzip)
{
Expand-ZIPFile
}
##############################################################################################
$all = "$dest\7-junk\LEH"
##############################################################################################
Set-Location -Path $all
$allzip= Get-ChildItem -Filter "*.zip"
foreach ($i in $allzip)
{
Expand-ZIPFile
}
##############################################################################################
$all = "$dest\7-junk\RDG"
##############################################################################################
Set-Location -Path $all
$allzip= Get-ChildItem -Filter "*.zip"
foreach ($i in $allzip)
{
Expand-ZIPFile
}
##############################################################################################
$all = "$dest\7-junk\WeST"
##############################################################################################
Set-Location -Path $all
$allzip= Get-ChildItem -Filter "*.zip"
foreach ($i in $allzip)
{
Expand-ZIPFile
}
#################################################################################################
##################################################################################################
######################  Zipping files in junk pre copy ##########################################
########################################################################################
$all = "$dest\7-junk\all"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.pdf"
foreach ($i in $allpdf)
{
Task
$name = (get-date -Format dddMMMyyyyhhmmss)
}
###############################################################################################
########################################################################################
$all = "$dest\7-junk\HBG"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.pdf"
foreach ($i in $allpdf)
{
Task
$name = (get-date -Format dddMMMyyyyhhmmss)
}
###############################################################################################
########################################################################################
$all = "$dest\7-junk\HAZ"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.pdf"
foreach ($i in $allpdf)
{
Task
$name = (get-date -Format dddMMMyyyyhhmmss)
}
###############################################################################################
########################################################################################
$all = "$dest\7-junk\LAN"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.pdf"
foreach ($i in $allpdf)
{
Task
$name = (get-date -Format dddMMMyyyyhhmmss)
}
###############################################################################################
########################################################################################
$all = "$dest\7-junk\LEH"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.pdf"
foreach ($i in $allpdf)
{
Task
$name = (get-date -Format dddMMMyyyyhhmmss)
}
###############################################################################################
########################################################################################
$all = "$dest\7-junk\RDG"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.pdf"
foreach ($i in $allpdf)
{
Task
$name = (get-date -Format dddMMMyyyyhhmmss)
}
###############################################################################################
########################################################################################
$all = "$dest\7-junk\west"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.pdf"
foreach ($i in $allpdf)
{
Task
$name = (get-date -Format dddMMMyyyyhhmmss)
}
###############################################################################################
##############################################################################################




###############################################################################################
###############################################################################################
#################### copy new zips to monthly update zipped and backup ###################################
########################################################################################
$all = "$dest\7-junk\all"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.zip"
Copy-Item $allpdf -Destination "$dest\4-monthly update zipped\$todaydate\ALL"
Copy-Item $allpdf -Destination "$dest\6-monthly backups\$todaydate\ALL"
Remove-Item -Path "$all\*.*"
########################################################################################
$all = "$dest\7-junk\HBG"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.zip"
Copy-Item $allpdf -Destination "$dest\4-monthly update zipped\$todaydate\HBG"
Copy-Item $allpdf -Destination "$dest\6-monthly backups\$todaydate\HBG"
Remove-Item -Path "$all\*.*"
########################################################################################
$all = "$dest\7-junk\HAZ"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.zip"
Copy-Item $allpdf -Destination "$dest\4-monthly update zipped\$todaydate\HAZ"
Copy-Item $allpdf -Destination "$dest\6-monthly backups\$todaydate\HAZ"
Remove-Item -Path "$all\*.*"
########################################################################################
$all = "$dest\7-junk\lan"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.zip"
Copy-Item $allpdf -Destination "$dest\4-monthly update zipped\$todaydate\LAN"
Copy-Item $allpdf -Destination "$dest\6-monthly backups\$todaydate\LAN"
Remove-Item -Path "$all\*.*"
########################################################################################
$all = "$dest\7-junk\leh"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.zip"
Copy-Item $allpdf -Destination "$dest\4-monthly update zipped\$todaydate\LEH"
Copy-Item $allpdf -Destination "$dest\6-monthly backups\$todaydate\LEH"
Remove-Item -Path "$all\*.*"
########################################################################################
$all = "$dest\7-junk\RDG"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.zip"
Copy-Item $allpdf -Destination "$dest\4-monthly update zipped\$todaydate\RDG"
Copy-Item $allpdf -Destination "$dest\6-monthly backups\$todaydate\RDG"
Remove-Item -Path "$all\*.*"
########################################################################################
$all = "$dest\7-junk\west"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.zip"
Copy-Item $allpdf -Destination "$dest\4-monthly update zipped\$todaydate\WeST"
Copy-Item $allpdf -Destination "$dest\6-monthly backups\$todaydate\WeST"
Remove-Item -Path "$all\*.*"
########################################################################################
######################  Zipping files in backup dirs for data consistency #################
########################################################################################
$all = "$dest\6-monthly backups\$todaydate\ALL"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.zip"
foreach ($i in $allpdf)
{
zipped
$name = (get-date -Format dddMMMyyyyhhmmss)
}
###############################################################################################
########################################################################################
$all = "$dest\6-monthly backups\$todaydate\Haz"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.zip"
foreach ($i in $allpdf)
{
zipped
$name = (get-date -Format dddMMMyyyyhhmmss)
}
###############################################################################################
########################################################################################
$all = "$dest\6-monthly backups\$todaydate\HBG"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.zip"
foreach ($i in $allpdf)
{
zipped
$name = (get-date -Format dddMMMyyyyhhmmss)
}
###############################################################################################
########################################################################################
$all = "$dest\6-monthly backups\$todaydate\LAN"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.zip"
foreach ($i in $allpdf)
{
zipped
$name = (get-date -Format dddMMMyyyyhhmmss)
}
###############################################################################################
########################################################################################
$all = "$dest\6-monthly backups\$todaydate\LEH"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.zip"
foreach ($i in $allpdf)
{
zipped
$name = (get-date -Format dddMMMyyyyhhmmss)
}
###############################################################################################
########################################################################################
$all = "$dest\6-monthly backups\$todaydate\RDG"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.zip"
foreach ($i in $allpdf)
{
zipped
$name = (get-date -Format dddMMMyyyyhhmmss)
}
###############################################################################################
########################################################################################
$all = "$dest\6-monthly backups\$todaydate\WeST"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.zip"
foreach ($i in $allpdf)
{
zipped
$name = (get-date -Format dddMMMyyyyhhmmss)
}
###############################################################################################
################################################################################################
############################ cleaning up backup ##############################################
################################## zip ############################################
$all = "$dest\6-monthly backups"
set-location $all
write-zip -path "$All\$todaydate" -OutputPath ($backupname + ".zip")  -Level 9 -NoClobber
Start-Sleep -Seconds 6






Get-ChildItem -Path $all -Exclude "*.zip" | Remove-Item -Recurse -Force -Confirm:$false
##############################################################################################
#############################################################################################
########################################################################################
######################  Zipping files to prep update package #################
########################################################################################
$all = "$dest\4-monthly update zipped\$todaydate\ALL"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.zip"
foreach ($i in $allpdf)
{
zipped
$name = (get-date -Format dddMMMyyyyhhmmss)
}
Get-ChildItem -Path "$all" -recurse -filter "*.update" | Rename-item -NewName {$_.Name -replace ".update",".zip"} -Force
###############################################################################################
########################################################################################
$all = "$dest\4-monthly update zipped\$todaydate\Haz"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.zip"
foreach ($i in $allpdf)
{
zipped
$name = (get-date -Format dddMMMyyyyhhmmss)
}
Get-ChildItem -Path "$all" -recurse -filter "*.update" | Rename-item -NewName {$_.Name -replace ".update",".zip"} -Force
###############################################################################################
########################################################################################
$all = "$dest\4-monthly update zipped\$todaydate\HBG"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.zip"
foreach ($i in $allpdf)
{
zipped
$name = (get-date -Format dddMMMyyyyhhmmss)
}
Get-ChildItem -Path "$all" -recurse -filter "*.update" | Rename-item -NewName {$_.Name -replace ".update",".zip"} -Force
###############################################################################################
########################################################################################
$all = "$dest\4-monthly update zipped\$todaydate\LAN"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.zip"
foreach ($i in $allpdf)
{
zipped
$name = (get-date -Format dddMMMyyyyhhmmss)
}
Get-ChildItem -Path "$all" -recurse -filter "*.update" | Rename-item -NewName {$_.Name -replace ".update",".zip"} -Force
###############################################################################################
########################################################################################
$all = "$dest\4-monthly update zipped\$todaydate\LEH"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.zip"
foreach ($i in $allpdf)
{
zipped
$name = (get-date -Format dddMMMyyyyhhmmss)
}
Get-ChildItem -Path "$all" -recurse -filter "*.update" | Rename-item -NewName {$_.Name -replace ".update",".zip"} -Force
###############################################################################################
########################################################################################
$all = "$dest\4-monthly update zipped\$todaydate\RDG"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.zip"
foreach ($i in $allpdf)
{
zipped
$name = (get-date -Format dddMMMyyyyhhmmss)
}
Get-ChildItem -Path "$all" -recurse -filter "*.update" | Rename-item -NewName {$_.Name -replace ".update",".zip"} -Force
###############################################################################################
########################################################################################
$all = "$dest\4-monthly update zipped\$todaydate\WeST"
##############################################################################################
Set-Location -Path $all
$allpdf = Get-ChildItem -Filter "*.zip"
foreach ($i in $allpdf)
{
zipped
$name = (get-date -Format dddMMMyyyyhhmmss)
}
Get-ChildItem -Path "$all" -recurse -filter "*.update" | Rename-item -NewName {$_.Name -replace ".update",".zip"} -Force
###############################################################################################
################################################################################################
################## CREATE UPDATE PACKAGE ###############################################
#############################################################################################
########################### mkdir for update package #######################################
Set-Location "$dest\3-zipped additions to be added to baseline"
if (!(test-path -Path "$dest\3-zipped additions to be added to baseline\!!! Update list !!!")){mkdir "$dest\3-zipped additions to be added to baseline\!!! Update list !!!"}
mkdir "$dest\3-zipped additions to be added to baseline\$todaydate"
$from = "$dest\4-monthly update zipped\$todaydate"
$package = "$dest\3-zipped additions to be added to baseline\$todaydate"
Set-Location $package
mkdir "ALL"
mkdir "ALLlst"
mkdir "HAZ"
mkdir "HAZlst"
mkdir "HBG"
mkdir "HBGlst"
mkdir "LAN"
mkdir "LANlst"
mkdir "LEH"
mkdir "LEHlst"
mkdir "RDG"
mkdir "RDGlst"
mkdir "WeST"
mkdir "WeSTlst"
##############################################################################################
###############################################################################################
######################## move .lst files ######################################################
Move-Item -Path "$from\alllst\*.lst" -Destination $package\Alllst
Move-Item -Path "$from\hazlst\*.lst" -Destination $package\hazlst
Move-Item -Path "$from\hbglst\*.lst" -Destination $package\hbglst
Move-Item -Path "$from\lanlst\*.lst" -Destination $package\lanlst
Move-Item -Path "$from\lehlst\*.lst" -Destination $package\lehlst
Move-Item -Path "$from\rdglst\*.lst" -Destination $package\rdglst
Move-Item -Path "$from\westlst\*.lst" -Destination $package\westlst
##############################################################################################
###############################################################################################
######################## move pdfs files ######################################################
Move-Item -Path "$from\all\*.zip" -Destination $package\All
Move-Item -Path "$from\haz\*.zip" -Destination $package\haz
Move-Item -Path "$from\hbg\*.zip" -Destination $package\hbg
Move-Item -Path "$from\lan\*.zip" -Destination $package\lan
Move-Item -Path "$from\leh\*.zip" -Destination $package\leh
Move-Item -Path "$from\rdg\*.zip" -Destination $package\rdg
Move-Item -Path "$from\west\*.zip" -Destination $package\west
##############################################################################################
##############################################################################################
############################ modify update list ##############################################
if (!(test-path -Path "$dest\3-zipped additions to be added to baseline\!!! Update list !!!\Updates")){mkdir -Path "$dest\3-zipped additions to be added to baseline\!!! Update list !!!\Updates"}

Copy-Item "$dest\6-monthly Backups\$backupname.zip" -Destination "$dest\3-zipped additions to be added to baseline\!!! Update list !!!\Updates"
get-childitem -path "$dest\3-zipped additions to be added to baseline\!!! Update list !!!\Updates\$backupname.zip" | Rename-Item -Path "$dest\3-zipped additions to be added to baseline\!!! Update list !!!\Updates\$backupname.zip" -NewName {$_.Name -replace "$backupname.zip" , "$name.update"}
remove-item -Path "$dest\4-Monthly Update Zipped\*" -Recurse -Force

