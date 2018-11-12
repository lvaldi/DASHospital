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
    appointmentid = models.ForeignKey('Appointment', models.DO_NOTHING, db_column='AppointmentID')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Books'
        unique_together = (('fid', 'appointmentid'),)


class Appointment(models.Model):
    appointmentid = models.AutoField(primary_key=True)
    date = models.DateField()
    time = models.TimeField()
    pid = models.ForeignKey('Patient', models.DO_NOTHING, db_column='pid')
    did = models.ForeignKey('Doctor', models.DO_NOTHING, db_column='did')

    class Meta:
        managed = False
        db_table = 'appointment'
        unique_together = (('appointmentid', 'pid', 'did'),)


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=80)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.BooleanField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.BooleanField()
    is_active = models.BooleanField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class Contains(models.Model):
    prescriptionid = models.ForeignKey('Prescription', models.DO_NOTHING, db_column='prescriptionid', primary_key=True)
    din = models.ForeignKey('Medicine', models.DO_NOTHING, db_column='din')

    class Meta:
        managed = False
        db_table = 'contains'
        unique_together = (('prescriptionid', 'din'),)


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.SmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


class Doctor(models.Model):
    id = models.ForeignKey('Staff', models.DO_NOTHING, db_column='id', primary_key=True)
    availableforemergency = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'doctor'


class Facility(models.Model):
    id = models.CharField(primary_key=True, max_length=8)
    type = models.CharField(max_length=20)

    class Meta:
        managed = False
        db_table = 'facility'


class Generalpracticioner(models.Model):
    id = models.ForeignKey(Doctor, models.DO_NOTHING, db_column='id', primary_key=True)

    class Meta:
        managed = False
        db_table = 'generalpracticioner'


class LabTechnician(models.Model):
    id = models.ForeignKey('Staff', models.DO_NOTHING, db_column='id', primary_key=True)
    fid = models.ForeignKey(Facility, models.DO_NOTHING, db_column='fid')

    class Meta:
        managed = False
        db_table = 'lab_technician'
        unique_together = (('id', 'fid'),)


class Medicine(models.Model):
    din = models.CharField(primary_key=True, max_length=8)
    brand = models.CharField(max_length=20)
    ingredients = models.CharField(max_length=20, blank=True, null=True)
    sideeffect = models.CharField(max_length=80, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'medicine'


class Nurse(models.Model):
    id = models.ForeignKey('Staff', models.DO_NOTHING, db_column='id', primary_key=True)
    did = models.ForeignKey(Doctor, models.DO_NOTHING, db_column='did')

    class Meta:
        managed = False
        db_table = 'nurse'
        unique_together = (('id', 'did'),)


class Patient(models.Model):
    email = models.CharField(max_length=30)
    name = models.CharField(max_length=20)
    healthcard = models.CharField(max_length=20)
    phone = models.CharField(max_length=13, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'patient'


class Prescription(models.Model):
    prescriptionid = models.AutoField(primary_key=True)
    instruction = models.CharField(max_length=30, blank=True, null=True)
    substitutable = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'prescription'


class ScheduledTime(models.Model):
    date = models.DateField(primary_key=True)
    starttime = models.TimeField()
    endtime = models.TimeField()
    wid = models.ForeignKey('Weeklyschedule', models.DO_NOTHING, db_column='wid')
    notes = models.CharField(max_length=60, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'scheduled_time'
        unique_together = (('date', 'starttime', 'endtime', 'wid'),)


class Specialist(models.Model):
    id = models.ForeignKey(Doctor, models.DO_NOTHING, db_column='id', primary_key=True)
    specialization = models.CharField(max_length=20, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'specialist'


class Staff(models.Model):
    email = models.CharField(max_length=30)
    name = models.CharField(max_length=20)
    license = models.CharField(max_length=8)
    phone = models.CharField(max_length=13, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'staff'


class Treats(models.Model):
    did = models.ForeignKey(Doctor, models.DO_NOTHING, db_column='did', primary_key=True)
    pid = models.ForeignKey(Patient, models.DO_NOTHING, db_column='pid')
    prescriptionid = models.ForeignKey(Prescription, models.DO_NOTHING, db_column='prescriptionid')

    class Meta:
        managed = False
        db_table = 'treats'
        unique_together = (('did', 'pid', 'prescriptionid'),)


class Weeklyschedule(models.Model):
    id = models.CharField(primary_key=True, max_length=8)
    sid = models.ForeignKey(Staff, models.DO_NOTHING, db_column='sid', unique=True)

    class Meta:
        managed = False
        db_table = 'weeklyschedule'