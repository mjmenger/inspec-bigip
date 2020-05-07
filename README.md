## BIG-IP Automation Toolchain InSpec Profile

This InSpec profile evaluates the following:
- basic connectivity to a BIG-IP management endpoint ('bigip-connectivity')
- availability of the Declarative Onboarding (DO) service ('bigip-declarative-onboarding')
- version reported by the Declarative Onboarding (DO) service ('bigip-declarative-onboarding-version')
- availability of the Application Services (AS3) service ('bigip-application-services')
- version reported by the Application Services (AS3) service ('bigip-application-services-version')
- availability of the Telemetry Streaming (TS) service ('bigip-telemetry-streaming')
- version reported by the Telemetry Streaming (TS) service ('bigip-telemetry-streaming-version')
- availability of a license on the BIG-IP ('bigip-licensed')

In order to reference the profile you can include it as a dependency in your *inspec.yml* file
```yaml
depends:
  - name: inspec-bigip
    git: https://github.com/mjmenger/inspec-bigip
    branch:  master
```
and indicate which controls to use in your control ruby file
```ruby
require_controls 'inspec-bigip' do
  control 'bigip-connectivity'
  control 'bigip-declarative-onboarding'
  control 'bigip-declarative-onboarding-version'
  control 'bigip-application-services'
  control 'bigip-application-services-version'
  control 'bigip-telemetry-streaming'
  control 'bigip-telemetry-streaming-version'
  control 'bigip-licensed'
end
```


or you can call it at the command line
```bash
inspec exec https://github.com/mjmenger/inspec-bigip.git
```
Please refer to the [Inspec documentation](https://inspec.io) for more elaborate variants on these use cases and further use cases not documented here.
