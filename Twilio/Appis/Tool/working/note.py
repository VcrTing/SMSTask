import time, datetime
from .. import doing as doing
from .. import send as send
from ..func import validate as validate
from .. import config as conf
from ..func.param import _temp_para, val_sms_content

from Appis.Record import models as record_model

EACH_DAY = conf.EACH_DAY

def _build_para(content, named, numed):
    para = _temp_para(named, numed)
    res = val_sms_content(content, para)
    return res, para

def _do_send(reciver, area, jsms_id, temp_para, content):
    res = None
    is_success = False

    if ((area == '+86') or (area == '+ 86')):
        res = send.jsms_now(reciver, jsms_id, temp_para)

        res, is_success = doing.seial_response(res, 'twilio')
    else:
        reciver = area + ' ' + reciver
        res = send.twilio_now(reciver, content)

        res, is_success = doing.seial_response(res, 'twilio')
    
    return res, is_success

def _do_task(et):

    sms_task = et.sms_task
    sms_template = sms_task.sms_template

    jsms_id = sms_template.sms_id_sub
    content = sms_template.content_sub
    phoned_prefix = sms_task.area.phoned_prefix

    if et.send_status == False:
	
        if int(et.time_rule_belong) == 0:
            jsms_id = sms_template.sms_id
            content = sms_template.content
        
        et.apply_status = True
      
        # 建立参数，序列文本
        content, temp_para = _build_para(content, sms_task.named, et.numed)
        
        # 执行发送
        if et.status == True:
            # return True
            res, is_success = _do_send(sms_task.phoned, phoned_prefix, jsms_id, temp_para, content)

            et.schedule_id = res['schedule_id']
            et.temp_para = temp_para
            et.jsms_response = res['response']

            et.send_finish_time = datetime.datetime.now()
            et.send_status = is_success
            et.save()
            return is_success
        else:
            # return False
            et.temp_para = temp_para

            et.send_finish_time = datetime.datetime.now()
            et.send_status = False
            et.save()

    return False

def _do_runtask(rec):
    if rec['apply_status'] == False:
        et = record_model.EveryTask.objects.get(id = rec['id'])
        res = _do_task(et)
        return res
    return False

# 开始 序列化
def _serial_task(ids):
    for et_id in ids:
        try:
            et = record_model.EveryTask.objects.get(id = et_id)

            if et.apply_status == None:
                if et.send_status == False:

                    et.send_finish_time = validate.val_send_time(
                        et.time_rule_belong, 
                        EACH_DAY, 0
                    )
                    et.apply_status = False
                    et.save()
                    
                    if int(et.time_rule_belong) == 0:
                        _do_task(et)
        except Exception as e:
            pass

# 执行报废的 任务
# django 后台运行完，但是进程崩坏的任务
def _block_task():
    pass
