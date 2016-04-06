#Creating Mutiple tomcat Instances
bash 'Installing the Tomcat2' do
cwd ::File.dirname('/usr/share/')
code <<-EOH
   cd /usr/share
   mkdir apache-tomcat2
   tar -zxvf apache-tomcat-8.0.9.tar.gz -C apache-tomcat2
 EOH
  not_if { ::File.exists?("/usr/share/apache-tomcat2") }
end
#Changing the Permission for the tomcat
execute 'permissions' do
command 'chown -Rf tomcat.tomcat /usr/share/apache-tomcat2/'
action :run
end
cookbook_file '/usr/share/apache-tomcat2/apache-tomcat-8.0.9/conf/tomcat-users.xml' do
  source 'tomcat-users.xml'
  owner 'tomcat'
  group 'tomcat'
  mode '700'
  action :create
end
cookbook_file '/usr/share/apache-tomcat2/apache-tomcat-8.0.9/conf/server.xml' do
  source 'server.xml'
  owner 'tomcat'
  group 'tomcat'
  mode '700'
  action :create
end
