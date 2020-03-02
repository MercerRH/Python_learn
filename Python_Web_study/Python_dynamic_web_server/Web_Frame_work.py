import time


class Application_Frame():
    """框架用法：
       1、实例对象是一个application函数，接收env和start_response两个参数，后面那个是函数指针
       2、修改URLS和其他方法以改变遍历路由
    """
    def __init__(self, URLS):
        # 设置路由信息
        self.urls = URLS

    def __call__(self, env, start_response):
        # 对env的键值解析
        path = env.get("PATH_INFO", "/")

        # 对url进行遍历，对比是否存在用户的请求目标
        for key, handler in URLS:
            if path == key:
                return handler(env, start_response)
        # 不存在则返回404
        status = "200 OK"
        headers = []
        start_response(status, headers)
        return "function Not Found"


def test_cur_time(env, start_response):
    """返回当前时间"""
    print("env:" + str(env))
    status = "200 OK"
    headers = []
    start_response(status, headers)
    return time.ctime()


def test_tell_name(env, start_response):
    """返回秦川德里奇之名"""
    print("env:" + str(env))
    status = "200 OK"
    headers = []
    start_response(status, headers)
    return "Quin"


def index(env, start_response):
    "返回默认静态界面"
    status = "200 OK"
    headers = []
    start_response(status, headers)
    f = open("index.html", "rb")
    file_data = f.read()
    f.close()
    return file_data.decode("utf-8")


# 作为路由分发请求
URLS = [
    ("/cur_time", test_cur_time),
    ("/tell_name", test_tell_name),
    ("/", index)
]


application = Application_Frame(URLS)