# -*- coding: cp936 -*-

import sys
import os
import zipfile


# ���ļ���foldername ����ѹ��, ѹ������ļ�filename
def zipfolder( foldername, filename ):
	'''
		zip folder foldername and all its subfiles and folders into
		a zipfile named filename
	'''
	empty_dirs = []
	zip = zipfile.ZipFile(filename, 'w', zipfile.ZIP_DEFLATED)
	for root,dirs,files in os.walk(foldername):
	
		# ������еĿ�Ŀ¼
		for dir in dirs:
			if os.listdir(os.path.join(root, dir)) == []:
				empty_dirs.append(os.path.join(root, dir)[len(foldername)+1:])

	
		# ע��, ����������յ��ļ���ʱ, ��������ļ��м���zip�ļ�, ����Ҫ, ������ӶԿ��ļ��еĴ������
		for file in files:
			srcfile = os.path.join(root, file)
			print "compressing", srcfile
			zip.write(srcfile, srcfile[len(foldername):])
	
	# ����Ŀ¼��Ϊ���ļ�����zip
	for dir in empty_dirs:
		zip.writestr(dir+"\\", "")

	zip.close()
	print "Finish compressing:", os.path.abspath(filename)

# python zip_folder.py ..\bin
# python zip_folder.py  ��Ҫѹ�����ļ���
if __name__ == "__main__":

	# ��ò�������
	argc = len(sys.argv)  
	if argc == 0:
		raise AssertionError("not set zip folder!") 

	base_name = os.path.basename(os.path.abspath(sys.argv[1])) + ".zip"
	dst_path = sys.argv[1] + "\\..\\" + base_name
	if os.path.exists(dst_path) == True:
		raise TypeError(dst_path, " file has existed!")
	else:              
		zipfolder(sys.argv[1], dst_path);
		