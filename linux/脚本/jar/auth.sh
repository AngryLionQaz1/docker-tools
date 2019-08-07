PROJECT_PATH=/root/project/巴渝民宿/auth
APP_NAME=auth
JAR_NAME=auth-0.0.1-SNAPSHOT.jar
APP_PATH=ssh://admin@47.92.213.93:29418/~admin/soil.git
PID=$APP_NAME\.pid
cd $PROJECT_PATH
init(){
git clone $APP_PATH
if [ $? -eq "0" ];then
    cd $APP_NAME
    mvn clean package
    cd target
    mv -f $JAR_NAME $PROJECT_PATH
else
    stop
    cd $APP_NAME
    git pull
    mvn clean package
    cd target
    mv -f $JAR_NAME $PROJECT_PATH
fi
}
usage() {
    echo "Usage: sh 执行脚本.sh [start|stop|restart|status|init|jenkins]"
    exit 1
}
is_exist(){
  pid=`ps -ef|grep $JAR_NAME|grep -v grep|awk '{print $2}' `
  #如果不存在返回1，存在返回0
  if [ -z "${pid}" ]; then
   return 1
  else
    return 0
  fi
}
start(){
  is_exist
  if [ $? -eq "0" ]; then
    echo ">>> ${JAR_NAME} is already running PID=${pid} <<<"
  else
    nohup java -Xms256m -Xmx512m -jar $JAR_NAME >/dev/null 2>&1 &
    echo $! > $PID
    echo ">>> start $JAR_NAME successed PID=$! <<<"
   fi
  }
start_jenkins(){
   cd $PROJECT_PATH
  is_exist
  if [ $? -eq "0" ]; then
    echo ">>> ${JAR_NAME} is already running PID=${pid} <<<"
  else
    nohup java -Xms256m -Xmx512m -jar $JAR_NAME >/dev/null 2>&1 &
    echo $! > $PID
    echo ">>> start $JAR_NAME successed PID=$! <<<"
   fi
  }

stop(){
  #is_exist
  pidf=$(cat $PID)
  #echo "$pidf"
  echo ">>> api PID = $pidf begin kill $pidf <<<"
  kill $pidf
  rm -rf $PID
  sleep 2
  is_exist
  if [ $? -eq "0" ]; then
    echo ">>> api 2 PID = $pid begin kill -9 $pid  <<<"
    kill -9  $pid
    sleep 2
    echo ">>> $JAR_NAME process stopped <<<"
  else
    echo ">>> ${JAR_NAME} is not running <<<"
  fi
}
status(){
  is_exist
  if [ $? -eq "0" ]; then
    echo ">>> ${JAR_NAME} is running PID is ${pid} <<<"
  else
    echo ">>> ${JAR_NAME} is not running <<<"
  fi
}
restart(){
  stop
  start
}
jenkins(){
  init
  start_jenkins
}
case "$1" in
  "start")
    start
    ;;
  "stop")
    stop
    ;;
  "status")
    status
    ;;
  "init")
    init
    ;;
  "jenkins")
    jenkins
    ;;
  "restart")
    restart
    ;;
  *)
    usage
    ;;
esac
exit 0
