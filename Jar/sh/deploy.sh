#!/bin/bash
#这里可替换为jar包名字
APP=iot
APP_NAME=iot-0.0.1-SNAPSHOT.jar
APP_LOG=/logs/${APP}-server/GC/gc.log

#根据实际情况修改参数
JVM="-server -Xms2g -Xmx2g -Xmn512m -XX:PermSize=128M -XX:MaxNewSize=128m -XX:MaxPermSize=25zh6m -Xss256k  -Djava.awt.headless=true -XX:+CMSClassUnloadingEnabled -XX:+CMSPermGenSweepingEnabled -Xloggc:${APP_LOG}"
#APPFILE_PATH="-Dspring.config.location=/usr/local/config/application.properties"
#使用说明,用来提示输入参数
usage() {
    echo "Usage: sh 执行脚本.sh [start|stop|restart|status|log|backup]"
    exit 1
}
#检查程序是否在运行
is_exist(){
    pid=`ps -ef|grep $APP_NAME|grep -v grep|awk '{print $2}' `
    #如果不存在返回1,存在返回0
    if [ -z "${pid}" ]; then
        return 1
    else
        return 0
    fi
}

#启动方法
start(){
    is_exist
    if [ $? -eq "0" ]; then
        echo "${APP_NAME} is already running. pid=${pid} ."
    else
      # 把标准输出重定向到空设备，即只输出错误信息到日志文件
      # nohup java -jar app.jar >/dev/null 2>log &
      # 把标准输出和标准错误全重定向到空设备，即不输出日志
      #  nohup java -jar app.jar >/dev/null 2>&1 &

         nohup java $JVM -jar  $APP_NAME > /dev/null 2>log &
                #后台启动jar包，且控制环境变量，根据实际情况修改吧。
#        nohup java $JVM -jar $APP_NAME --spring.profiles.active=prod > /dev/null 2>&1 &
    fi
}

#停止方法
stop(){
    is_exist
    if [ $? -eq "0" ]; then
        kill -9 $pid
    else
        echo "${APP_NAME} is not running"
    fi
}

#输出运行状态
status(){
    is_exist
    if [ $? -eq "0" ]; then
        echo "${APP_NAME} is running. Pid is ${pid}"
    else
        echo "${APP_NAME} is NOT running."
    fi
}
#重启
restart(){
    stop
    start
}

#日志
log(){
        # 输出实时日志
    tail -n 100 -f ${APP_LOG}
}

#备份
backup(){
        #根据需求自定义备份文件路径。
    BACKUP_PATH=/usr/local/webapps/backup/${APP}-server/
        #获取当前时间作为备份文件名
    BACKUP_DATE=`date +"%Y%m%d(%H:%M:%S)"`
    echo 'backup file ->'$BACKUP_PATH$BACKUP_DATE'.jar'
        #备份当前jar包
    cp -r /usr/local/webapps/$APP_NAME  $BACKUP_PATH$BACKUP_DATE'.jar'
}

#根据输入参数,选择执行对应方法,不输入则执行使用说明
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
    "restart")
        restart
        ;;
    "log")
        log
        ;;
    "backup")
        backup
        ;;
    *)
usage
;;
esac
