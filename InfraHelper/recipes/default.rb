#
# Copyright 2014 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License").
# You may not use this file except in compliance with the License.
# A copy of the License is located at
#
# http://aws.amazon.com/apache2.0
#
# or in the "license" file accompanying this file. This file is distributed
# on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
# express or implied. See the License for the specific language governing
# permissions and limitations under the License.
#

include_recipe 'deploy'

node[:deploy].each do |application, deploy|

  if deploy[:application_type] != 'aws-flow-ruby'
    Chef::Log.debug("Skipping application #{application} as it is not an aws-flow-ruby app")
    next
  end

  directory "#{deploy[:current_path]}" do
    action :create
    mode 0755
    owner "root"
    group "root"
    recursive true
  end

  directory "/var/log/infrahelper" do
    action :create
    mode 0755
    owner "root"
    group "root"
    recursive true
  end

  file "/var/log/infrahelper/app.log" do
    action :create_if_missing
    mode 0777
    owner "deploy"
    group "apache"
  end

  gem_package "aws-sdk" do
    action :install
  end

  gem_package "aws-flow" do
    action :install
  end

  gem_package "daemons" do
    action :install
  end

  gem_package "json" do
    action :install
  end


  template "IHQueueConfig.yml" do
    path "#{deploy[:current_path]}/IHQueueConfig.yml"
    source "IHQueueConfig.yml.erb"
    owner "root"
    group "root"
    mode 0644
    variables(
     :myQueue         => (deploy[:environment][:IHqueue] rescue nil),
     :myRegion        => (node[:opsworks][:instance][:region] rescue nil)
    )
    backup false
  end

  template "infrahelper.json" do
    path "#{deploy[:current_path]}/infrahelper.json"
    source "infrahelper.json.erb"
    owner "root"
    group "root"
    mode 0644
    variables(
     :myDomain         => (deploy[:environment][:myDomain] rescue nil)
    )
    backup false
  end

  bash "start queuewatcher" do
    user "root"
    cwd "#{deploy[:current_path]}"
    code <<-EOH
      command "/usr/bin/ruby #{deploy[:current_path]}/IHQueueWatcher_control.rb restart"
    EOH
  end

end
