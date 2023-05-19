app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh


fun_head install nginx
yum install nginx -y &>>logfile
fun_stat_check
fun_head start nginx
systemctl enable nginx
systemctl start nginx &>>logfile
fun_stat_check
fun_head remove default content
rm -rf /usr/share/nginx/html/* &>>logfile
fun_stat_check
fun_head download app content

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>logfile
fun_stat_check
fun_head extract content
cd /usr/share/nginx/html &>>logfile
unzip /tmp/frontend.zip &>>logfile
fun_stat_check
fun_head setup configuration
cp /home/centos/roboshop-scripting/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>logfile
fun_stat_check
fun_head start nginx &>>logfile
systemctl restart nginx &>>logfile
fun_stat_check
