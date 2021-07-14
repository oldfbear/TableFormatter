$s = Get-Clipboard
$num = $s[0].length - $s[0].replace("`t", "").length+1
if([String]::IsNullOrEmpty($s)){
	[reflection.assembly]::loadwithpartialname('System.Windows.Forms')
	[reflection.assembly]::loadwithpartialname('System.Drawing')
	$notify = new-object system.windows.forms.notifyicon
	$notify.icon = [System.Drawing.SystemIcons]::Exclamation
	$notify.visible = $true
	$notify.showballoontip(1,'TableFormatter','The text on the clipboard cannot be converted into the markdown table.',[system.windows.forms.tooltipicon]::None)
	exit
}
if($s.GetType().BaseType.Name -eq "Array" -and ($num) -gt 1){
	for($i = 0; $i -lt $s.length - 1; $i ++){
		$s[$i] ="| " + $s[$i].replace("`t", " | ") + " |"
		if($s[$i].Contains("`"")){
			$s[$i] = $s[$i].replace("`n", " <br> ")
			$s[$i] = $s[$i].replace("`"", "")
		}
	}

	$head = "|"

	for($i = 0; $i -lt $num; $i ++){
		$head = $head + " --- |"
	}
	$answer = @()
	$answer += $s[0]
	$answer += $head
	for($i = 1; $i -lt $s.length; $i ++){
		$answer += $s[$i]
	}
	set-Clipboard -value $answer
	[reflection.assembly]::loadwithpartialname('System.Windows.Forms')
	[reflection.assembly]::loadwithpartialname('System.Drawing')
	$notify = new-object system.windows.forms.notifyicon
	$notify.icon = [System.Drawing.SystemIcons]::Information
	$notify.visible = $true
	$notify.showballoontip(1,'TableFormatter','The table on the clipboard has been converted into the markdown style.',[system.windows.forms.tooltipicon]::None)
}else{
	[reflection.assembly]::loadwithpartialname('System.Windows.Forms')
	[reflection.assembly]::loadwithpartialname('System.Drawing')
	$notify = new-object system.windows.forms.notifyicon
	$notify.icon = [System.Drawing.SystemIcons]::Exclamation
	$notify.visible = $true
	$notify.showballoontip(1,'TableFormatter','The text on the clipboard cannot be converted into the markdown table.',[system.windows.forms.tooltipicon]::None)
}
exit
