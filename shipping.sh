mysql_root_password=$1
if [ -z "${mysql_root_password}" ]; then
  echo password missing
  exit 1
fi


echo -e "\e[35m>>>>>>>>>>>> install maven<<<<<<<<<<<<\e[0m"
yum install maven -y
echo -e "\e[35m>>>>>>>>>>>> add applicant user<<<<<<<<<<<<\e[0m"
useradd roboshop
echo -e "\e[35m>>>>>>>>>>>> make app directory<<<<<<<<<<<<\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[35m>>>>>>>>>>>> download app content<<<<<<<<<<<<\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
echo -e "\e[35m>>>>>>>>>>>> extract app content<<<<<<<<<<<<\e[0m"
cd /app
unzip /tmp/shipping.zip
echo -e "\e[35m>>>>>>>>>>>> download dependencies<<<<<<<<<<<<\e[0m"
mvn clean package
echo -e "\e[35m>>>>>>>>>>>> build application<<<<<<<<<<<<\e[0m"
mv target/shipping-1.0.jar shipping.jar
echo -e "\e[35m>>>>>>>>>>>> setup systemd setup<<<<<<<<<<<<\e[0m"
cp /home/centos/roboshop-scripting/shipping.service /etc/systemd/system/shipping.service
echo -e "\e[35m>>>>>>>>>>>> reload service<<<<<<<<<<<<\e[0m"

systemctl daemon-reload

echo -e "\e[35m>>>>>>>>>>>>install mysql<<<<<<<<<<<<\e[0m"
yum install mysql -y
echo -e "\e[35m>>>>>>>>>>>>load schema<<<<<<<<<<<<\e[0m"
mysql -h mysql.naveendevops2.online -uroot -p${mysql_root_password} < /app/schema/shipping.sql

systemctl restart shipping




