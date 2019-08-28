function New-DudSearch {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter()]
        [string]$Text,
        [Parameter()]
        [string]$Placeholder,
        [Parameter()]
        [ScriptBlock]$onChange,
        [Parameter()]
        [ScriptBlock]$OnEnter
    )
    End {
        if ($null -ne $onChange) {
            $OnChangeEndpoint = New-UDEndpoint -Endpoint $onChange -Id ($Id + 'onChange')
        }
        if ($null -ne $OnEnter) {
            $OnEnterEndpoint = New-UDEndpoint -Endpoint $OnEnter -Id ($Id + 'onEnter')
        }
        
        if ([String]::IsNullOrWhiteSpace($Placeholder)) {
            $Placeholder = 'Search...'
        }

        @{
            assetId     = $AssetId 
            isPlugin    = $true 
            type        = "DudSearch"
            id          = $Id

            # This is where you can put any other properties. They are passed to the React control's props
            # The keys are case-sensitive in JS. 
            text        = $Text
            placeholder = $Placeholder
            onChange    = $OnChangeEndpoint.Name
            onEnter     = $OnEnterEndpoint.Name
        }

    }
}
