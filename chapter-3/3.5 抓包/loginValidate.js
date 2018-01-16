var http = require('http');
var url = require('url');
var querystring = require('querystring');
 
function isEmptyObject(obj) {
    for (var key in obj) {
     return false;
    }
    return true;
}

http.createServer(function(req, res){
    var data = '';     
 
    req.on('data', function(chunk){  
        data += chunk;
    });
 
    req.on('end', function(){  
        var params = url.parse(req.url, true).query;
        if(isEmptyObject(params)){
            params = querystring.parse(data);
        }
        var username = params.username;
        var password = params.password;

        res.writeHead(200, {'Content-Type': 'application/json'});

        if(username == "admin" && password == "123456"){
            res.end(JSON.stringify({username: username, status: 'success'}));
        }else{
            res.end(JSON.stringify({status: 'failed'}));
        }
    });
}).listen(8000);

console.log("server started: http://localhost:8000");