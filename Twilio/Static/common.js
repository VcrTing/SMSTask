
        

initLibrarySelcetor = function() {
    $('div.note-group-select-from-files').html('' +
        '<div class="btn btn-info" onclick="openLibrary()">從媒體庫中選取</div>'
    )
}

back = function() {
    history.back()
}