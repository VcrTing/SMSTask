
def _temp_para(named, numed):
    return {
        'named': named,
        'numed': numed
    }
    
# 定义短信参数
def val_sms_content(content, data):
    named = str(data['named'])
    numed = str(data['numed'])
    content = str(content).replace('{{named}}', named)
    content = content.replace('{{numed}}', numed)
    return content
