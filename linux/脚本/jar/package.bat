@echo off

SET NAME=auth 

SET JAR_NAME=auth-0.0.1-SNAPSHOT.jar

SET DIR=C:\Users\win\Desktop\project\byms\auth

cd %NAME%

call mvn clean package

cd target

echo %cd%

call xcopy /y %JAR_NAME% %DIR%


pause
