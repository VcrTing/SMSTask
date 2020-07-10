
NULL = '無'

UNKNOW = '未知'

LANG = (
    (1, '繁體'),
    (2, '英文'),
)

TIME_RULE = (
    (0, '即時發送'),
    (1, '壹月後'),
    (2, '二月後'),
    (3, '三月後'),
    (4, '四月後'),
    (5, '五月後'),
    (6, '六月後'),
    (7, '七月後'),
    (8, '八月後'),
    (9, '九月後'),
    (10, '十月後'),
    (11, '十壹月後')
)

TIME_RULE_EMAIL = [
    [0, '一次性'],
    [1, '每月'],
    [2, '每兩月'],
    [3, '每三月'],
    [4, '每四月'],
    [5, '每五月'],
    [6, '每六月'],
    [7, '每七月'],
    [8, '每八月'],
    [9, '每九月'],
    [10, '每十月'],
    [11, '每十一月'],
    [12, '每一年'],
    [13, '每兩年'],
]

CATEGORY = (
    (1, '疫苗'),
    (2, '手術'),
    (3, '美容'),
    (21, '產品'),
    (22, '服務'),
    (23, '檢查')
)

NUMED = (
    (0, '零'),
    (1, '一'),
    (2, '二'),
    (3, '三'),
    (4, '四'),
    (5, '五'),
    (6, '六'),
    (7, '七'),
    (8, '八'),
    (9, '九'),
    (10, '十'),
    (11, '十一'),
)

NUMED_EN = (
    (0, 'Zero'),
    (1, 'first'),
    (2, 'second'),
    (3, 'third'),
    (4, 'fourth'),
    (5, 'fifth'),
    (6, 'sixth'),
    (7, 'seventh'),
    (8, 'eighth'),
    (9, 'ninth'),
    (10, 'tenth'),
    (11, 'eleventh'),
)

WAY = (
    (1, '短信'),
    (2, '电邮'),
    (3, 'Whats App')
)

SYSTEMMSGTYPED = (
    (1, '余额提醒'),
    (2, '客人再次光临的提醒'),
    (3, '系统事务预告'),
    (4, '杂项与其他提醒'),
    (111, '系统 APScheduler 进程已停止！！！'),
    (112, '客人意见反馈！！！'),
    (113, '平台数据备份状态反馈。'),
)

ICON = [
    {
        'name': '紫蝴蝶（系统默认）',
        'def': 'icon_0.jpg'
    },
    {
        'name': '可爱猫咪',
        'def': 'icon_1.jpg'
    },
    {
        'name': '洛丽塔女生',
        'def': 'icon_2.jpg'
    },
    {
        'name': '动漫风格 - 简约，拉姆',
        'def': 'icon_3.jpg'
    },
    {
        'name': '动漫风格 - 爱自拍，初音未来（近）',
        'def': 'icon_4.jpg'
    },
    {
        'name': '动漫风格 - 爱自拍，初音未来（远）',
        'def': 'icon_5.jpg'
    },
    {
        'name': '动漫风格 - 清新靓丽，碧蓝航线 可畏',
        'def': 'icon_6.jpg'
    }
]
BGIMG = [
    {
        'name': '摄影风景 - 香港城市（系统默认）',
        'def': 'bgimg_0.jpg'
    },
    {
        'name': '摄影风景 - 紫色山景',
        'def': 'bgimg_1.jpg'
    },
    {
        'name': '摄影风景 - 碧蓝海滩',
        'def': 'bgimg_2.jpg'
    },
    {
        'name': '动漫风格 - 清凉一夏',
        'def': 'bgimg_3.jpg'
    }
]