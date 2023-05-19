app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")


fun_nodjs () {
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash
  echo -e "\e[35m>>>>>>>>>>>> install nodejs<<<<<<<<<<<<\e[0m"
  yum install nodejs -y
  echo -e "\e[35m>>>>>>>>>>>> add applicant user<<<<<<<<<<<<\e[0m"
  useradd ${app_user}
  echo -e "\e[35m>>>>>>>>>>>> setup app directory<<<<<<<<<<<<\e[0m"
  rm -rf /app
  mkdir /app
  echo -e "\e[35m>>>>>>>>>>>> download app content<<<<<<<<<<<<\e[0m"
  curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
  cd /app
  echo -e "\e[35m>>>>>>>>>>>> extract content<<<<<<<<<<<<\e[0m"
  unzip /tmp/catalogue.zip
  echo -e  "\e[35m>>>>>>>>>>>> download dependencies<<<<<<<<<<<<\e[0m"
  npm install
  echo -e "\e[35m>>>>>>>>>>>> setup systemd service<<<<<<<<<<<<\e[0m"
  cp /home/centos/roboshop-scripting/catalogue.service /etc/systemd/system/catalogue.service
  echo -e "\e[35m>>>>>>>>>>>> load service<<<<<<<<<<<<\e[0m"
  systemctl daemon-reload
  echo -e "\e[35m>>>>>>>>>>>> start service<<<<<<<<<<<<\e[0m"
  systemctl enable catalogue
  systemctl restart catalogue

}