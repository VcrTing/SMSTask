
print('\nSMSTask 系统:')
option = 0

for i in range(0, 2):
    try:
        print('请输入你需要的操作:')
        print('1: 首次导入数据')
        print('2: 无')
        option = int(input('请输入:'))

    except:
        print('输入有误！！！')
    
if option == 1:
    pass