#
# Cookbook Name:: InfraHelper
# Recipe:: InfraHelperPHP
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

service "crond" do
  supports :restart => true
end

directory "/tmp/secure-dir" do
  action :create
  mode 0700
  owner "root"
  group "root"
end

%w{ HistoryEventIterator.php IHActWorker_EIP.php IHActWorker_SrcDestCheck.php IHActWorker_VPCRouteMapper.php IHDeciderStart.php IHSWFDecider.php }.each do |ifile|
  cookbook_file node['InfraHelper']['base_dir']/bin/#{ifile}" do
   source #{ifile}
   mode 0755
   owner "root"
   group "root"
   action :create
   notifies :restart, "service[crond]"
  end
end

cron "IHDeciderStart" do
  command "sleep 5; /usr/bin/php #{node['InfraHelper']['base_dir']}/bin/IHDeciderStart.php >>/tmp/IHstuff.log 2>&1"
  only_if do File.exist?("#{node['InfraHelper']['base_dir']}/bin/IHDeciderStart.php") end
end

cron "IHDeciderStart-10" do
  command "sleep 15; /usr/bin/php #{node['InfraHelper']['base_dir']}/bin/IHDeciderStart.php >>/tmp/IHstuff.log 2>&1"
  only_if do File.exist?("#{node['InfraHelper']['base_dir']}/bin/IHDeciderStart.php") end
end

cron "IHDeciderStart-25" do
  command "sleep 25; /usr/bin/php #{node['InfraHelper']['base_dir']}/bin/IHDeciderStart.php >>/tmp/IHstuff.log 2>&1"
  only_if do File.exist?("#{node['InfraHelper']['base_dir']}/bin/IHDeciderStart.php") end
end

cron "IHDeciderStarti-30" do
  command "sleep 35; /usr/bin/php #{node['InfraHelper']['base_dir']}/bin/IHDeciderStart.php >>/tmp/IHstuff.log 2>&1"
  only_if do File.exist?("#{node['InfraHelper']['base_dir']}/bin/IHDeciderStart.php") end
end

cron "IHDeciderStarti-40" do
  command "sleep 45; /usr/bin/php #{node['InfraHelper']['base_dir']}/bin/IHDeciderStart.php >>/tmp/IHstuff.log 2>&1"
  only_if do File.exist?("#{node['InfraHelper']['base_dir']}/bin/IHDeciderStart.php") end
end

cron "IHDeciderStarti-50" do
  command "sleep 55; /usr/bin/php #{node['InfraHelper']['base_dir']}/bin/IHDeciderStart.php >>/tmp/IHstuff.log 2>&1"
  only_if do File.exist?("#{node['InfraHelper']['base_dir']}/bin/IHDeciderStart.php") end
end

cron "IHActWorker_EIP" do
  command "sleep 10; /usr/bin/php #{node['InfraHelper']['base_dir']}/bin/IHActWorker_EIP.php >>/tmp/IHstuff.log 2>&1"
  only_if do File.exist?("#{node['InfraHelper']['base_dir']}/bin/IHActWorker_EIP.php") end
end

cron "IHActWorker_EIP-30" do
  command "sleep 40; /usr/bin/php #{node['InfraHelper']['base_dir']}/bin/IHActWorker_EIP.php >>/tmp/IHstuff.log 2>&1"
  only_if do File.exist?("#{node['InfraHelper']['base_dir']}/bin/IHActWorker_EIP.php") end
end

cron "IHActWorker_SrcDestCheck" do
  command "sleep 15; /usr/bin/php #{node['InfraHelper']['base_dir']}/bin/IHActWorker_SrcDestCheck.php >>/tmp/IHstuff.log 2>&1"
  only_if do File.exist?("#{node['InfraHelper']['base_dir']}/bin/IHActWorker_SrcDestCheck.php") end
end

cron "IHActWorker_SrcDestCheck-30" do
  command "sleep 45; /usr/bin/php #{node['InfraHelper']['base_dir']}/bin/IHActWorker_SrcDestCheck.php >>/tmp/IHstuff.log 2>&1"
  only_if do File.exist?("#{node['InfraHelper']['base_dir']}/bin/IHActWorker_SrcDestCheck.php") end
end

cron "IHActWorker_VPCRouteMapper" do
  command "sleep 20; /usr/bin/php #{node['InfraHelper']['base_dir']}/bin/IHActWorker_VPCRouteMapper.php >>/tmp/IHstuff.log 2>&1"
  only_if do File.exist?("#{node['InfraHelper']['base_dir']}/bin/IHActWorker_VPCRouteMapper.php") end
end

cron "IHActWorker_VPCRouteMapper-30" do
  command "sleep 50; /usr/bin/php #{node['InfraHelper']['base_dir']}/bin/IHActWorker_VPCRouteMapper.php >>/tmp/IHstuff.log 2>&1"
  only_if do File.exist?("#{node['InfraHelper']['base_dir']}/bin/IHActWorker_VPCRouteMapper.php") end
end

