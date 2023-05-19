rabbitmq_password=$1
if [ -z "$rabbitmq_password"  ]; then
  echo password missing
  exit 1
fi
echo -e "\e[35m>>>>>>>>>>>> install python36<<<<<<<<<<<<\e[0m"

yum install python36 gcc python3-devel -y
echo -e "\e[35m>>>>>>>>>>>> install python36<<<<<<<<<<<<\e[0m"

useradd roboshop
echo -e "\e[35m>>>>>>>>>>>> create app directory<<<<<<<<<<<<\e[0m"

rm -rf /app
mkdir /app
echo -e "\e[35m>>>>>>>>>>>> download app content<<<<<<<<<<<<\e[0m"

curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
echo -e "\e[35m>>>>>>>>>>>> extract content<<<<<<<<<<<<\e[0m"

cd /app
unzip /tmp/payment.zip
echo -e "\e[35m>>>>>>>>>>>> download dependencies<<<<<<<<<<<<\e[0m"

pip3.6 install -r requirements.txt
echo -e "\e[35m>>>>>>>>>>>> setup systemd file<<<<<<<<<<<<\e[0m"

cp /home/centos/roboshop-scripting/payment.service /etc/systemd/system/payment.service
echo -e "\e[35m>>>>>>>>>>>> setup password<<<<<<<<<<<<\e[0m"

sed -i -e "s|rabbitmq_password|${rabbitmq_password}|g" /home/centos/roboshop-scripting/payment.service
echo -e "\e[35m>>>>>>>>>>>> restart payment<<<<<<<<<<<<\e[0m"

systemctl daemon-reload
systemctl enable payment
systemctl restart payment