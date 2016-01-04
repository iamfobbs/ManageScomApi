######### MULTIPLE SERVICES #############
$user = "deathMaul"
$pwd = "*******" | ConvertTo-SecureString -asPlainText -Force
$defUrl = "https://demo1.ravn.co.uk/ravn-manage/api/v2/service_states?limit=1000"
$cred = New-Object System.Management.Automation.PSCredential($user,$pwd)
#$stackStatus = Invoke-WebRequest -Uri $url -Credential $cred
$stackStatus = Invoke-RestMethod -Uri $defUrl -Credential $cred

#appends only the service url for an individual service
$parsedUrls = $stackStatus.serviceUrl
#secure requests required else the call fails
$UrlsParsed = $parsedUrls.Replace("http","https")
#$UrlsParsed 

#for each service found perform an addition call to determine the status of the service. 
foreach ($Url in $UrlsParsed)
{
    $sep = Invoke-WebRequest -uri $url -Credential $cred
    $svcStatus = $sep | select @{name="Response";Expression ={$_.statuscode}}, @{name="Status";Expression ={$_.statusdescription}} 
    $svcCall = $sep | ConvertFrom-Json | select displayname, serviceTypeUrl, port, serviceport

    $svcStatus | Add-Member -MemberType NoteProperty -Name displayname -Value $svcCall.displayname
    $svcStatus | Add-Member -MemberType NoteProperty -Name serviceTypeUrl -Value $svcCall.serviceTypeUrl
    $svcStatus | Add-Member -MemberType NoteProperty -Name port -Value $svcCall.port
    $svcStatus | Add-Member -MemberType NoteProperty -Name servicePort -Value $svcCall.servicePort
    
    $svcStatus | ft
}