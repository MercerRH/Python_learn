from socket import *
from Web_Frame_work import application


class Web_Dynamic_Server():
    """接收的是框架的application实例对象"""
    def __init__(self, application):
        # 创建客户端套接字
        self.server_socket = socket(AF_INET, SOCK_STREAM)
        self.server_socket.setsockopt(SOL_SOCKET, SO_REUSEADDR, 1)
        self.application = application

    def bind(self, port):
        self.server_socket.bind(("",port))

    def start_response(self, status, headers):
        self.response_headers = "HTTP/1.1 " + status + "\r\n" + str(headers) + "\r\n"

    def start(self):
        print("------开始监听------")
        self.server_socket.listen(10)
        
        while True:
            print("------等待连接------")
            self.cli_socket, cli_info = self.server_socket.accept()
            print("------连接成功，开始接收数据------")
            
            # 开始接收数据
            cli_socket_send_data = self.cli_socket.recv(1024)
            
            # 对报文进行处理
            cli_socket_send_data = cli_socket_send_data.decode('utf-8')
            # 处理起始行
            cli_data_status = cli_socket_send_data.splitlines()[0]
            cli_request_file_name = cli_data_status.split(' ')[1]# 客户端请求的文件名
            # 处理响应头
            cli_request_header = cli_socket_send_data.splitlines()[1:]
            # 对env的暂时处理
            env = {}
            env["PATH_INFO"] = cli_request_file_name
            env["HEADER"] = cli_request_header

            # 返回的响应体
            response_body = self.application(env, self.start_response)

            # 向客户端发送信息
            response_data = self.cli_socket.send((self.response_headers + "\r\n" + response_body).encode("utf-8"))

            # 关闭客户端套接字
            self.cli_socket.close()

        # self.server_socket.close()


def main():
    web_server = Web_Dynamic_Server(application)
    port = int(input("请输入要绑定的端口："))
    web_server.bind(port)
    web_server.start()


if __name__ == "__main__":
    main()