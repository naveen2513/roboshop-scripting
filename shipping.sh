app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh



mysql_root_password=$1
if [ -z "$mysql_root_password" ]; then
  echo password missing
  exit 1
fi

fun_head "install maven"
yum install maven -y $>>log_file
fun_head add applicant user
useradd ${app_user} $>>log_file
fun_head "make app directory"
rm -rf /app
mkdir /app $>>log_file
fun_head "download app content"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip $>>log_file
fun_stat_check
fun_head "extract app content"
cd /app
unzip /tmp/shipping.zip $>>log_file
fun_stat_check
fun_head "download dependencies"
mvn clean package $>>log_file
fun_stat_check
fun_head "build application"
mv target/shipping-1.0.jar shipping.jar $>>log_file
fun_stat_check
fun_head "setup systemd setup"
cp /home/centos/roboshop-scripting/shipping.service /etc/systemd/system/shipping.service $>>log_file
fun_stat_check
fun_head 'reload service'
systemctl daemon-reload $>>log_file
fun_stat_check
fun_head "install mysql"
yum install mysql -y $>>log_file
fun_stat_check
fun_head "load schema"
mysql -h mysql.naveendevops2.online -uroot -p${mysql_root_password} < /app/schema/shipping.sql $>>log_file
fun_stat_check
systemctl restart shipping $>>log_file
fun_stat_check



