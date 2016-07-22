# -*- coding: cp936 -*-

import sys
import os
import xml.dom.minidom


def fixAddIncDir( tool_node ) :
	addIncDir = tool_node.attributes["AdditionalIncludeDirectories"].value
	addIncDir = addIncDir + ";$(rootdir);"
	tool_node.attributes["AdditionalIncludeDirectories"].value = addIncDir

def fixOutputFile( cfg_name, tool_node ):
	if "Debug" in cfg_name:
		outputFile = tool_node.attributes["OutputFile"].value
		pos = outputFile.find(".")
		if (pos != -1) :
			outputFile = outputFile[:pos] + "_d" + outputFile[pos:]
			tool_node.attributes["OutputFile"].value = outputFile

def fixAddLibDir( tool_node ) :
	addLibDir = tool_node.attributes["AdditionalLibraryDirectories"].value
	addLibDir = addLibDir + ";..\\..\\bin;..\\..\\lib"
	tool_node.attributes["AdditionalLibraryDirectories"].value = addLibDir


def fixOutputDir( conf_nodes ):
	for node in conf_nodes:
		cfg_name = node.attributes["Name"].value
		cfg_type = node.attributes["ConfigurationType"].value
		node.setAttribute("IntermediateDirectory", "$(rootdir)\\build\\intermediate\\$(ProjectName)\\$(PlatformName)\\$(ConfigurationName)")
		node.setAttribute("InheritedPropertySheets", "..\\myvar.vsprops")
		if (cfg_type == '1' or cfg_type == '2'):       #exe dll
			node.setAttribute("OutputDirectory", "$(rootdir)\\bin")
		elif (cfg_type == '4'):     #lib
			node.setAttribute("OutputDirectory", "$(rootdir)\\lib")
		tool_nodes = node.getElementsByTagName("Tool")
		for tool_node in tool_nodes:
			tool_name = tool_node.attributes["Name"].value
			if (tool_name == "VCCLCompilerTool") :
				fixAddIncDir(tool_node)
			elif (tool_name == "VCLinkerTool") :
				if (cfg_type == '1' or cfg_type == '2'):   #exe dll
					fixAddLibDir(tool_node)
					fixOutputFile(cfg_name, tool_node)
			elif (tool_name == "VCLibrarianTool") :
				if (cfg_type == '4') :    #lib
					fixAddLibDir(tool_node)
					fixOutputFile(cfg_name, tool_node)


def fixProj( projFile ):
	# 读取xml文件
	xmldoc = xml.dom.minidom.parse(projFile)

	# 找到目标node
	vsProj_nodes = xmldoc.getElementsByTagName("VisualStudioProject")
	conf_nodes = vsProj_nodes[0].getElementsByTagName("Configurations")
	conf_node = conf_nodes[0].getElementsByTagName("Configuration")

	fixOutputDir( conf_node )

	# 保存xml文件
	writeFile = open(projFile, 'w')
	writeFile.write(xmldoc.toxml('utf-8'))


if __name__ == "__main__":

	# 获得参数个数
	argc = len(sys.argv)

	for i in range(1, argc, 1):
		print "fix:", sys.argv[i]
		fixProj( sys.argv[i] )