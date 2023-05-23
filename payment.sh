script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbitmq_password=$1

if [ -z "${rabbitmq_password}" ]; then
  echo Input Roboshop Appuser Password Missing
  exit 1
fi

component=payment
func_python