$HomePage = New-UDPage -Name 'Test' -Icon male -Endpoint {
$Session:Items = $null
    $Cache:Style = New-UDCard -Title '.' -content { }
    New-UDHtml -Markup '<br><br><br>'
    New-UDCard -Title 'Search demo' -Id 'Debug' -Text ''
    New-DudSearch -Id 'aac' -OnEnter { Set-UDElement -id 'Debug' -content { "OnEnter event: Enter key was pressed" } } -OnChange {
       Set-UDElement -id 'Debug' -content { "OnChange event - New text: $EventData" }
        
        if ($Cache:Items -ne $null ) {
            if ($Session:Items -eq $Null) {
                $Session:Items = $Cache:Items | % {
                    [PSCustomObject]@{
                        ID      = $_.id
                        Visible = $True
                    }
                }
            }
            for ($i = 0; $i -lt $array.Count; $i++) {
                
            }
            
            $MatchItemIds = @($Cache:Items.Where{ $_.text -like "*$EventData*" } | Select -ExpandProperty Id)
            for ($i = 0; $i -lt $Session:Items.count; $i++) {
                $Item = $Session:Items[$i]
                if ($MatchItemIds.contains($Item.id)) {
                    if ($Item.Visible -eq $false) {
                        Set-UDElement -Attributes $Cache:Style.Attributes  -Id $Item.id
                        $Item.Visible = $true
                    }
                }
                else {
                    if ($Item.Visible -eq $true) {
                        Set-UDElement -Attributes @{style = @{display = 'none' } } -Id $Item.id
                        $Item.Visible = $false
                    }
                }
            }
          
         
            

          
        }
        
    }
    

    $Content = @"
[
    "I love you the more in that I believe you had liked me for my own sake and for nothing else. ",
    "But man is not made for defeat. A man can be destroyed but not defeated. ",
    "When you reach the end of your rope, tie a knot in it and hang on. ",
    "There is nothing permanent except change. ",
    "You cannot shake hands with a clenched fist. ",
    "Let us sacrifice our today so that our children can have a better tomorrow. ",
    "The most difficult thing is the decision to act, the rest is merely tenacity. The fears are paper tigers. You can do anything you decide to do. You can act to change and control your life; and the procedure, the process is its own reward. ",
    "Do not mind anything that anyone tells you about anyone else. Judge everyone and everything for yourself. ",
    "Learning never exhausts the mind. ",
    "There is no charm equal to tenderness of heart. ",
    "All that we see or seem is but a dream within a dream. ",
    "Lord, make me an instrument of thy peace. Where there is hatred, let me sow love. ",
    "If you cannot do great things, do small things in a great way. ",
    "Permanence, perseverance and persistence in spite of all obstacles, discouragements, and impossibilities: It is this, that in all things distinguishes the strong soul from the weak. ",
    "Independence is happiness. ",
    "The supreme art of war is to subdue the enemy without fighting. ",
    "Keep your face always toward the sunshine - and shadows will fall behind you. ",
    "Happiness can exist only in acceptance. ",
    "Love has no age, no limit; and no death. ",
    "You can\u0027t blame gravity for falling in love. ",
    "There is only one corner of the universe you can be certain of improving, and that\u0027s your own self. ",
    "Honesty is the first chapter in the book of wisdom. ",
    "The journey of a thousand miles begins with one step. "
]
"@ | ConvertFrom-Json

    $Items = [System.Collections.Generic.List[PSObject]]::new()
    $index = 1
    $Content | % {
        $i = [PSCustomObject]@{
            id   = New-Guid
            text = $_
        }
        $items.Add($i)
        
        New-UDCard -Title "Quote #$index" -Text $i.text -Id $i.id
        $index += 1
    }
    $Cache:Items = $Items


    
  



}

$ModulePath = "$PSScriptRoot\src\output\UniversalDashboard.DudSearch\UniversalDashboard.DudSearch.psd1" 

$Endpoint = New-UDEndpointInitialization -Module $ModulePath 
$Theme = Get-UDTheme -Name 'Azure'
$Dash = New-UDDashboard -Title 'Search demo' -Pages $HomePage -EndpointInitialization  $Endpoint -Theme $Theme
Start-UDDashboard -Dashboard $Dash -Port 8080 -Force