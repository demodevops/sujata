#Creating two script to run tomcat as a service
cookbook_file '/etc/init.d/tomcat1' do
source 'tomcat1' 
mode '700'
 action :create
end
cookbook_file '/etc/init.d/tomcat2' do
  source 'tomcat2'
mode '700'  
action :create
end

