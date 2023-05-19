app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

fun_head  "mongo repo file"
cp /home/centos/roboshop-scripting/mongo.repo /etc/yum.repos.d/mongo.repo $>>log_file
fun_stat_check $?
fun_head "install mongo"
yum install mongodb-org -y $>>log_file
fun_stat_check $?
fun_head "start mogodb"
systemctl enable mongod $>>log_file
fun_stat_check $?
fun_head "copy mongodb"
sed -i -e "s|127.0.0.1|0.0.0.0|g" /etc/mongod.conf $>>log_file
fun_stat_check $?
fun_head "restart mogodb"
systemctl restart mongod $>>log_file
fun_stat_check $?

