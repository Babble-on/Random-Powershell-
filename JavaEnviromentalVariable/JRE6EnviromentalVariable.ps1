new-variable JPATH -Value "C:\clone\!! win7\! Troubleshooting\"
if (!(test-path -path "$JPATH\Jpath")){mkdir -path "$Jpath\JPATH"}
if (!(test-path -path "$JPATH\Jpath\VariableSet.flg")){set-variable FLAG -Value "FALSE"}
if ((test-path -path "$JPATH\Jpath\VariableSet.flg")){set-variable FLAG -Value "True"}
if ((test-path -path "C:\Program Files\Java\jre1.6.0_26") -or (test-path -Path "C:\Program Files (x86)\Java\jre1.6.0_26")){Set-Variable EXIST -Value "TRUE"}
if (!(test-path -path "C:\Program Files\Java\jre1.6.0_26") -or (test-path -Path "C:\Program Files (x86)\Java\jre1.6.0_26")){Set-Variable EXIST -Value "FALSE"}
if ((test-path -path "C:\Program Files\Java\jre1.6.0_26")){Set-Variable Ver -Value "64"}
if ((test-path -path "C:\Program Files (x86)\Java\jre1.6.0_26")){Set-Variable Ver -Value "86"}
start-sleep -seconds 5
if (($FLAG -eq "FALSE") -and ($EXIST -eq "TRUE") -and ($ver -eq "64")){[Environment]::SetEnvironmentVariable("JRE_HOME", "C:\Program Files\Java\jre1.6.0_26", "Machine");(add-content -path "C:\clone\!! win7\! Troubleshooting\JPATH\VariableSet.flg" -value "64")}
if (($FLAG -eq "FALSE") -and ($EXIST -eq "TRUE") -and ($ver -eq "86")){[Environment]::SetEnvironmentVariable("JRE_HOME", "C:\Program Files (x86)\Java\jre1.6.0_26", "Machine");(add-content -path "C:\clone\!! win7\! Troubleshooting\JPATH\VariableSet.flg" -value "86")}
elseif (($FLAG -eq "FALSE") -and ($EXIST -eq "FALSE")){
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 
[System.Windows.Forms.MessageBox]::Show("ERROR!!!   , JAVA jre1.6.0_26 is NOT yet been installed on this machine or the folder is not correctly named jre1.6.0_26.", "S. B.")
}
elseif (($FLAG -eq "True") -and ($EXIST -eq "True")){
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 
[System.Windows.Forms.MessageBox]::Show("SUCCESS!!!   , JAVA jre1.6.0_26 is installed and the enviromental variable has already been set.", "S. B.")
}
elseif (($FLAG -eq "True") -and ($EXIST -eq "False")){
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 
[System.Windows.Forms.MessageBox]::Show("ERROR!!!   , The Enviromental Variable Flag exists but JAVA has not been installed or the folder is named incorrectly. Please contact your system Administrator for assistance", "S. B.")
}
start-sleep -seconds 2
exit
