app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh



fun_head "setup redis repo file"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y $>>log_file
fun_stat_check
fun_head "enable redis 6.2 package"
yum module enable redis:remi-6.2 -y $>>log_file
fun_stat_check
fun_head "install redis"
yum install redis -y $>>log_file
fun_stat_check
fun_head "install redis"
sed -i -e "s|127.0.0.1|0.0.0.0|g" /etc/redis.conf /etc/redis/redis.conf $>>log_file
fun_stat_check
fun_head "start redis"
systemctl enable redis $>>log_file
systemctl restart redis $>>log_file
fun_stat_check