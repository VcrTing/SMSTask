# Generated by Django 2.2.5 on 2020-06-12 11:59

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Web', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='img',
            name='status',
        ),
        migrations.AddField(
            model_name='img',
            name='named',
            field=models.CharField(max_length=240, null=True, verbose_name='图片名字'),
        ),
    ]
