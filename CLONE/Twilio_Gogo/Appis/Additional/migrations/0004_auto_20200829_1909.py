# Generated by Django 2.2.5 on 2020-08-29 11:09

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Additional', '0003_emailapply_nper'),
    ]

    operations = [
        migrations.AddField(
            model_name='emailapply',
            name='now_time_rule',
            field=models.IntegerField(choices=[(0, '即時發送'), (1, '壹月後'), (2, '二月後'), (3, '三月後'), (4, '四月後'), (5, '五月後'), (6, '六月後'), (7, '七月後'), (8, '八月後'), (9, '九月後'), (10, '十月後'), (11, '十壹月後')], default=0, verbose_name='时间规则'),
        ),
        migrations.AlterField(
            model_name='emailapply',
            name='nper',
            field=models.IntegerField(choices=[(0, '無限制數量'), (1, '仅一封'), (2, '總二封'), (3, '總三封'), (4, '總四封'), (5, '總五封'), (6, '總六封'), (12, '十二封')], default=0, verbose_name='期数'),
        ),
    ]
