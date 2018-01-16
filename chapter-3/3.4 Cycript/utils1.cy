function pviews(){
	return UIApp.keyWindow.recursiveDescription().toString();
};

function pvcs(){
	return [[[UIWindow keyWindow] rootViewController] _printHierarchy].toString();
};

function printIvars(a){ 
	var x={}; 
	for(i in *a){ 
		try{ 
			x[i] = (*a)[i]; 
		}catch(e){

		} 
	} 
	return x; 
};
 
function printMethods(className, isa) {
	var count = new new Type("I");
	var classObj = (isa != undefined) ? objc_getClass(className).constructor : objc_getClass(className);
	var methods = class_copyMethodList(classObj, count);
	var methodsArray = [];
	for(var i = 0; i < *count; i++) {
		var method = methods[i];
		methodsArray.push({selector:method_getName(method), implementation:method_getImplementation(method)});
	}
	free(methods);
	return methodsArray;
};