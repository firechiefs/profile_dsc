# Configues DSC to work with Puppet

# HIERA DATA:
# profile::dsc:lcm_config:
#
# Using PuppetLabs recommendation:
# https://forge.puppetlabs.com/puppetlabs/dsc#optionally-configure-the-dsc-lcm-refreshmode

# HIERA EXAMPLE:
# profile::dsc:lcm_config: 'Disabled'

class profile_dsc {
  # DSC required chocolatey WMF 5 packages
  require profile_packages
  # HIERA LOOKUP:
  # --> PUPPET CODE VARIABLES:
  $lcm_config_refresh_mode = hiera('profile::dsc::lcm_config_refresh_mode')
  validate_string($lcm_config_refresh_mode)

  # Upgrade to PowerShell 5 RTM from Production Preview breaks DSC commandlets
  # https://msdn.microsoft.com/en-us/powershell/wmf/limitation_dsc
  exec { 'powershell 5 RTM fix':
    provider => powershell,
    command  => 'mofcomp $env:windir\\system32\\wbem\\DscCoreConfProv.mof',
    unless   => 'try { $output = Get-DscLocalConfigurationManager -ErrorAction Stop; exit 0 } catch { exit 1}',
  }

  # Set Windows DSC LCM refresh_mode
  dsc::lcm_config {'disable_lcm':
    refresh_mode => $lcm_config_refresh_mode,
  }

  # VALIDATION CODE:
  # --> MODIFY VARIABLES BELOW:
  $profile_name    = 'profile_dsc'                    # set to profile name
  $validation_data = $lcm_config_refresh_mode # validate DSC refresh_mode

  # Puppet custom define type
  # documented in: site/validation_script/manifests/init.pp
  # DO NOT MODIFY BELOW !!!
  validation_script { $profile_name:
    profile_name    => $profile_name,
    validation_data => $validation_data,
  }

}
