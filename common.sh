app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")

fun_head () {
    echo -e "\e[35m>>>>>>>>>>>> $1<<<<<<<<<<<<\e[0m"


}
fun_stat_check () {
  if [ $1 -eq 0]; then
    echo -e "\e[32msuccess\e[0m"
  else
    echo -e "\e[32mfailure\e[0m"
    echo "refer the /tmp/roboshop.log for more information"
    exit 1
  fi
}
fun_nodjs () {

  fun_head setup nodejs
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>logfile
  fun_stat_check
  fun_head install nodejs
  yum install nodejs -y &>>logfile
  fun_stat_check

  fun_app_prereq

  fun_head download dependencies
  npm install &>>logfile
  fun_stat_check
  fun_head setup systemd service
  cp /home/centos/roboshop-scripting/${component}.service /etc/systemd/system/${component}.service &>>logfile
  fun_stat_check
  fun_head load service
  systemctl daemon-reload &>>logfile
  fun_stat_check
  fun_head start service
  systemctl enable ${component} &>>logfile
  systemctl restart ${component} &>>logfile
  fun_stat_check

}
fun_schema() {
  fun_head setup mongodb repo file
  cp /home/centos/roboshop-scripting/mongo.repo /etc/yum.repos.d/mongo.repo &>>logfile
  fun_stat_check
  fun_head install mongodb

  yum install mongodb-org-shell -y &>>logfile
  fun_stat_check
  fun_head load schema
  mongo --host mongodb.naveendevops2.online </app/schema/${component}.js &>>logfile
  fun_stat_check

}
fun_app_prereq () {
  useradd ${app_user}
  fun_head create app directory
  fun_stat_check

  rm -rf /app
  mkdir /app
  fun_stat_check
  fun_head   download app content
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
  fun_stat_check
  fun_head extract content

  cd /app
  unzip /tmp/${component}.zip
  fun_stat_check
}
