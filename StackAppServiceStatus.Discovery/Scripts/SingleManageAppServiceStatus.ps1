########### SINGLE SERVICE #################
# To connect without authentication tunnel via putty to:
#	0. ravn-manage3:8080
#	1. add [0] to via putty and connect.
#	2. Uncomment below and comment out script with credentials.

########### SINGLE SERVICE ########
$url = "http://localhost:9090/ravn-manage/api/v2/services/d3ebf2ac-eec0-401a-872b-bde516b5d3bf"
$sep = Invoke-WebRequest -Uri $url 

$svcStatus = $sep | select @{name="Response";Expression ={$_.statuscode}}, @{name="Status";Expression ={$_.statusdescription}} 
$svcCall = $sep | ConvertFrom-Json | select displayname, serviceTypeUrl, port, serviceport

$svcStatus | Add-Member -MemberType NoteProperty -Name displayname -Value $svcCall.displayname
$svcStatus | Add-Member -MemberType NoteProperty -Name serviceTypeUrl -Value $svcCall.serviceTypeUrl
$svcStatus | Add-Member -MemberType NoteProperty -Name port -Value $svcCall.port
$svcStatus | Add-Member -MemberType NoteProperty -Name servicePort -Value $svcCall.servicePort

$svcStatus | ft

## Authentication Required!
#$user = "darthMaul"
#$pwd = "********" | ConvertTo-SecureString -asPlainText -Force
#$url = "https://demo1.ravn.co.uk/ravn-manage/api/v2/services/d3ebf2ac-eec0-401a-872b-bde516b5d3bf"
#$cred = New-Object System.Management.Automation.PSCredential($user,$pwd)
#$sep = Invoke-WebRequest -Uri $url -Credential $cred

#$svcStatus = $sep | select @{name="Response";Expression ={$_.statuscode}}, @{name="Status";Expression ={$_.statusdescription}} 
#$svcCall = $sep | ConvertFrom-Json | select displayname, serviceTypeUrl, port, serviceport

#$svcStatus | Add-Member -MemberType NoteProperty -Name displayname -Value $svcCall.displayname
#$svcStatus | Add-Member -MemberType NoteProperty -Name serviceTypeUrl -Value $svcCall.serviceTypeUrl
#$svcStatus | Add-Member -MemberType NoteProperty -Name port -Value $svcCall.port
#$svcStatus | Add-Member -MemberType NoteProperty -Name servicePort -Value $svcCall.servicePort

#$svcStatus | ft