rem
rem ����Ӧ�ó���, ��Ŀ¼���ź�, 
rem ��Ҫ�ȱ���ù���, ���ִ���������
rem

rem
rem ���������Ŀ¼
rem
del .\deploy_release\*.* /s /q
rmdir .\deploy_release /s /q
md .\deploy_release

md .\deploy_release\XenaManager


rem
rem ��������ʱĿ¼�ṹ, �������������ļ�
rem
copy ..\version.xml               .\deploy_release\XenaManager
copy ..\change.log                .\deploy_release\XenaManager

copy ..\bin\licencesLib.dll       .\deploy_release\XenaManager  
copy ..\bin\sclManager.dll        .\deploy_release\XenaManager 
copy ..\bin\XenaManager.exe       .\deploy_release\XenaManager 

xcopy ..\runtime\*.*              .\deploy_release\XenaManager\ /e /y

rem
rem  ����QT����ʱ��
rem
set QT_DISK=D:
set QT_VERSION=4.8.1
set QT_DIR=%QT_DISK%\Qt\%QT_VERSION%\bin
copy %QT_DIR%\QtCore4.dll         .\deploy_release\XenaManager
copy %QT_DIR%\QtGui4.dll          .\deploy_release\XenaManager
copy %QT_DIR%\QtNetwork4.dll      .\deploy_release\XenaManager
copy %QT_DIR%\QtXml4.dll          .\deploy_release\XenaManager

