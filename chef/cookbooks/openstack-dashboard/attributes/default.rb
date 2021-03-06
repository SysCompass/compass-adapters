#
# Cookbook Name:: openstack-dashboard
# Attributes:: default
#
# Copyright 2012, AT&T, Inc.
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

# Set to some text value if you want templated config files
# to contain a custom banner at the top of the written file
default["openstack"]["dashboard"]["custom_template_banner"] = "
# This file autogenerated by Chef
# Do not edit, changes will be overwritten
"

default["openstack"]["dashboard"]["debug"] = false

# This user's password is stored in an encrypted databag
# and accessed with openstack-common cookbook library's
# db_password routine.
default["openstack"]["dashboard"]["db"]["username"] = "dash"

# The Keystone role used by default for users logging into the dashboard
default["openstack"]["dashboard"]["keystone_default_role"] = "Member"

# This is the name of the Chef role that will install the Keystone Service API
default["openstack"]["dashboard"]["keystone_service_chef_role"] = "keystone"

default["openstack"]["dashboard"]["server_hostname"] = nil
default["openstack"]["dashboard"]["use_ssl"] = true
default["openstack"]["dashboard"]["ssl"]["cert"] = "horizon.pem"
default["openstack"]["dashboard"]["ssl"]["key"] = "horizon.key"

default["openstack"]["dashboard"]["swift"]["enabled"] = "False"

default["openstack"]["dashboard"]["theme"] = "default"

default["openstack"]["dashboard"]["apache"]["sites-path"] = "#{node["apache"]["dir"]}/openstack-dashboard"

case node["platform"]
when "fedora", "centos", "redhat"
  default["openstack"]["dashboard"]["ssl"]["dir"] = "/etc/pki/tls"
  default["openstack"]["dashboard"]["local_settings_path"] = "/etc/openstack-dashboard/local_settings"
  default["openstack"]["dashboard"]["static_path"] = "/usr/share/openstack-dashboard/static"
  # TODO(shep) - Fedora does not generate self signed certs by default
  default["openstack"]["dashboard"]["platform"] = {
    "mysql_python_packages" => ["MySQL-python"],
    "postgresql_python_packages" => ["python-psycopg2"],
    "horizon_packages" => ["openstack-dashboard"],
    "memcache_python_packages" => ["python-memcached"],
    "package_overrides" => ""
  }
  if node["platform"] == "fedora"
    default["openstack"]["dashboard"]["apache"]["sites-path"] = "#{node["apache"]["dir"]}/conf.d/openstack-dashboard.conf"
  else
    default["openstack"]["dashboard"]["apache"]["sites-path"] = "#{node["apache"]["dir"]}/conf.d/openstack-dashboard"
  end
when "suse"
  default["openstack"]["dashboard"]["ssl"]["dir"] = "/etc/ssl"
  default["openstack"]["dashboard"]["local_settings_path"] = "/usr/share/openstack-dashboard/openstack_dashboard/local/local_settings.py"
  default["openstack"]["dashboard"]["static_path"] = "/usr/share/openstack-dashboard/static"
  default["openstack"]["dashboard"]["platform"] = {
    "mysql_python_packages" => ["python-mysql"],
    "postgresql_python_packages" => ["python-psycopg2"],
    "horizon_packages" => ["openstack-dashboard"],
    "memcache_python_packages" => ["python-python-memcached"],
    "package_overrides" => ""
  }
  default["openstack"]["dashboard"]["apache"]["sites-path"] = "#{node["apache"]["dir"]}/conf.d/openstack-dashboard.conf"
when "ubuntu"
  default["openstack"]["dashboard"]["ssl"]["dir"] = "/etc/ssl"
  default["openstack"]["dashboard"]["local_settings_path"] = "/etc/openstack-dashboard/local_settings.py"
  default["openstack"]["dashboard"]["static_path"] = "/usr/share/openstack-dashboard/openstack_dashboard/static"
  default["openstack"]["dashboard"]["platform"] = {
    "horizon_packages" => ["lessc", "openstack-dashboard"],
    "mysql_python_packages" => ["python-mysqldb"],
    "postgresql_python_packages" => ["python-psycopg2"],
    "memcache_python_packages" => ["python-memcache"],
    "package_overrides" => "-o Dpkg::Options::='--force-confold' -o Dpkg::Options::='--force-confdef'"
  }
  default["openstack"]["dashboard"]["apache"]["sites-path"] = "#{node["apache"]["dir"]}/sites-available/openstack-dashboard"
end

default["openstack"]["dashboard"]["dash_path"] = "/usr/share/openstack-dashboard/openstack_dashboard"
default["openstack"]["dashboard"]["stylesheet_path"] = "/usr/share/openstack-dashboard/openstack_dashboard/templates/_stylesheets.html"
default["openstack"]["dashboard"]["wsgi_path"] = node["openstack"]["dashboard"]["dash_path"] + "/wsgi/django.wsgi"
default["openstack"]["dashboard"]["session_backend"] = "memcached"

default["openstack"]["dashboard"]["ssl_offload"] = false
default["openstack"]["dashboard"]["plugins"] = nil

default["openstack"]["dashboard"]["error_log"] = "openstack-dashboard-error.log"
default["openstack"]["dashboard"]["access_log"] = "openstack-dashboard-access.log"
