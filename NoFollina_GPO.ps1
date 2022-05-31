$dom = Get-ADDomain
$gpo = Get-GPO -name CNF_NoFollina -ErrorAction SilentlyContinue
if ($null -eq $gpo) { $gpo = New-GPO -Name CNF_NoFollina }
[xml]$x = Get-GPOReport -Name CNF_NoFollina -ReportType xml
if ($null -eq (Get-GPPrefRegistryValue -Name $gpo.DisplayName -Context Computer -Key "HKCR\ms-msdt" -ErrorAction SilentlyContinue)) {
    $pref = Set-GPPrefRegistryValue -Name $gpo.DisplayName -Context Computer -Action Delete -Key "HKCR\ms-msdt"
}
if ($null -eq $x.GPO.LinksTo) {
    $gplnk = New-GPLink -Name $gpo.DisplayName -Target $dom.DistinguishedName
}
