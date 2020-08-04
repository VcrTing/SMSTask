// 驗證 電郵內容
_valide_message = function(message) {
    if (!message | message == undefined | message == '') {
        return '電郵內容不為空'
    } else {
        const len = message.length
        if (len < 20) {
            return '電郵內容字數應當大於20'
        } else if (len > 7200) {
            return '電郵內容字數不得大於 7200'
        }
    }
    return true

}

// 驗證壹般文本框
_valide_text = function(text, msg_named, isEmpty = false, min_len = 4, max_len = 240) {
    if (!isEmpty) {
        if (!text | text == undefined | text == '') {
            return msg_named + '不為空'
        }  
    } else {
        const len = text.length
        if (len < 4) {
            return msg_named + '字數應當大於' + min_len
        } else if (len > max_len) {
            return msg_named + '字數不得大於' + max_len
        }
    }
    return true
}

// 驗證名字
_valide_named = function(named) {
    if (!named | named == undefined | named == '') {
        return '名字不為空'
    }  else {
        const len = named.length
        if (len < 2) {
            return '確保名字字數大於2'
        } else if (len > 40) {
            return '請修改名字為40字以內'
        }

        let char = /[`~!@#$%^&*(“”‘’'、～·！—_+|=;？，。\\)<>?:"{},.\/;'[\]]/;
        if (char.test(named)) {
            return '名字中不應有特殊字符！！！'
        }
    }
    return true
}

// 驗證手機號碼的方法
_valide_phone = function(phone) {
    if (!phone | phone == undefined | phone == '') {
        return '電話號碼不為空'
    } else {
        const len = phone.length
        let char = /[`~!@#$%^&*(“”‘’'、～·！—_+|=;？，。\\)<>?:"{},.\/;'[\]]/;
        if (len < 8) {
            return '確保號碼字數大於等於8位'
        } else if (len > 60) {
            return '確保號碼字數小於60'
        }
        if (char.test(phone)) {
            return '號碼不需要特殊字符！！！'
        }
        char = /[abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ]/;
        if (char.test(phone)) {
            return '號碼中應不存在a-z以及A-Z的字母！！！'
        }
    }
    return true
}

// 驗證時間 年月日
_valide_date = function(dates, is_split = true) {
    if (is_split) {
        dates = dates.split('-')
    }

    if (dates.length == 3) {
        if (dates[0].length != 4) {
            return '年份格式錯誤，年份應為4位數！'
        } else if ((dates[1].length > 2) || (dates[1].length = 0)) {
            return '月份格式錯誤，月份應為2兩位數！'
        } else if ((dates[2].length > 2)  || (dates[2].length = 0)) {
            return '日期格式錯誤，日期應為2兩位數！'
        }

        if (dates[1] == '' ) {
            return '月份未填！！！'
        } else if (dates[2] == '') {
            return '日期未填！！！'
        }

        if ((parseInt(dates[1]) > 12 ) || (parseInt(dates[1]) == 0)) {
            return '月份數值錯誤！'
        } else if ((parseInt(dates[2]) > 31) || (parseInt(dates[2]) == 0)) {
            return '日期數值錯誤'
        }
    } else {
        return '格式錯誤，格式為：年-月-日。'
    }
    return true
}

_valide_bith = function(date, isEmpty) {
    if (!isEmpty) {
        if (!date | date == undefined | date == '') {
            return '生日的時間不能為空'
        }
    }
    let res = _valide_date(date)
    if (res == true) {
        return true
    }
    return '生日' + res
}

// 驗證郵箱
_val_email = function(date, isEmpty = false) {
    
    if (!isEmpty) {
        if (!date | date == undefined | date == '') {
            return '電郵不能為空!'
        }
    }
    char = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
    if (!char.test(date)) {
        return '請檢查郵箱地址格式的正確性！！！'
    }

    return true
}

// 驗證 標簽
_val_tag = function(named) {
    if ((named == '') || (named == null) || (named == undefined)) {
        return '標簽名稱不為空'
    } else {
        const len = named.length
        if (len < 12) {
            return '名稱長度應小於或等於12字符'
        }
    }
    return true
}
