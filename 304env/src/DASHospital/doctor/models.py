# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey has `on_delete` set to the desired behavior.
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Books(models.Model):
    fid = models.ForeignKey('Facility', models.DO_NOTHING, db_column='FID', primary_key=True)  # Field name made lowercase.
    appointmentid = models.ForeignKey('Appointment', models.DO_NOTHING, db_column='AppointmentID', null=False)  # Field name made lowercase.


    class Meta:
        managed = False
        db_table = 'books'
        unique_together = (('fid', 'appointmentid'),)


class Appointment(models.Model):
    appointmentid = models.AutoField(db_column='appointmentid', primary_key=True, max_length=8)
    date = models.DateField(db_column='date')
    time = models.TimeField(db_column='time')
    pid = models.ForeignKey('Patient', models.CASCADE, db_column='pid')
    did = models.ForeignKey('Doctor', models.CASCADE, db_column='did')

    class Meta:
        managed = False
        db_table = 'appointment'


class Contains(models.Model):
    prescriptionid = models.ForeignKey('Prescription', models.DO_NOTHING, db_column='prescriptionid', primary_key=True)
    din = models.ForeignKey('Medicine', models.DO_NOTHING, db_column='din', null=False)

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
    id = models.ForeignKey('Staff', models.DO_NOTHING, db_column='id', primary_key=True)
    fid = models.ForeignKey('Facility', models.DO_NOTHING, db_column='fid', unique=True)

    class Meta:
        managed = False
        db_table = 'lab_technician'
        unique_together = (('id', 'fid'),)


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


class Patient(models.Model):
    id = models.AutoField(db_column='id',primary_key=True)
    email = models.CharField(db_column='email', max_length=30, null=False)
    name = models.CharField(db_column='name', max_length=20, null=False)
    healthcard = models.CharField(db_column='healthcard', max_length=20, null=False)
    phone = models.CharField(db_column='phone', max_length=13, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'patient'


class Prescription(models.Model):
    prescriptionid = models.AutoField(db_column='prescriptionid', primary_key=True)
    instruction = models.CharField(db_column='instruction', max_length=30, blank=True, null=True)
    substitutable = models.BooleanField(db_column='substitutable', blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'prescription'


class ScheduledTime(models.Model):
    date = models.DateField(db_column='date', primary_key=True)
    starttime = models.TimeField(db_column='starttime', null=False)
    endtime = models.TimeField(db_column='endtime', null=False)
    wid = models.ForeignKey('Weeklyschedule', models.CASCADE, db_column='wid')
    notes = models.CharField(db_column='notes', max_length=60, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'scheduled_time'
        unique_together = (('date', 'starttime', 'endtime', 'wid'),)


class Specialist(models.Model):
    id = models.ForeignKey('Doctor', models.CASCADE, db_column='id', primary_key=True)
    specialization = models.CharField(max_length=20, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'specialist'


class Staff(models.Model):
    id = models.AutoField(db_column='id', primary_key=True)
    email = models.CharField(db_column='email', max_length=30, null=False)
    name = models.CharField(db_column='name', max_length=20, null=False)
    license = models.CharField(db_column='license', max_length=8, null=False)
    phone = models.CharField(db_column='phone', max_length=13, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'staff'


class Treats(models.Model):
    did = models.ForeignKey('Doctor', models.DO_NOTHING, db_column='did', primary_key=True)
    pid = models.ForeignKey('Patient', models.DO_NOTHING, db_column='pid', null=False)
    prescriptionid = models.ForeignKey('Prescription', models.DO_NOTHING, db_column='prescriptionid', null=False)

    class Meta:
        managed = False
        db_table = 'treats'
        unique_together = (('did', 'pid', 'prescriptionid'),)


class Weeklyschedule(models.Model):
    id = models.CharField(db_column='id', primary_key=True, max_length=8)
    sid = models.ForeignKey('Staff', models.CASCADE, db_column='sid', unique=True)

    class Meta:
        managed = False
        db_table = 'weeklyschedule'
