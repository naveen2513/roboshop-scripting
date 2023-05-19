echo -e "\e[35m>>>>>>>>>>>> setup nodejs repo file<<<<<<<<<<<<\e[0m"

curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[35m>>>>>>>>>>>> install nodejs<<<<<<<<<<<<\e[0m"
yum install nodejs -y
echo -e "\e[35m>>>>>>>>>>>> add applicant user<<<<<<<<<<<<\e[0m"
useradd roboshop
echo -e "\e[35m>>>>>>>>>>>> create app directory<<<<<<<<<<<<\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[35m>>>>>>>>>>>> download app content<<<<<<<<<<<<\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
echo -e "\e[35m>>>>>>>>>>>> extract content<<<<<<<<<<<<\e[0m"
cd /app
unzip /tmp/user.zip
echo -e "\e[35m>>>>>>>>>>>> download dependencies<<<<<<<<<<<<\e[0m"
npm install
echo -e "\e[35m>>>>>>>>>>>> setup systemd file<<<<<<<<<<<<\e[0m"
cp /home/centos/roboshop-scripting/user.service /etc/systemd/system/user.service
echo -e "\e[35m>>>>>>>>>>>> load service<<<<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable user
systemctl restart user
echo -e "\e[35m>>>>>>>>>>>> setup mongo repo file<<<<<<<<<<<<\e[0m"
cp /home/centos/roboshop-scripting/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[35m>>>>>>>>>>>> install mongodb<<<<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[35m>>>>>>>>>>>> load schema<<<<<<<<<<<<\e[0m"
mongo --host mongodb.naveendevops2.online </app/schema/user.js


