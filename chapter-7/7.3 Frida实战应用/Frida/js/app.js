//uninstall app 
//show installed app list

//by: AloneMonkey

const LSApplicationWorkspace = ObjC.classes.LSApplicationWorkspace;
const LSApplicationProxy = ObjC.classes.LSApplicationProxy;

function getDataDocument(appid){
	const dataUrl = LSApplicationProxy.applicationProxyForIdentifier_(appid).dataContainerURL();
	if(dataUrl){
		return dataUrl.toString() + '/Documents';
	}else{
		return "null";
	}
}

function installed(){
	const workspace = LSApplicationWorkspace.defaultWorkspace();
	const apps = workspace.allApplications();
	var result;
	for(var index = 0; index < apps.count(); index++){
		var proxy = apps.objectAtIndex_(index);
		result = result + proxy.localizedName().toString() + '\t' + proxy.bundleIdentifier().toString()+'\t'+getDataDocument(proxy.bundleIdentifier().toString())+'\n';
	}
	send({app : result}); 
};

function handleMessage(message) {
  if(message['cmd']){
  	if(message['cmd'] == 'installed'){
  		installed();
  	}
  }
  send({ mes: 'Successful operation!'});
  send({ finished: 'yes'});
}

recv(handleMessage);