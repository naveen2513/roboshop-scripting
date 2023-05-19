app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh



rabbitmq_password=$1
if [ -z "$rabbitmq_password"  ]; then
  echo password missing
  exit 1
fi
fun_head install python36

yum install python36 gcc python3-devel -y $>>log_file
fun_head install python36

fun_app_prereq
fun_head download dependencies

pip3.6 install -r requirements.txt $>>log_file
fun_head setup systemd file

cp /home/centos/roboshop-scripting/payment.service /etc/systemd/system/payment.service $>>log_file
fun_head setup password

sed -i -e "s|rabbitmq_password|${rabbitmq_password}|g" /home/centos/roboshop-scripting/payment.service $>>log_file
fun_head restart payment

systemctl daemon-reload $>>log_file
systemctl enable payment $>>log_file
systemctl restart payment $>>log_file