#!/usr/bin/env python2
# -*- coding: utf-8 -*-

import sys
import frida
import codecs
import threading

global session

finished = threading.Event()

APP_JS = './js/app.js'
UI_JS = './js/ui.js'
HOOK_JS = './js/hook.js'

#系统标准输出，支持grep
def outWrite(text):
	sys.stdout.write(text.encode('utf8') + '\n');

#带颜色打印输出
def colorPrint(color, s):
	return "%s[31;%dm%s%s[0m" % (chr(27), color, s , chr(27))

#从JS接受信息
def on_message(message, data):
	if message.has_key('payload'):
		payload = message['payload']
		if isinstance(payload, dict):
			deal_message(payload)
		else:
			print payload

#处理JS中不同的信息
def deal_message(payload):
	#基本信息输出
	if payload.has_key('mes'):
		print payload['mes']

	#安装app信息
	if payload.has_key('app'):
		app = payload['app']
		lines = app.split('\n')
		for line in lines:
			if len(line):
				arr = line.split('\t')
				if len(arr) == 3:
					outWrite('%-40s\t%-70s\t%-80s' % (arr[0], arr[1], arr[2]))
	
	#处理UI界面输出
	if payload.has_key('ui'):
		print colorPrint(31, payload['ui'])

	#处理完成事件
	if payload.has_key('finished'):
		finished.set()

#获取第一个USB连接的设备
def get_usb_iphone():
	dManager = frida.get_device_manager();   #获取设备管理器
	changed = threading.Event()
	def on_changed():
		changed.set()
	dManager.on('changed',on_changed)        #监听添加设备的事件

	device = None
	while device is None:
		devices = [dev for dev in dManager.enumerate_devices() if dev.type =='tether']  #类型为tether为USB连接的设备
		if len(devices) == 0:
			print 'Waiting for usb device...'
			changed.wait()
		else:
			device = devices[0]				 #获取第一个设备

	dManager.off('changed',on_changed)    

	return device

#枚举运行进程信息
def listRunningProcess():
	device = get_usb_iphone();
	processes = device.enumerate_processes();
	processes.sort(key = lambda item : item.pid)
	outWrite('%-10s\t%s' % ('pid', 'name'))
	for process in processes:
		outWrite('%-10s\t%s' % (str(process.pid),process.name))

#枚举某个进程的所有模块信息
def listModulesoOfProcess(session):
	moduels = session.enumerate_modules()
	moduels.sort(key = lambda item : item.base_address)
	for module in moduels:
		outWrite('%-40s\t%-10s\t%-10s\t%s' % (module.name, hex(module.base_address), hex(module.size), module.path))
	session.detach()

#加载JS文件脚本
def loadJsFile(session, filename):
	source = ''
	with codecs.open(filename, 'r', 'utf-8') as f:
		source = source + f.read()
	script = session.create_script(source)
	script.on('message', on_message)
	script.load()
	return script

def main():
	global session
	# 1. 获取USB设备
	device = get_usb_iphone()
	# print '设备信息:' + str(device)

	# 2. 枚举运行进程信息
	# listRunningProcess()

	# 3. 枚举安装应用程序信息
	# session = device.attach(u'SpringBoard')
	# script = loadJsFile(session, APP_JS)
	# script.post({'cmd' : 'installed'})
	# finished.wait()

	# 4. 枚举某个进程加载的模块信息
	# session = device.attach(u'WhatsApp')
	# listModulesoOfProcess(session)

	# 5. 显示界面UI
	# session = device.attach(u'WhatsApp')
	# script = loadJsFile(session, UI_JS)
	# while True:
	# 	line = sys.stdin.readline()
	# 	if not line:
	# 		break
	# 	script.post(line[:-1])

	# 6. 动态Hook
	session = device.attach(u'WhatsApp')
	script = loadJsFile(session, HOOK_JS)
	sys.stdin.read()

if __name__ == '__main__':
	try:
		main()
	except KeyboardInterrupt:
		if session:
			session.detach()
		sys.exit()
	else:
		pass
	finally:
		pass