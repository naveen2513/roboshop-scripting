app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh



mysql_root_password=$1
if [ -z "$mysql_root_password" ]; then
  echo password missing
  exit 1
fi


fun_head "disable mysql"
yum module disable mysql -y $>>log_file
fun_head "setup mysql repo file"
cp /home/centos/roboshop-scripting/mysql.repo /etc/yum.repos.d/mysql.repo $>>log_file
fun_head "install mysql"
yum install mysql-community-server -y $>>log_file
fun_head "strat mysql"
systemctl enable mysqld $>>log_file
systemctl restart mysqld $>>log_file
fun_head "steup password"
mysql_secure_installation --set-root-pass ${mysql_root_password} $>>log_file
