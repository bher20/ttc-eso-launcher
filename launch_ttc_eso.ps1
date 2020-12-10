#
# Summary: Automatically launches the TTC client then Elder Scrolls Online. Once ESO is stopped, the TTC client is automatically stopped.
#
# Authors: Bradley Herring <brad@bherville.com>
#



#
# Parameters
#

param (
  [Parameter(Mandatory = $false, HelpMessage = "Path to this application's configuration file.")]
  [string] $ConfigPath = 'launch_ttc_eso.conf'
)



#
# Constants
#

Set-Variable CONFIG -option Constant -value (Get-Content $ConfigPath | ConvertFrom-Json)



#
# Start and monitor applications
#

# Start the TTC Client and wait for it to start
Start-Process $CONFIG.ttc.bin_path -WindowStyle Minimized
$ttc_process = Get-Process -Name $CONFIG.ttc.process_name
Start-Sleep 2

# Start the ESO Client
Start-Process $CONFIG.eso.bin_path -NoNewWindow -Wait

# Wait for ESO client to exit fully
Start-Sleep 2

# Stop the TTC Client
Stop-Process -InputObject $ttc_process
