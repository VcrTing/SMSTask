# Generated by Django 2.2.5 on 2020-10-17 06:11

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Sms', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='category',
            name='flag',
            field=models.SmallIntegerField(choices=[(1, '疫苗'), (2, '手術'), (3, '美容'), (4, '商品'), (21, '產品'), (22, '服務'), (23, '檢查')], default=1, null=True, verbose_name='分类'),
        ),
    ]
