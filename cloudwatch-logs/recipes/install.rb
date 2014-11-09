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

directory "/opt/aws/cloudwatch" do
 recursive true
end

remote_file "/opt/aws/cloudwatch/awslogs-agent-setup.py" do
source "https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py"
mode "0755"
end

execute "Install CloudWatch Logs agent" do
command "/opt/aws/cloudwatch/awslogs-agent-setup.py -n -r "+(node[:opsworks][:instance][:region])+" -c /etc/cwlogs.cfg"
not_if { system "pgrep -f aws-logs-agent-setup" }
end
