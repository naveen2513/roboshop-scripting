app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

component=catalogue
fun_nodjs

echo -e "\e[35m>>>>>>>>>>>> setup mongodb repo file <<<<<<<<<<<<\e[0m"
cp /home/centos/roboshop-scripting/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[35m>>>>>>>>>>>> install mongodb<<<<<<<<<<<<\e[0m"

yum install mongodb-org-shell -y
echo -e "\e[35m>>>>>>>>>>>> load schema<<<<<<<<<<<<\e[0m"
mongo --host mongodb.naveendevops2.online </app/schema/catalogue.js



