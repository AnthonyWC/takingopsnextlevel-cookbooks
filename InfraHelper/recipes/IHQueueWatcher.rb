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

cookbook_file "#{node['InfraHelper']['base_dir']/bin/IHQueueWatcher.php}" do
  source "IHQueueWatcher.php"
  mode 0755
  owner "root"
  group "root"
  action :create
  notifies :restart, "service[crond]"
end

cron "IHQeueWatcher" do
  command "/usr/bin/php #{node['InfraHelper']['base_dir']}/bin/IHQueueWatcher.php >>/tmp/IHstuff.log 2>&1"
  only_if do File.exist?("#{node['InfraHelper']['base_dir']}/bin/IHQueueWatcher.php") end
end

cron "IHQeueWatcher-30" do
  command "sleep 30; /usr/bin/php #{node['InfraHelper']['base_dir']}/bin/IHQueueWatcher.php >>/tmp/IHstuff.log 2>&1"
  only_if do File.exist?("#{node['InfraHelper']['base_dir']}/bin/IHQueueWatcher.php") end
end
