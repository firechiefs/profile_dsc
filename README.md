## PURPOSE:

Configues DSC to work with Puppet

## HIERA DATA:

 profile::dsc:lcm_config:

 Using PuppetLabs recommendation:

 https://forge.puppetlabs.com/puppetlabs/dsc#optionally-configure-the-dsc-lcm-refreshmode

## HIERA EXAMPLE:
```
profile::dsc:lcm_config: 'Disabled'

```

## MODULE DEPENDENCIES:
```
puppet module install puppetlabs-dsc
```
## USAGE:

#### Puppetfile:
```
mod 'puppetlabs-dsc',
  :git => 'https://github.com/puppetlabs/puppetlabs-dsc',
  :tag => '1.0.0'

mod 'validation_script',
  :git => 'https://github.com/firechiefs/validation_script',
  :ref => '1.0.0'

mod 'profile_dsc',
  :git => 'https://github.com/firechiefs/profile_dsc',
  :ref => '1.0.0'
```
#### Manifests:
```
class role::*rolename* {
  include profile_dsc
}
```
