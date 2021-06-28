import multiprocessing

bind = "0.0.0.0:_YOUR_PORT"
backlog = 512 #监听队列数量，64-2048
worker_class = 'sync' # 使用gevent模式，还可以使用sync 模式，默认的是sync模式
workers = multiprocessing.cpu_count()
threads = multiprocessing.cpu_count()*4
loglevel = 'info' # error / info
access_log_format = '%(t)s %(p)s %(h)s "%(r)s" %(s)s %(L)s %(b)s %(f)s" "%(a)s"'

errorlog = "./log/gunicorn_error.log" 
accesslog = "-" # 访问日志文件，"-" 表示标准输出
errorlog = "-"

proc_name = 'Twilio' # 进程名
