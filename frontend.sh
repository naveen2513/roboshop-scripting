echo -e "\e[35m>>>>>>>>>>>> install nginx<<<<<<<<<<<<\e[0m"
yum install nginx -y
echo -e "\e{35m>>>>>>>>>>>> start nginx<<<<<<<<<<<<\e[0m"
systemctl enable nginx
systemctl start nginx
echo -e "\e{35m>>>>>>>>>>>> remove default content<<<<<<<<<<<<\e[0m"
rm -rf /usr/share/nginx/html/*
echo -e  "\e{35m>>>>>>>>>>>> download frontend content<<<<<<<<<<<<\e[0m"

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
echo -e "\e{35m>>>>>>>>>>>> extract frontend content<<<<<<<<<<<<\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
echo -e  "\e{35m>>>>>>>>>>>> setup systemd service<<<<<<<<<<<<\e[0m"
cp /home/centos/roboshop-scripting/roboshop.conf /etc/systemd/system/roboshop.conf
echo -e  "\e{35m>>>>>>>>>>>> restart nginx<<<<<<<<<<<<\e[0m"
systemctl restart nginx