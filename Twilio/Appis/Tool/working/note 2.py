import time, datetime
from .. import doing as doing
from .. import send as send
from ..func import validate as validate
from .. import config as conf
from ..func.param import _temp_para


EACH_DAY = conf.EACH_DAY
DAY_OFFSET = conf.DAY_OFFSET

# 建立 发送前数据
def _build_task_para(every_task, time_rule_belong, real_time_rule_belong):
    res = None

    if every_task['status'] == True:

        sms_task = every_task['sms_task']
        sms_template = sms_task['sms_template']

        if sms_template['is_para']:
            named = sms_task['named']
            numed = int(every_task['numed']) + 1
        
            if sms_template['lang'] == 1:
                nume_rec = conf.NUMED
            elif sms_template['lang'] == 2:
                nume_rec = conf.NUMED_EN
                
            for i in nume_rec:
                if numed == i[0]:
                    numed = i[1]

            temp_para = _temp_para(named, numed)
        else:
            temp_para = None

        if real_time_rule_belong != 0:
            sms_template['content'] = sms_template['content_sub']
            sms_template['sms_id'] = sms_template['sms_id_sub']
        res = {
            'phoned_prefix': sms_task['area']['phoned_prefix'],
            'phoned': sms_task['phoned'],
            'temp_id': sms_template['sms_id'],
            'content': sms_template['content'],
            'temp_para': temp_para,
            'send_finish_time': validate.val_send_time(time_rule_belong, EACH_DAY, 0)
        }
    return res

# 执行发送
def _do_send(data):
    print('发送 Data =', data)
    res = None
    is_success = False
    if data['phoned_prefix'] == '+86':
        res = send.jsms_now(data['phoned'], data['temp_id'], data['temp_para'])
        res, is_success = doing.seial_response(res, 'jsms')
        print('Jsms is_success =', is_success)
    else:
        res = send.twilio_now(data['phoned_prefix'] + data['phoned'], data['content'], data['temp_para'])
        res, is_success = doing.seial_response(res, 'twilio')
        print('Twilio is_success =', is_success)
    return res, is_success

# 更改序列化 数据
def _every_task_new(every_task_id, is_send, send_finish_time, sms_response, schedule_id):
    send_status = is_send
    if is_send == None:
        send_status = False
        
    every_task_new = {
        'jsms_response': sms_response,
        'status': True,
        'send_finish_time': send_finish_time,
        'apply_status': is_send, # True: 发送成功/已序列化 | False: 发送失败 | None: 未序列化
        'send_status': send_status,
        'schedule_id': schedule_id
    }
    res = doing.update_every_task(every_task_id, every_task_new)
    return res

# 执行任务
def _do_task(every_task, time_rule_belong):

    # 获取数据
    res = None
    real_time_rule_belong = every_task['time_rule_belong']
    data = _build_task_para(every_task, time_rule_belong, real_time_rule_belong)

    if data:
        res = {
            'response': every_task['jsms_response'],
            'schedule_id': every_task['schedule_id']
        }
        is_send = None

        # 即时 发送短信
        if time_rule_belong == 0:
            print('开始 Do Send')
            res, is_send = _do_send(data)
        
        # 序列化 Every Task 状态
        res = _every_task_new(
            every_task['id'], 
            is_send, 
            data['send_finish_time'], 
            str(res['response']), 
            res['schedule_id']
        )
    return res

# 开始 序列化
def _serial_task(ids):
    
    for every_task_id in ids:
        print('当前Serial ID =', every_task_id)
        every_task = doing.get_every_task(every_task_id)
        print('当前every_task =', every_task)

        if every_task == None:
            break

        time_rule_belong = int(every_task['time_rule_belong'])
        print('当前time_rule_belong =', time_rule_belong)
        print('开始执行')

        res = _do_task(every_task, time_rule_belong)

        time.sleep(200)
