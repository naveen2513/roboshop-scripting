app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh



rabbitmq_password=$1
if [ -z "$rabbitmq_password"  ]; then
  echo password missing
  exit 1

fi

fun_head setup erlang repo

curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash $>>log_file
fun_stat_check
fun_head setup rabbitmqrepo

curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash $>>log_file
fun_stat_check
fun_head install rabbitmq

yum install rabbitmq-server -y $>>log_file
fun_stat_check
fun_head restart rabbitmq

systemctl enable rabbitmq-server $>>log_file
fun_stat_check
systemctl restart rabbitmq-server $>>log_file
fun_stat_check
fun_head add user

rabbitmqctl add_user roboshop ${rabbitmq_password} $>>log_file
fun_stat_check
fun_head set password

rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" $>>log_file
fun_stat_check