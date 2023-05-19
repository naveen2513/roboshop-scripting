app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")

fun_head () {
    echo -e "\e[35m>>>>>>>>>>>> $1<<<<<<<<<<<<\e[0m"

}
fun_nodjs () {

  fun_head setup nodejs
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash
  fun_head install nodejs
  yum install nodejs -y

  fun_app_prereq

  fun_head download dependencies
  npm install
  fun_head setup systemd service
  cp /home/centos/roboshop-scripting/${component}.service /etc/systemd/system/${component}.service
  fun_head load service
  systemctl daemon-reload
  fun_head start service
  systemctl enable ${component}
  systemctl restart ${component}

}
fun_schema() {
  fun_head setup mongodb repo file
  cp /home/centos/roboshop-scripting/mongo.repo /etc/yum.repos.d/mongo.repo
  fun_head install mongodb

  yum install mongodb-org-shell -y
  fun_head load schema
  mongo --host mongodb.naveendevops2.online </app/schema/${component}.js

}
fun_app_prereq () {
  useradd ${app_user}
  fun_head create app directory

  rm -rf /app
  mkdir /app
  fun_head   download app content
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
  fun_head extract content

  cd /app
  unzip /tmp/${component}.zip
}
