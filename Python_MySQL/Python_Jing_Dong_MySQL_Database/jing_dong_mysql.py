from pymysql import *
import time


class JingDong(object):
    def __init__(self):
        #创建connect对象
        self.conn = connect(host='localhost',port=3306,user='root',password='LP079qR8',database='jing_dong',charset='utf8')
        self.cursor = self.conn.cursor()
 
    def __del__(self):
        #关闭cursor对象
        self.cursor.close()
        self.conn.close()

    def execute_sql(self, sql):
        self.cursor.execute(sql)
        for temp in self.cursor.fetchall():
            print(temp)

    def show_all(self):
        '''显示所有商品'''
        sql = "select g.id,g.name,c.name,b.name,g.price from goods as g inner join goods_cates as c on g.cate_id=c.id inner join goods_brand as b on g.brand_id=b.id order by g.id;"
        self.execute_sql(sql)

    def show_cates(self):
        '''显示所有类别'''
        sql = "select * from goods_cates;"
        self.execute_sql(sql)

    def show_brand(self):
        '''显示所有商品类别'''
        sql = "select * from goods_brand;"
        self.execute_sql(sql)

    @staticmethod
    def print_menu():
        print("")
        print("1.查询所有信息\n2.查询所有分类\n3.查询所有品牌分类\n4.订单操作\n5.退出系统")
        num = input("请输入功能对应的序号：")
        return num
    
    def order_operation(self,user_id):
        """订单菜单"""
        while True:
            print("")
            print("1.下达订单\n2.查询所有订单\n3.查询订单细节\n4.返回上一级")
            num = input("请输入功能对应的序号：")
            if num == "1":
                self.release_order(user_id)
            elif num == "2":
                self.show_all_orders(user_id)
            elif num == "3":
                self.show_order()
            elif num == "4":
                break
            else:
                print("无效输入")

    def release_order(self, user_id):
        good_id = input("请输入要下单的商品id：")
        sql = "select * from goods where id=%s"%good_id
        #判断是否输入错误
        if self.cursor.execute(sql) == 0:
            print("商品id不正确！")
        else:
            sql = "insert into orders values(0,'%s',%s);"%(time.strftime('%Y.%m.%d',time.localtime(time.time())),user_id)
            self.cursor.execute(sql)
            order_id = self.cursor.lastrowid
            quantity = input("订单创建成功！id为%d，请输入要购买的数量："%order_id)
            sql = "insert into order_detail values(0,%s,%s,%s);"%(order_id,good_id,quantity)
            self.cursor.execute(sql)
            self.conn.commit()
    
    def show_all_orders(self, user_id):
        sql = "select * from orders where customer_id=%s;"%user_id
        print("(订单id，订单创建日期，顾客id)")
        self.execute_sql(sql)
    
    def show_order(self):
        order_id = input("请输入订单号：")
        sql = "select * from order_detail where order_id=%s;"%order_id
        print("(订单详情id，订单id，商品id，商品数量)")
        self.execute_sql(sql)

    def run(self, user_id):
        while True:
            num = self.print_menu()
            if num == "1":
                #查询所有商品
                self.show_all()
            elif num == "2":
                #查询分类
                self.show_cates()
            elif num == "3":
                #查询品牌分类
                self.show_brand()
            elif num == "4":
                #对订单进行操作
                self.order_operation(user_id)
            elif num == "5":
                break
            else:
                print("输入错误，重新输入..")


class UserClass():
    def __init__(self):
        self.conn = connect(host='localhost',port=3306,user='root',password='LP079qR8',database='jing_dong',charset='utf8')
        self.cursor = self.conn.cursor()
    
    def execute_sql(self, sql):
        self.cursor.execute(sql)
        return self.cursor.fetchall()

    @staticmethod
    def print_user_menu():
        """显示菜单"""
        print("")
        num = input("欢迎\n1.登录\n2.没有账号?注册一个\n3.退出\n请输入需要的功能：")
        return num

    def run(self):
        while True:
            num = self.print_user_menu()
            # 登录
            if num == '1':
                print("")
                login_id = input("请输入您的登录id：")
                login_password = input("请输入您的登录密码：")
                self.log_in(login_id, login_password)
            # 注册
            elif num == '2':
                print("")
                reg_name = input("请输入您的姓名：")
                reg_address = input("请输入您的地址：")
                reg_tel = input("请输入您的电话：")
                reg_password = input("请输入您的密码：")
                self.register(reg_name, reg_address, reg_tel, reg_password)
            # 退出
            elif num == '3':
                print("bye")
                break
            else:
                print("输入错误,请重新输入...")

    def log_in(self, id, password):
        #用户登陆的方法
        sql = "select id, password from customers;"
        check_data = self.execute_sql(sql)
        for i in check_data:
            if i[0] == int(id) and i[1] == password:
                print("登录成功！\n")
                self.user_page(i[0])
                break
        else:
            print("登录失败！请检查账号密码")

    def register(self, name, address, tel, password):
        #用户注册的方法
        sql = "insert into customers values(0,'%s','%s','%s','%s');"%(name,address,tel,password)
        self.execute_sql(sql)
        print("您的登录id为%d，请牢记"%self.cursor.lastrowid)
        self.conn.commit()

    def user_page(self, user_id):
        sql = "select name from customers where id=%d;"%user_id
        print("欢迎您，%s"%self.execute_sql(sql)[0])
        jd = JingDong()
        jd.run(user_id)


def main():
    #创建用户对象
    user = UserClass()
    #启动用户对象
    user.run()


if __name__ == "__main__":
    main()
