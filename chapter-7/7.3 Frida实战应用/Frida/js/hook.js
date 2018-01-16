'use strict';

//example 01
/*
function findHookMethod(clsname,mtdname){
  if(ObjC.available) {
      for(var className in ObjC.classes) {
          if (ObjC.classes.hasOwnProperty(className)) {
              if(className == clsname) {
                 return ObjC.classes[className][mtdname];
              }
          }
      }
  }
  return;
}

var method = findHookMethod('WAChatDataStore', '- didUpdateMessage:');

Interceptor.attach(method.implementation, {
	onEnter:function (args){
		console.log('-[WAChatDataStore didUpdateMessage:] onEnter...');

		var message = ObjC.Object(args[2]);
		console.log('message is:' + message.toString());

		var text = message['- text']();

		console.log('text is:' + text.toString());
	},
	onLeave:function(retVal){
		console.log('-[WAChatDataStore didUpdateMessage:] onLeave...');
	},
});*/

//example 02 

var deep = 0;

function enterOutPut(targetName,args){

     var self = ObjC.Object(args[0]);

      deep = deep + 1;
                
      var pre = '';

      for (var i = 0; i < deep; i++) {
         pre += '----------';
      }

      var output = pre+'->('+deep+')onEnter('+targetName+')';

      while(output.length < 120){
        output += '-';
      }
      
      send(output);

      var result = '';

      var sel = ObjC.selectorAsString(args[1]);

      result = result + targetName[0]+ " ["+self.toString()+" ";
        
      var argArr= new Array(); 

      argArr=sel.split(":");

      if(argArr.length > 1){
        for(var i = 0; i < argArr.length-1; i++){
          try{
            result = result + argArr[i] +":"+ ObjC.Object(args[i+2]).toString() + " ";
          }catch(e){
            result = result + argArr[i] +":"+ args[i+2].toInt32() + " ";
          }
        }
      }else{
        result = result + argArr +" ";
      }
      
      result = result.substring(0,result.length-1) + "]";

      send(result);  
}

function leaveOutPut(targetName,retval){

    if(retval){
      try{
        console.log('retVal:'+ObjC.Object(retval).toString() );
      }catch(e){
        console.log('retVal:'+retval.toInt32());
      }
    }
    
      var pre = '';

      for (var i = 0; i < deep; i++) {
         pre += '----------';
      }
      
      var output = pre+'->('+deep+')onLeave('+targetName+')';

      while(output.length < 120){
        output += '-';
      }
      send(output);

      deep = deep - 1;
}

var resolver = new ApiResolver('objc');
resolver.enumerateMatches('*[WAChatDataStore *]', {
    onMatch: function (match) {
        const mtdname = match['name'];
        const imp = match['address']; 
        // console.log(mtdname + ":" + imp);
        var targetName = mtdname;

        if(targetName != ".cxx_destruct"){
        	try{
	            Interceptor.attach(imp, {

	              onEnter: function (args) {

	                  enterOutPut(targetName, args);
	                 
	              },
	              onLeave: function (retval) {
	                  leaveOutPut(targetName, retval);
	              },
	            });
	      	}catch(e){
	        	console.log('hook '+mtdname+' error:'+e);
	      	}
        }
    },
    onComplete: function () {
        console.log('hook '+clsname+' finished!');
    }
});