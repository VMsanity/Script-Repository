foreach($dc in Get-Datacenter){

        foreach($esx in Get-VMHost -Location $dc){

            Get-VM -Location $esx |
			
			% { get-view $_.id }|

            Select @{N='Datacenter';E={$dc.Name}},

                @{N='VMhost';E={$esx.Name}},
				
				Name,
				
				@{Name=“ToolsVersion”; Expression={$_.config.tools.toolsversion}},
				
				@{ Name=“ToolStatus”; Expression={$_.Guest.ToolsVersionStatus}}|
				
				export-csv toolsversion.csv -append
				
    }

}
