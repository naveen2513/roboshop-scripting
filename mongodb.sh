echo -e "\e[35m>>>>>>>>>>>> setup mongo repo file<<<<<<<<<<<<\e[0m"
cp /home/centos/roboshop-scripting/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[35m>>>>>>>>>>>> install mongo<<<<<<<<<<<<\e[0m"
yum install mongodb-org -y
echo -e  "\e[35m>>>>>>>>>>>> start mogodb<<<<<<<<<<<<\e[0m"
systemctl enable mongod
systemctl start mongod
echo -e "\e[35m>>>>>>>>>>>> restart mogodb<<<<<<<<<<<<\e[0m"
sed -i -e "s|127.0.0.1|0.0.0.0|g" /etc/mongod.conf
echo -e "\e[35m>>>>>>>>>>>> restart mogodb<<<<<<<<<<<<\e[0m"
systemctl restart mongod

