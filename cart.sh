echo -e "\e[35m>>>>>>>>>>>> setup nodejs repo file<<<<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[35m>>>>>>>>>>>> install nodejs <<<<<<<<<<<<\e[0m"
yum install nodejs -y
echo -e "\e[35m>>>>>>>>>>>> add applicant user <<<<<<<<<<<<\e[0m"
useradd roboshop
echo -e "\e[35m>>>>>>>>>>>> create app directory<<<<<<<<<<<<\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[35m>>>>>>>>>>>> download app content<<<<<<<<<<<<\e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
echo -e "\e[35m>>>>>>>>>>>> extract content<<<<<<<<<<<<\e[0m"

cd /app
unzip /tmp/cart.zip
echo -e "\e[35m>>>>>>>>>>>> download dependencies<<<<<<<<<<<<\e[0m"
npm install
echo -e "\e[35m>>>>>>>>>>>> setup systemd setup file<<<<<<<<<<<<\e[0m"
cp /home/centos/roboshop-scripting/cart.service /etc/systemd/system/cart.service
echo -e "\e[35m>>>>>>>>>>>> restart service<<<<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable cart
systemctl restart cart



