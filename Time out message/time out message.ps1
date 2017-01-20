$a = new-object -comobject wscript.shell 
$intAnswer = $a.popup("Your Order is Processing.  Please wait.",4,"Processing",0)
