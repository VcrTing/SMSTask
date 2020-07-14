
        

initLibrarySelcetor = function() {
    $('div.note-group-select-from-files').html('' +
        '<div class="btn btn-info" onclick="openLibrary()">從媒體庫中選取</div>'
    )
}

back = function() {
    history.back()
}

/*
    验证表单
*/

xss = function(rec) {
    rec = rec.toLowerCase()
    
    // char = /^$/;
    let char = /.cookie/
    if (char.test(rec)) {
        
        return '不允许存在 “.cookie” 字样！！！'
    }

    char = /document./
    if (char.test(rec)) {
        
        return '不允许存在 “document.“ 字样！！！'
    }
    
    rec = rec.replace(/(^\s*)|(\s*$)/g, "")
    char = /<script/
    if (char.test(rec)) {
        
        return '不允许存在 “<script“ 字样！！！'
    }

    return true
}
