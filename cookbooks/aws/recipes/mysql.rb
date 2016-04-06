#Installing Mysql DataBases
bash 'Installing the Mysql Repo' do
code <<-EOH
   mkdir /mysqlrepo
   cd /mysqlrepo
   wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
   rpm -ivh mysql-community-release-el7-5.noarch.rpm
 EOH
  not_if { ::File.exists?('/etc/yum.repos.d/mysql-community.repo') }
end
#Installing Mysql Database
package "mysql-server" do
	action :install
end
#Starting the Mysql Service
service "mysqld" do
action [:enable, :start]
end
#TO Set the mysql root password
bash 'MysqlPasswordSetup' do
code <<-EOH
mysql -u root  -Bse "show grants;UPDATE mysql.user SET Password=PASSWORD('password') WHERE User='root';FLUSH PRIVILEGES;"
EOH
end
