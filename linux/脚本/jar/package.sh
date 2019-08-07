
PROJECT_PATH=/root/project/巴渝民宿/auth
JAR_NAME=auth-0.0.1-SNAPSHOT.jar
P_DIR=auth
cd $PROJECT_PATH/$P_DIR

mvn clean package

cd  target

mv $JAR_NAME $PROJECT_PATH
