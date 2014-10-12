#
# Cookbook Name:: InfraHelper
# Recipe:: SWFInfraHelperSetup
#
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

directory node['InfraHelper']['base_dir'] do
  action :create
  mode 0755
  owner "root"
  group "root"
  recursive true
end

template "config.inc.php" do
  path "#{node['InfraHelper']['base_dir']}/config.inc.php"
  source "config.inc.php.erb"
  owner "root"
  group "root"
  mode 0644
  backup false
end

directory "#{node['InfraHelper']['base_dir']}/bin" do
  action :create
  mode 0755
  owner "root"
  group "root"
end

%w{ IHCommon.php IHSWFsetup.php }.each do |ifile|
  cookbook_file node['InfraHelper']['base_dir']/bin/#{ifile}" do
   source #{ifile}
   mode 0755
   owner "root"
   group "root"
   action :create
   notifies :restart, "service[crond]"
  end
end

template "IHResources.php" do
  path "#{node['InfraHelper']['base_dir']}/bin/IHResources.php"
  source "IHResources.php.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
   :IH_queue          => node['InfraHelper']['IH_queue'],
   :IHswf_domain      => node['InfraHelper']['IHswf_domain'],
   :SWF_Region        => (opsworks[:instance][:region] rescue nil),
   :EC2_Region        => (opsworks[:instance][:region] rescue nil)
  )
  backup false
end

execute "IHSWFsetup.php" do
  cwd "#{node['InfraHelper']['base_dir']}/bin/"
  command "/usr/bin/php #{node['InfraHelper']['base_dir']}/bin/IHSWFsetup.php"
end

