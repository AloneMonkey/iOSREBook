<?php  

class SocketServer{  
    private $_port='6666';  
    private $_address='192.168.2.192';  
    private $_client_socket_list=array();  
    public function __set($name,$val){  
        $this->$name=$val;  
    }  
    private function _showError($error){  
        exit($error);  
    }  
    /** 
     * 开始进行socket服务器端监听端口 
     */  
    public function start(){  
        // 创建端口  
        if (($sock = socket_create ( AF_INET, SOCK_STREAM, SOL_TCP )) === false) {  
            $this->_showError("socket_create() failed :reason:" . socket_strerror ( socket_last_error () ));  
        }  
        // 绑定  
        if (socket_bind ( $sock, $this->_address, $this->_port ) === false) {  
            $this->_showError("socket_bind() failed :reason:" . socket_strerror ( socket_last_error ( $sock ) ));  
        }  
        // 监听  
        if (socket_listen ( $sock, 5 ) === false) {  
            $this->_showError("socket_bind() failed :reason:" . socket_strerror ( socket_last_error ( $sock ) ) );  
        }  
        do {  
            //当有一个客户端连接的时候  
            if ($client_socket=socket_accept ( $sock )) {  
                $count = count ( $this->_client_socket_list ) + 1;  
                //把新来的用户加入 客户端数组里  
                $this->_client_socket_list[]=$client_socket;  
                //接受客户端传过来的字符串  
                $msg=$this->read($client_socket);  
                if($msg){
                    echo "client:{$msg}\r\n";  
                    //服务器向客户端传值  
                    $my_msg="I am fine,think you\r\n";  
                    $this->send($client_socket,$my_msg);  
                }
            }  
                  
        }while(true);     
    }  
    /** 
     * 发送数据给客户端 
     */  
    public function send($client_socket,$str){    
        return socket_write ( $client_socket,$str, strlen ( $str ) );  
    }  
    /** 
     * 从客户端接受数据 
     */  
    public function read($client_socket){  
        return socket_read ( $client_socket, 8192 );
    }  
      
}  
$socket_server =new SocketServer();  
//开始监听 
$socket_server->start();