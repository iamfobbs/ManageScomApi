#### DISCOVERY DATA ####
########################

param($sourceId,$managedEntityId)

## Authentication variables
$user = "darthmaul"
$pwd = "!deathStar" | ConvertTo-SecureString -asPlainText -Force
$limit = 1

$api = New-Object -comObject 'MOM.ScriptAPI'
$discoveryData = $api.CreateDiscoveryData(0, $sourceId, $managedEntityId)
#Log script event
#$api.LogScriptEvent('Scripts/ManageAppServiceStatus.ps1',999,4,$service)

$defUrl = "https://demo1.ravn.co.uk/ravn-manage/api/v2/service_states?limit=$limit&offset=$offset"
$cred = New-Object System.Management.Automation.PSCredential($user,$pwd)
$stackStatus = Invoke-RestMethod -Uri $defUrl -Credential $cred

if ($stackStatus.Count -ge 1) 
{
    #appends only the service url for an individual service
    $parsedUrls = $stackStatus.serviceUrl
    #secure requests required else the call fails
    $UrlsParsed = $parsedUrls.Replace("http","https")
    #$UrlsParsed 

    #for each service found perform an addition call to determine the status of the service. 
    foreach ($Url in $UrlsParsed)
    {
        $instance = $discoveryData.CreateClassInstance("$MPElement[Name='StackAppServiceStatus.Discovery.ProbeService']$")




        $sep = Invoke-WebRequest -uri $url -Credential $cred
        #collects first different data sets
        $svcStatus = $sep | select @{name="Response";Expression ={$_.statuscode}}, @{name="Status";Expression ={$_.statusdescription}} 
        #collects seconds different data sets
        $svcCall = $sep | ConvertFrom-Json | select displayname, serviceTypeUrl, port, serviceport
        #appends both data set together
        $svcStatus | Add-Member -MemberType NoteProperty -Name displayname -Value $svcCall.displayname
        $svcStatus | Add-Member -MemberType NoteProperty -Name serviceTypeUrl -Value $svcCall.serviceTypeUrl
        $svcStatus | Add-Member -MemberType NoteProperty -Name port -Value $svcCall.port
        $svcStatus | Add-Member -MemberType NoteProperty -Name servicePort -Value $svcCall.servicePort
        #formats results
        $svcStatus | ft
        $offset++


		
        $instance.AddProperty("$MPElement[StackAppServiceStatus.DiscoveryService]")
            
    }

        if($offset -ge $limit)
        {
            GetServiceStates($offset)
        }
   
} 














########## MULTIPLE SERVICES #############
#$user = "deathMaul"
#$pwd = "*******" | ConvertTo-SecureString -asPlainText -Force
#$defUrl = "https://demo1.ravn.co.uk/ravn-manage/api/v2/service_states?limit=1000"
#$cred = New-Object System.Management.Automation.PSCredential($user,$pwd)
##$stackStatus = Invoke-WebRequest -Uri $url -Credential $cred
#$stackStatus = Invoke-RestMethod -Uri $defUrl -Credential $cred

##appends only the service url for an individual service
#$parsedUrls = $stackStatus.serviceUrl
##secure requests required else the call fails
#$UrlsParsed = $parsedUrls.Replace("http","https")
##$UrlsParsed 

##for each service found perform an addition call to determine the status of the service. 
#foreach ($Url in $UrlsParsed)
#{
#    $sep = Invoke-WebRequest -uri $url -Credential $cred
#    $svcStatus = $sep | select @{name="Response";Expression ={$_.statuscode}}, @{name="Status";Expression ={$_.statusdescription}} 
#    $svcCall = $sep | ConvertFrom-Json | select displayname, serviceTypeUrl, port, serviceport

#    $svcStatus | Add-Member -MemberType NoteProperty -Name displayname -Value $svcCall.displayname
#    $svcStatus | Add-Member -MemberType NoteProperty -Name serviceTypeUrl -Value $svcCall.serviceTypeUrl
#    $svcStatus | Add-Member -MemberType NoteProperty -Name port -Value $svcCall.port
#    $svcStatus | Add-Member -MemberType NoteProperty -Name servicePort -Value $svcCall.servicePort
    
#    $svcStatus | ft
#}



