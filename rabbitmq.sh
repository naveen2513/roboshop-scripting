rabbitmq_password=$1
if [ -z "${rabbitmq_password}"  ]; then
  echo password missing
  exit 1

fi

echo -e "\e[35m>>>>>>>>>>>> setup erlang repo<<<<<<<<<<<<\e[0m"

curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
echo -e "\e[35m>>>>>>>>>>>> setup rabbitmqrepo<<<<<<<<<<<<\e[0m"

curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash
echo -e "\e[35m>>>>>>>>>>>> install rabbitmq<<<<<<<<<<<<\e[0m"

yum install rabbitmq-server -y
echo -e "\e[35m>>>>>>>>>>>> restart rabbitmq<<<<<<<<<<<<\e[0m"

systemctl enable rabbitmq-server
systemctl restart rabbitmq-server
echo -e "\e[35m>>>>>>>>>>>> add user<<<<<<<<<<<<\e[0m"

rabbitmqctl add_user roboshop ${rabbitmq_password}
echo -e "\e[35m>>>>>>>>>>>> set password<<<<<<<<<<<<\e[0m"

rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"