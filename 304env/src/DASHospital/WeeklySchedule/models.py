from django.db import models
from Staff.models import Staff
from django.urls import reverse
from datetime import datetime, time

# Create your models here.

class Weeklyschedule(models.Model):
    id = models.CharField(db_column='id', primary_key=True, max_length=8)
    sid = models.ForeignKey(Staff, models.CASCADE, db_column='sid', unique=True)

    class Meta:
        managed = False
        db_table = 'weeklyschedule'

class ScheduledTime(models.Model):
    # fakeKey = models.AutoField(db_column = 'fakekey', primary_key=True)
    date = models.DateField(db_column='date',null=False, primary_key=True)
    starttime = models.TimeField(db_column='starttime', null=False)
    endtime = models.TimeField(db_column='endtime', null=False)
    wid = models.ForeignKey('Weeklyschedule', models.CASCADE, db_column='wid')
    notes = models.CharField(db_column='notes', max_length=60, blank=True, null=True)


    class Meta:
        managed = False
        db_table = 'scheduled_time'
        unique_together = (('date', 'starttime', 'endtime', 'wid'),)

    def get_absolute_url(self):
        st = time.strftime(self.starttime,"%X")
        et = time.strftime(self.endtime,"%X")
        date = datetime.strftime(self.date,"%Y-%m-%d")
        str = ""
        str = str + '/schedule/' + self.wid.id+ '/'+date + '/' + st + '/' + et
        print (str)
        return str
