echo -e "\e[35m>>>>>>>>>>>> setup nodejs repo<<<<<<<<<<<<\e[0m"

curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[35m>>>>>>>>>>>> install nodejs<<<<<<<<<<<<\e[0m"
yum install nodejs -y
echo -e "\e[35m>>>>>>>>>>>> add applicant user<<<<<<<<<<<<\e[0m"
useradd roboshop
echo -e "\e[35m>>>>>>>>>>>> setup app directory<<<<<<<<<<<<\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[35m>>>>>>>>>>>> download app content<<<<<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
echo -e "\e[35m>>>>>>>>>>>> extract content<<<<<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
echo -e  "\e[35m>>>>>>>>>>>> download dependencies<<<<<<<<<<<<\e[0m"
cd /app
npm install
echo -e "\e[35m>>>>>>>>>>>> setup systemd service<<<<<<<<<<<<\e[0m"
cp /home/centos/roboshop-scripting/catalogue.service /etc/systemd/system/catalogue.service
echo -e "\e[35m>>>>>>>>>>>> load service<<<<<<<<<<<<\e[0m"
systemctl daemon-reload
echo -e "\e[35m>>>>>>>>>>>> start service<<<<<<<<<<<<\e[0m"
systemctl enable catalogue
systemctl start catalogue
echo -e "\e[35m>>>>>>>>>>>> setup mongodb repo file <<<<<<<<<<<<\e[0m"
cp /home/centos/roboshop-scripting/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[35m>>>>>>>>>>>> install mongodb<<<<<<<<<<<<\e[0m"

yum install mongodb-org-shell -y
echo -e "\e[35m>>>>>>>>>>>> load schema<<<<<<<<<<<<\e[0m"
mongo --host mongodb.naveendevops2.online </app/schema/catalogue.js

systemctl restart catalogue


