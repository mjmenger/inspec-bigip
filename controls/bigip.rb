# copyright: 2018, The Authors

title "Verify BIG-IP availability"

BIGIP_HOST     = input('bigip_address')
BIGIP_PORT     = input('bigip_port')
BIGIP_USER     = input('user')
BIGIP_PASSWORD = input('password')
DO_VERSION     = input('do_version')
AS3_VERSION    = input('as3_version')
TS_VERSION     = input('ts_version')

control "bigip-connectivity" do
  impact 1.0
  title "BIG-IP is reachable"
  describe host(BIGIP_HOST, port: BIGIP_PORT, protocol: 'tcp') do
      it { should be_reachable }
  end
end 

control "bigip-declarative-onboarding" do
  impact 1.0
  title "BIG-IP has Declarative Onboarding"
  # is the declarative onboarding end point available?
  describe http("https://#{BIGIP_HOST}:#{BIGIP_PORT}/mgmt/shared/declarative-onboarding/info",
            auth: {user: BIGIP_USER, pass: BIGIP_PASSWORD},
            params: {format: 'html'},
            method: 'GET',
            ssl_verify: false) do
        its('status') { should cmp 200 }
        its('headers.Content-Type') { should match 'application/json' }
  end
end 

control "bigip-declarative-onboarding-version" do
  impact 1.0
  title "BIG-IP has specified version of Declarative Onboarding"
  describe json(content: http("https://#{BIGIP_HOST}:#{BIGIP_PORT}/mgmt/shared/declarative-onboarding/info",
            auth: {user: BIGIP_USER, pass: BIGIP_PASSWORD},
            params: {format: 'html'},
            method: 'GET',
            ssl_verify: false).body) do
        its([0,'version']) { should eq DO_VERSION }
  end
end

control "bigip-application-services" do
  impact 1.0
  title "BIG-IP has Application Services"
  # is the declarative onboarding end point available?
  describe http("https://#{BIGIP_HOST}:#{BIGIP_PORT}/mgmt/shared/appsvcs/info",
            auth: {user: BIGIP_USER, pass: BIGIP_PASSWORD},
            params: {format: 'html'},
            method: 'GET',
            ssl_verify: false) do
        its('status') { should cmp 200 }
        its('headers.Content-Type') { should match 'application/json' }
  end
end 

control "bigip-application-services-version" do
  impact 1.0
  title "BIG-IP has specified version of Application Services"
  describe json(content: http("https://#{BIGIP_HOST}:#{BIGIP_PORT}/mgmt/shared/appsvcs/info",
            auth: {user: BIGIP_USER, pass: BIGIP_PASSWORD},
            params: {format: 'html'},
            method: 'GET',
            ssl_verify: false).body) do
        its('version') { should eq AS3_VERSION }
  end
end

control "bigip-telemetry-streaming" do
  impact 1.0
  title "BIG-IP has Application Services"
  # is the declarative onboarding end point available?
  describe http("https://#{BIGIP_HOST}:#{BIGIP_PORT}/mgmt/shared/telemetry/info",
            auth: {user: BIGIP_USER, pass: BIGIP_PASSWORD},
            params: {format: 'html'},
            method: 'GET',
            ssl_verify: false) do
        its('status') { should cmp 200 }
        its('headers.Content-Type') { should match 'application/json' }
  end
end 

control "bigip-telemetry-streaming-version" do
  impact 1.0
  title "BIG-IP has specified version of Application Services"
  describe json(content: http("https://#{BIGIP_HOST}:#{BIGIP_PORT}/mgmt/shared/telemetry/info",
            auth: {user: BIGIP_USER, pass: BIGIP_PASSWORD},
            params: {format: 'html'},
            method: 'GET',
            ssl_verify: false).body) do
        its('version') { should eq TS_VERSION }

  end
end

control "bigip-licensed" do
  impact 1.0
  title "BIG-IP has an active license"
  describe http("https://#{BIGIP_HOST}:#{BIGIP_PORT}/mgmt/tm/sys/license",
            auth: {user: BIGIP_USER, pass: BIGIP_PASSWORD },
            method: 'GET',
            ssl_verify: false) do
    its('body') { should match /registrationKey/ }
  end
end