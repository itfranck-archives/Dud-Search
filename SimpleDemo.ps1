$HomePage = New-UDPage -Name 'Test' -Icon male -Endpoint {
    New-UDHtml -Markup '<br><br><br>'
    New-UDCard -Title 'Search demo' -Id 'Debug' -Text ''
    New-DudSearch -Id 'aac' -OnEnter { Set-UDElement -id 'Debug' -content { "OnEnter event: Enter key was pressed" } } -OnChange {
       Set-UDElement -id 'Debug' -content { "OnChange event - New text: $EventData" }
    }

}

$ModulePath = "$PSScriptRoot\src\output\UniversalDashboard.DudSearch\UniversalDashboard.DudSearch.psd1" 

$Endpoint = New-UDEndpointInitialization -Module $ModulePath 
$Theme = Get-UDTheme -Name 'Azure'
$Dash = New-UDDashboard -Title 'Search demo' -Pages $HomePage -EndpointInitialization  $Endpoint -Theme $Theme
Start-UDDashboard -Dashboard $Dash -Port 8080 -Force