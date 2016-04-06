#Installing the Requried Java for Tomcat
package ['java-1.8.0-openjdk','java-1.7.0-openjdk-devel'] do
	action :install
end
#Installing TomCat
bash 'Installing the Tomcat' do
code <<-EOH
   cd /usr/share
   wget http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.9/bin/apache-tomcat-8.0.9.tar.gz
   tar -zxvf apache-tomcat-8.0.9.tar.gz
 EOH
  not_if { ::File.exists?("/usr/share/apache-tomcat-8.0.9.tar.gz") }
end
#Creating the Tomcat Group 
group 'tomcat' do
  action :create
end
#Creating the Tomcat User
user 'tomcat' do
  comment 'A tomcat user'
  gid 'tomcat' 
  home '/usr/share/apache-tomcat-8.0.9'
  shell '/bin/bash'
end
#Changing the Permission for the tomcat
execute 'permissions' do
command 'chown -Rf tomcat.tomcat /usr/share/apache-tomcat-8.0.9/'
action :run
end
#Running the Tomcat Instance1
#bash 'startingtomcat1' do
#  cwd ::File.dirname('/usr/share/')
#  code <<-EOH
#    su tomcat
#    cd /usr/share/apache-tomcat-8.0.9/bin
#    ./startup.sh
#    EOH
#end
#Adding the user  for tomcat
cookbook_file '/usr/share/apache-tomcat-8.0.9/conf/tomcat-users.xml' do
  source 'tomcat-users.xml'
  owner 'tomcat'
  group 'tomcat'
  mode '700'
  action :create
end

