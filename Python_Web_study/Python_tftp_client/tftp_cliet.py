#-*- coding:utf-8 -*-
from socket import *
import struct
import time
import os

def main():
    tftp_socket = socket(AF_INET,SOCK_DGRAM)
    tftp_socket.bind(('',18008))
    
    #获取用户要下载的文件名
    download_ip = input("请输入服务器ip：")
    download_file_name = input("请输入想要下载的文件名：")
    download_file_name_len = len(download_file_name)

    download_request = struct.pack("!H%dsb5sb"%download_file_name_len,1,download_file_name.encode('utf-8'),0,b'octet',0)

    #发送下载请求
    tftp_socket.sendto(download_request,("%s"%download_ip,69))

    #打开缓存文件
    f = open(download_file_name,'bw')

    #接收到的包数量
    recv_pack_num = 1

    #判断传输是否错误
    flag = True

    #接收数据
    while True:
        response_data = tftp_socket.recvfrom(1024)
        recv_data,server_info = response_data
        recv_data_len = len(recv_data)

        #对数据进行解包
        cmd_tuple = struct.unpack("!HH",recv_data[:4])
        cmd = cmd_tuple[0]
        current_pack_num = cmd_tuple[1]

        #print(cmd)
        #print(current_pack_num) #test code
        #print(recv_data[4:])
        #break

        #判断传输是否正确
        if cmd == 3:
            if recv_pack_num == current_pack_num:#判断发送的包是否与本地包相同
                print("\r第%d个包正确接收"%current_pack_num,end = '')
                recv_pack_num += 1

                if recv_pack_num == 65536:#文件过大时重置计数器
                    recv_pack_num = 0

                f.write(recv_data[4:])
            tftp_socket.sendto(struct.pack("!HH",4,current_pack_num),server_info)                               
                
        elif cmd == 5:
            print("错误")
            flag = False

        #判断是否达到传输结尾
        if recv_data_len < 516:
            break

    if flag == True:
        f.close()
        print("\n传输完成")
    else:
        pass


if __name__ == "__main__":
    main()
