(function(utils) {
	var c = utils.constants = {};

	c.pviews = function(){
		return UIApp.keyWindow.recursiveDescription().toString();
	};

	c.pvcs = function(){
		return [[[UIWindow keyWindow] rootViewController] _printHierarchy].toString();
	};

	c.rp = function(target){
		var result = "" + target.toString();
		while(target.nextResponder){
			result += "\n" + target.nextResponder.toString();
			target = target.nextResponder;
		}
		return result;
	};

	for(var k in utils.constants) {
		Cycript.all[k] = utils.constants[k];
	}
})(exports);