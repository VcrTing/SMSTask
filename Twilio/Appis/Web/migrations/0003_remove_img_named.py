# Generated by Django 2.2.5 on 2020-06-12 12:00

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('Web', '0002_auto_20200612_1959'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='img',
            name='named',
        ),
    ]
