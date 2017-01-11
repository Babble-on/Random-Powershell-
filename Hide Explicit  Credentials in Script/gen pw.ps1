function GenPW()
	{
		for ($x = 0;$x -le $core.length;$x++)
			{
				if (($x % 2) -ne 0)
					{
						$global:pw+=$core[$x]
					}
			}
	}


	
$global:pw = ""
####  Change Username ####
$username = "$env:computername\###USERNAME####"
### Insert your password at every other character in the string below. ###
###  For Example if your password was "Password" then $core = 9Paagsbs1weo3r4d  ###
$core = "9agb1e34"
GenPW
$password = convertto-securestring $global:pw -asplaintext -force
$cred = New-Object System.Management.Automation.PsCredential($username,$password)