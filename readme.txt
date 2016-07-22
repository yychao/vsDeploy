【工具说明】
files：
    存放脚本工具需要使用到的文件
    
vsdeploy.bat:
    按照常用的源代码管理结构部署新的工程。
    
fixvcproj.bat：
    将新建的vs工程调整到适合源代码管理结构。

【环境设置】
   1、vsdeploy、fixvcproj环境设置
       添加“当前存放脚本的目录”到环境变量PATH
       新建环境变量“M_TOOLS_PATH” = 当前存放脚本的目录
       
【使用方法】
    1、vsdeploy使用
        打开cmd命令窗
        切换路径到你的工程目录下
        执行vsdeploy，按照提示输入工程名
    2、fixvcproj使用
        vsdeploy部署完后，打开build/sln下的工程文件
        在vs2008环境下，新添加工程到sln，新工程存放路径src/prj
        切换路径到新添加的工程
        执行fixvcproj 新工程名