$s = Get-Clipboard
$num = $s[0].Length - $s[0].Replace("`t", "").Length+1
if([String]::IsNullOrEmpty($s)){
	[Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
	[Reflection.Assembly]::LoadWithPartialName('System.Drawing')
	$notify = New-Object System.Windows.Forms.Notifyicon
	$notify.Icon = [System.Drawing.SystemIcons]::Exclamation
	$notify.Visible = $true
	$notify.ShowBalloonTip(1,'TableFormatter','The text on the clipboard cannot be converted into the markdown table.',[system.windows.forms.tooltipicon]::None)
	exit
}
if($s.GetType().BaseType.Name -eq "Array" -and ($num) -gt 1){
	for($i = 0; $i -lt $s.Length - 1; $i ++){
		$s[$i] ="| " + $s[$i].Replace("`t", " | ") + " |"
		if($s[$i].Contains("`"")){
			$s[$i] = $s[$i].Replace("`n", " <br> ")
			$s[$i] = $s[$i].Replace("`"", "")
		}
	}

	$head = "|"

	for($i = 0; $i -lt $num; $i ++){
		$head = $head + " --- |"
	}
	$answer = @()
	$answer += $s[0]
	$answer += $head
	for($i = 1; $i -lt $s.Length; $i ++){
		$answer += $s[$i]
	}
	Set-Clipboard -Value $answer
	[Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
	[Reflection.Assembly]::LoadWithPartialName('System.Drawing')
	$notify = New-Object System.Windows.Forms.Notifyicon
	$notify.Icon = [System.Drawing.SystemIcons]::Information
	$notify.Visible = $true
	$notify.ShowBalloonTip(1,'TableFormatter','The table on the clipboard has been converted into the markdown style.',[system.windows.forms.tooltipicon]::None)
}else{
	[Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
	[Reflection.Assembly]::LoadWithPartialName('System.Drawing')
	$notify = New-Object System.Windows.Forms.Notifyicon
	$notify.Icon = [System.Drawing.SystemIcons]::Exclamation
	$notify.Visible = $true
	$notify.ShowBalloonTip(1,'TableFormatter','The text on the clipboard cannot be converted into the markdown table.',[system.windows.forms.tooltipicon]::None)
}
exit
