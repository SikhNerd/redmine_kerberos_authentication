require 'redmine'

Redmine::Plugin.register :redmine_kerberos_authentication do
  name 'Redmine Kerberos Authentication plugin'
  author 'Stephan Eckardt'
  description 'Adds Kerberos Authentication to available Auth Sources'
  version '0.0.1'
  url 'http://github.com/se/redmine_kerberos_authentication'
  author_url 'http://github.com/se'
end
