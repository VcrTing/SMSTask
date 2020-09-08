/*
    邮件任务状态
*/
_ser_email_can = function(apply, send, over) {
    let can = false
    if (apply) {
        can = true
    }
    return can
}
_ser_email_status = function(apply, send, over) {
    let res = '<span class="apply">生效中</span>'
    if (apply) {
        if (over) {
            res = '<span class="complete">已完结</span>'
        } else {
            if (send) {
                res = '<span class="success">工作中</span>'
            } else {
                res = '<span class="red">停止</span>'
            }
        }
    }
    return res
} 
_ser_success_status = function(e) {
    if (e) {
        return '<span class="success">成功</span>'
    }
    return '<span class="red">失败</span>'
}


/*
    工作期限
*/
_ser_cycle = function(res) {
    if ((res == 0) || (res == '0')) {
        return '无期限'
    } else if ((res == 3) || (res == '3')) {
        return '3年'
    } else if ((res == 4) || (res == '4')) {
        return '4年'
    } else if ((res == 5) || (res == '5')) {
        return '5年'
    }
    return '无期限'
}

/*
    工具 序列化
*/
_is_number = function(res) {
    if(res === "" || res ==null){
        return false;
　　 }
    if (!isNaN(res)) {
        return true; 
    }
    else { 
        return false; 
    } 
}
/*
    其他序列化
*/
_ser_email_time_rule = function(e) {
    let res = '一次性'
    if (e < 6) {
        switch(e) {
            case 0: break;
            case 1: res = '每一月' 
                break;
            case 2: res = '每兩月'
                break;
            case 3: res = '每三月'
                break;
            case 4: res = '每四月'
                break;
            default:
                res = '每五月'
        }
    } else {
        switch(e) {
            case 6: res = '每六月' 
                break;
            case 7: res = '每七月'
                break;
            case 8: res = '每八月'
                break;
            case 9: res = '每九月'
                break;
            case 10: res = '每十月'
                break;
            case 11: res = '每十一月'
                break;
            case 12: res = '每一年'
                break;
            default:
                res = '每兩年'
        }
    }
    return res
}

_ser_filter_age = function (res) {
    const nan = _is_number(res)

    if (nan) {
        res = parseInt(res)
        if (res < 0) {
            return '年龄不能小于0岁！！！'
        } 
        else if (res > 150) {
            return '年龄大小不符合常理！！！'
        }
        return true
    } 
    else {
        return '请检查过滤器中年龄的输入是否有误！！！'
    }
}

/*
    联系人字段 序列化
*/
// 性别
_ser_gender = function(res) {
    if (res == 1) {
        return '男'
    } else if (res == 2) {
        return '女'
    } 
    return '未知'
}

// 星标
_ser_star = function(res) {
    if (res) {
        return '<span class="iconfont icon-star1 hand star star-active"></span>'
    } else {
        return '<span class="iconfont icon-star hand star"></span>'
    }
}
// 生日
_ser_bith = function(res, group=false, cn=true) {
    if (res == null) { return '' }
    res = res.split('-')
    
    if (group) {
        return {
            'year': res[0],
            'month': parseInt(res[1]),
            'day': parseInt(res[2])
        }
    }

    if (cn) {
        return res[0] + '年' + parseInt(res[1]) + '月' + parseInt(res[2]) + '日'
    } else {
        return res[0] + '-' + parseInt(res[1]) + '-' + parseInt(res[2])
    }
}
// 标签

// 年龄段
_ser_age = function(res) {
    return 0
}

/*
    任务字段 序列化
*/
const numed_txt = [
    '零', '一', '二', '三', '四', '五', '六', '七', '八', '九', '十', '十一'
]
const numed_txt_en = [
    'Zero', 'first', 'second', 'third', 'fourth', 'fifth', 'sixth', 'seventh', 'eighth', 'ninth', 'tenth', 'eleventh'
]
// 序列化 发送时间
_ser_send_time = function(e, cn=false, short=false) {
    if (e == null || e == undefined) {
        return '生效後生成時間'
    } else {
        year = e.substring(0, 4)
        month = e.substring(5, 7)
        day = e.substring(8, 10)
        hour = e.substring(11, 13)
        minute = e.substring(14, 16)

        if (cn) {
            if (short) {
                return year + '年' + month + '月' + day + '日 '
            }
            return year + '年' + month + '月' + day + '日 ' + hour + '時' + minute + '分'
        }
        
        if (short) {
            return year + '-' + month + '-' + day
        }
        return year + '-' + month + '-' + day + ' ' + hour + ':' + minute
    }
}
// 序列化 时间规则
_ser_time_rule_belong = function(e) {
    let res = '即時'
    if (e < 6) {
        switch(e) {
            case 0: break;
            case 1: res = '壹月後' 
                break;
            case 2: res = '二月後'
                break;
            case 3: res = '三月後'
                break;
            case 4: res = '四月後'
                break;
            default:
                res = '五月後'
        }
    } else if (e > 6) {
        switch(e) {
            case 7: res = '七月後'
                break;
            case 8: res = '八月後'
                break;
            case 9: res = '九月後'
                break;
            case 10: res = '十月後'
                break;
            default:
                res = '十壹月後'
        }
    } else {
        res = '六月後'
    }
    return res
}
// 序列化 发送状态
_ser_status = function(apply_status, send_status, task_status) {
    
    color = 'chocolate'
    text = '待生成'
    if (apply_status == true) {
        if (send_status == true) {
            color = 'green'
            text = '已發送'
        } else {
            color = 'red'
            text = '失敗！'
        }
    } else if (apply_status == false) {
        if (send_status == false) {
            color = 'rebeccapurple'
            text = '等待中'
        }
    }
    return '<div style="color: ' + color + ';">' + text + '</div>'
}

// 序列化 短信内容
_ser_content = function(template, short=false, params=null) {
    let res = template
    if (params != null) {
        let a = template.replace(/{{named}}/g, params['named']) + ''
        let b = a.replace(/{{numed}}/g, params['numed']) + ''
        let c = b.replace(/{{timed}}/g, params['timed']) + ''
        res = c
    }

    if (short) {
        res = template.substring(0, 10)
        return res + '...'
    } 
    return res
}

// 序列化 参数
_ser_numed = function(res, lang) {
    res += 1
    if (lang == 2) { // 繁体
        return numed_txt_en[res]
    } 
    
    return numed_txt[res]
}

// 序列化 Tag

_sel_tag = function(rec) {
    let res = []
    let len = rec.length
    
    if (len > 0) {
        for (let i= 0; i< len; i++ ) {
            const c = catchColor(i)
            
            res.push('<div class="hand simple-tag d-inline" data-id="' + rec[i]['id'] + '" style="color: ' + c + '; "><span>' + rec[i]['named'] + '</span></div>')
        }
    }
    return res
}

// 序列化 Nper

_sel_nper = function(nper_num) {
    for(let i= 0; i< nperList.length; i++ ) {
        if (nperList[i].val == nper_num) {
            return nperList[i].txt
        }
    }
}

// 序列化 首发发送

_sel_first_status = function(first_status) {
    if (first_status) {
        return '首封需發送'
    }
    return '首封不發送'
}

tagsUser = function(contact_id, targDom) {
    $.ajax({
        url: _root + '/tag/?option=user&contact_id=' + contact_id,
        type: 'GET',
        success: function(e) {
            
            const len = e['tags'].length

            if (len > 0) {
                const res = _sel_tag(e['tags'])

                for (let i= 0; i< res.length; i++ ) {
                    if (i > 0) {
                        targDom.append(', ')
                    }
                    targDom.append(res[i])
                }
            }
        }
    })
}


// IFRAME
_sel_iframe = function(rec) {
    if (rec ) {
        $('#content_help').html(rec)
    
        const vedio_src = $('#content_help').find('iframe').attr('src')
        if (!vedio_src.startsWith('http')) {
            $('#content_help').find('iframe').attr('src', 'https:' + vedio_src)
        }
        $('#content_help').find('iframe').attr('allowfullscreen', true)
        $('#content_help').find('iframe').attr('allow', 'accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture')
        return $('#content_help').html()
    }
    return rec
}