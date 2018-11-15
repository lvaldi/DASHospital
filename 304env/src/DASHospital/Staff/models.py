from django.db import models
from Patient.models import Patient
from WeeklySchedule import *

# Create your models here.

class Staff(models.Model):
    id = models.AutoField(db_column='id', primary_key=True)
    email = models.CharField(db_column='email', max_length=30, null=False)
    name = models.CharField(db_column='name', max_length=20, null=False)
    license = models.CharField(db_column='license', max_length=8, null=False)
    phone = models.CharField(db_column='phone', max_length=13, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'staff'

class Contains(models.Model):
    prescriptionid = models.ForeignKey('Prescription', models.CASCADE, db_column='prescriptionid', primary_key=True)
    din = models.ForeignKey('Medicine', models.CASCADE, db_column='din', null=False)

    class Meta:
        managed = False
        db_table = 'contains'
        unique_together = (('prescriptionid', 'din'),)


class Doctor(models.Model):
    id = models.ForeignKey('Staff', models.CASCADE, db_column='id', primary_key=True)
    availableforemergency = models.BooleanField(db_column='availableforemergency', null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'doctor'


class Facility(models.Model):
    id = models.CharField(db_column='id', primary_key=True, max_length=8)
    type = models.CharField(db_column='type' ,max_length=20, null=False)

    class Meta:
        managed = False
        db_table = 'facility'


class Generalpracticioner(models.Model):
    id = models.ForeignKey('Doctor', models.CASCADE, db_column='id', primary_key=True)

    class Meta:
        managed = False
        db_table = 'generalpracticioner'


class LabTechnician(models.Model):
    id = models.ForeignKey('Staff', models.CASCADE, db_column='id', primary_key=True)
    fid = models.ForeignKey('Facility', models.CASCADE, db_column='fid')

    class Meta:
        managed = False
        db_table = 'lab_technician'
        # unique_together = (('id', 'fid'),)


class Medicine(models.Model):
    din = models.CharField(db_column='din', primary_key=True, max_length=8)
    brand = models.CharField(db_column='brand', max_length=20, null=False)
    ingredients = models.CharField(db_column='ingredients', max_length=20, blank=True, null=True)
    sideeffect = models.CharField(db_column='sideeffects', max_length=80, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'medicine'


class Nurse(models.Model):
    id = models.ForeignKey('Staff', models.CASCADE, db_column='id', primary_key=True)
    did = models.ForeignKey('Doctor', models.CASCADE, db_column='did', null=False)

    class Meta:
        managed = False
        db_table = 'nurse'
        unique_together = (('id', 'did'),)





class Prescription(models.Model):
    prescriptionid = models.AutoField(db_column='prescriptionid', primary_key=True)
    instruction = models.CharField(db_column='instruction', max_length=30, blank=True, null=True)
    substitutable = models.BooleanField(db_column='substitutable', blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'prescription'




class Specialist(models.Model):
    id = models.ForeignKey('Doctor', models.CASCADE, db_column='id', primary_key=True)
    specialization = models.CharField(max_length=20, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'specialist'





class Treats(models.Model):
    did = models.ForeignKey('Doctor', models.CASCADE, db_column='did', primary_key=True)
    pid = models.ForeignKey(Patient, models.CASCADE, db_column='pid', null=False)
    prescriptionid = models.ForeignKey('Prescription', models.CASCADE, db_column='prescriptionid', null=False)

    class Meta:
        managed = False
        db_table = 'treats'
        unique_together = (('did', 'pid', 'prescriptionid'),)


class Appointment(models.Model):
    appointmentid = models.AutoField(db_column='appointmentid', primary_key=True, max_length=8)
    date = models.DateField(db_column='date')
    time = models.TimeField(db_column='time')
    pid = models.ForeignKey(Patient, models.CASCADE, db_column='pid')
    did = models.ForeignKey('Doctor', models.CASCADE, db_column='did')

    class Meta:
        managed = False
        db_table = 'appointment'

class Books(models.Model):
    fid = models.ForeignKey('Facility', models.CASCADE, db_column='FID', primary_key=True)  # Field name made lowercase.
    appointmentid = models.ForeignKey('Appointment', models.CASCADE, db_column='AppointmentID', null=False)  # Field name made lowercase.


    class Meta:
        managed = False
        db_table = 'Books'
        unique_together = (('fid', 'appointmentid'),)

