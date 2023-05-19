app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh



echo -e "\e[35m>>>>>>>>>>>> setup redis repo file<<<<<<<<<<<<\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
echo -e "\e[35m>>>>>>>>>>>> enable redis 6.2 package<<<<<<<<<<<<\e[0m"
yum module enable redis:remi-6.2 -y
echo -e "\e[35m>>>>>>>>>>>> install redis<<<<<<<<<<<<\e[0m"
yum install redis -y
echo -e "\e[35m>>>>>>>>>>>> install redis<<<<<<<<<<<<\e[0m"
sed -i -e "s|127.0.0.1|0.0.0.0|g" /etc/redis.conf /etc/redis/redis.conf
echo -e "\e[35m>>>>>>>>>>>> start redis<<<<<<<<<<<<\e[0m"
systemctl enable redis
systemctl restart redis