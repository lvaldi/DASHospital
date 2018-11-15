from django.db import models
from django.urls import reverse
from datetime import datetime, time

# Create your models here.
class Patient(models.Model):
    id = models.AutoField(db_column='id',primary_key=True)
    email = models.CharField(db_column='email', max_length=30, null=False)
    name = models.CharField(db_column='name', max_length=20, null=False)
    healthcard = models.CharField(db_column='healthcard', max_length=20, null=False)
    phone = models.CharField(db_column='phone', max_length=13, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'patient'

    def get_absolute_url(self):
        strn = ""
        strn = strn + '/Patient/' + str(self.id)
        print (strn)
        return strn
