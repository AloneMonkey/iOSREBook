//show ui 
//controller

//by: AloneMonkey

ObjC.schedule(ObjC.mainQueue, function(){

  	const window = ObjC.classes.UIWindow.keyWindow();
  	
  	const ui = window.recursiveDescription().toString();
	
  	send({ ui: ui });
});


ObjC.schedule(ObjC.mainQueue, function(){

	const window = ObjC.classes.UIWindow.keyWindow();

	const rootControl = window.rootViewController();

	const control = rootControl['- _printHierarchy']();

	send({ ui: control.toString() });
});

function handleMessage(message) {

  var order = message.substring(0,1);
  var command = '';

  switch(order){
  	case 'n':
  		command = message.substring(2);
  		
  		var view = new ObjC.Object(ptr(command));

	  	var nextResponder = view.nextResponder();

	  	nextResponder = new ObjC.Object(ptr(nextResponder));

	  	var deep = 0;

	  	var pre = '';

	  	while(nextResponder){

	    	pre += '-';

	      	send({ ui: pre+'>'+nextResponder.toString()});

	  		nextResponder = nextResponder.nextResponder();

	  		nextResponder = new ObjC.Object(ptr(nextResponder));
	  	}
  		break;
  	default:
  		send({ ui: 'error command' });
  }
  recv(handleMessage);
}

recv(handleMessage);