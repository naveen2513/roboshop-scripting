app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh



mysql_root_password=$1
if [ -z "$mysql_root_password" ]; then
  echo password missing
  exit 1
fi


echo -e "\e[35m>>>>>>>>>>>> disable mysql<<<<<<<<<<<<\e[0m"
yum module disable mysql -y
echo -e "\e[35m>>>>>>>>>>>> setup mysql repo file<<<<<<<<<<<<\e[0m"
cp /home/centos/roboshop-scripting/mysql.repo /etc/yum.repos.d/mysql.repo
echo -e "\e[35m>>>>>>>>>>>> install mysql<<<<<<<<<<<<\e[0m"
yum install mysql-community-server -y
echo -e "\e[35m>>>>>>>>>>>> strat mysql<<<<<<<<<<<<\e[0m"
systemctl enable mysqld
systemctl restart mysqld

mysql_secure_installation --set-root-pass ${mysql_root_password}
