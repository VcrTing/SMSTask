// 模版图片回现
sendFile = function(file, editor, $editable) {
    var filename = false;
    try {
        filename = file['name'];
    } catch(e) {
        filename = false;
    }
    if (!filename) {
        $(".note-alarm").remove();
    }
    
    // 以上防止在圖片在編輯器內拖拽引發第二次上傳導致的提示錯誤
    var ext = filename.substr(
        filename.lastIndexOf(".")
    );
    ext = ext.toUpperCase(); // 驗證圖片類型

    // Name是文件名，自己隨意定義，aid是我自己增加的屬性用於區分文件用戶
    
    data = new FormData();
    data.append("file", file);
    data.append("name", filename);
    // data.append("token", $("#summernote").attr('token'));
    data.append('csrfmiddlewaretoken', '{{ csrf_token }}')

    console.log(data)
    console.info(file)

    $.ajax({
        data: data,
        type: "POST",
        url: _root + '/img',
        contentType: false,
        cache: false,
        processData: false,
        success: function (data) {  
            console.log(data)
            /*
            var path = data.data;
            $('#summernote').summernote('insertImage', path, filename);
            $("img").addClass("img-responsive center-block");
            */
        },  
        error: function () {  
            alert("上傳失敗！");  
        }  
    });
    
}


// 当前时间
_now = function(qiong = '-', short = true) {
    const d = new Date()
    const year = d.getFullYear()
    let month = d.getMonth() + 1
    let day = d.getDate()

    month = month<10?('0' + month):month
    day = day<10?('0' + day):day

    let res = year + qiong + month + qiong + day
    if (!short) {
        const hour = d.getHours()
        const minute = d.getMinutes()
        const second = d.getSeconds()
        return res + ' ' + hour + ':' + minute + ':' + second
    }
    return res
}

// 时间暂停
_sleep = function(ms) {
    return new Promise(resolve => 
        setTimeout(resolve, ms)
    )
}

// 清空信息
_clearMsgDom = function () {
    _sleep(8000).then(() => {
        $('#msg_dom').fadeOut(600, () => {
            $('#msg_dom').html('')
            $('#msg_dom').fadeIn(300)
        })
    })
}
// 定位短信余量提示信息
locationSmsNum = function (jsms_num, twilio_num, twilio_currency) {
    if (jsms_num < 30) {
        $('#sms_num_dom').html(
            '<div class="alert alert-danger" role="alert">警告：大陸地區的短信余量只剩下 【' + 
                jsms_num + '】條，条数為 0 將無法發送短信，請您及時充值！！！' +
            '</div>'
        )
    }
    if (twilio_num < 5.0) {
        $('#sms_num_dom').append(
            '<div class="alert alert-danger" role="alert">警告：港澳地區的短信服務金額只剩下 【' + 
                twilio_num + '】' + twilio_currency + '，金額過少將無法發送短信，請您及時充值！！！' +
            '</div>'
        )
    }
}

// 本地储存
vGet = function(k) {
    return localStorage.getItem(k)
}
vSet = function(k , v) {
    localStorage.setItem(k , v)
}
vRemove = function(k) {
    localStorage.removeItem(k)
}

// 年龄计算
function _age_num(number, date = new Date()) {
    date.setFullYear(date.getFullYear() - number);
    let mon = date.getMonth()
    let day = date.getDay()

    if (day <= 0) {
        day = 1
    } else if (day >= 31) {
        day = 31
    }

    if (mon <= 0) {
        mon = 1
    } else if (mon >= 12) {
        mon = 12
    }
    
    return date.getFullYear() + '-' + mon + '-' + day;
}

function DateAdd(res, number, date) {
    switch (res) {
        case "y ": {
            date.setFullYear(date.getFullYear() + number);
            return date;
            break;
        }
        case "q ": {
            date.setMonth(date.getMonth() + number * 3);
            return date;
            break;
        }
        case "m ": {
            date.setMonth(date.getMonth() + number);
            return date;
            break;
        }
        case "w ": {
            date.setDate(date.getDate() + number * 7);
            return date;
            break;
        }
        case "d ": {
            date.setDate(date.getDate() + number);
            return date;
            break;
        }
        case "h ": {
            date.setHours(date.getHours() + number);
            return date;
            break;
        }
        case "m ": {
            date.setMinutes(date.getMinutes() + number);
            return date;
            break;
        }
        case "s ": {
            date.setSeconds(date.getSeconds() + number);
            return date;
            break;
        }
        default: {
            date.setDate(d.getDate() + number);
            return date;
            break;
        }
    }
}