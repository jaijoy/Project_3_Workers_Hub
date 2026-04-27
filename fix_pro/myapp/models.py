from django.db import models
from django.contrib.auth.models import User
# Create your models here.


class worker_Tbl(models.Model):
    LOGIN=models.ForeignKey(User, on_delete=models.CASCADE)
    name=models.CharField(max_length=20)
    email=models.CharField(max_length=50)
    dob=models.DateField()
    gender=models.CharField(max_length=50)
    phone=models.BigIntegerField()
    address=models.CharField(max_length=100)
    photo=models.ImageField()
    proof=models.FileField()
    status=models.CharField(max_length=100)

class user_Tbl(models.Model):
    LOGIN = models.ForeignKey(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=50)
    dob=models.DateField(default=0)
    gender=models.CharField(max_length=20,default=0)
    email = models.CharField(max_length=50)
    phone = models.BigIntegerField()
    place = models.CharField(max_length=50)
    post = models.CharField(max_length=50)
    pin = models.CharField(max_length=50)
    district = models.CharField(max_length=50)
    photo = models.ImageField()

class skill_Tbl(models.Model):
    skill_name = models.CharField(max_length=100)
    discription = models.CharField(max_length=500)
    WORKER = models.ForeignKey(worker_Tbl, on_delete=models.CASCADE)

class feedback(models.Model):
    date = models.DateField()
    feedback = models.CharField(max_length=500)
        # rating = models.CharField(max_length=50)
    USER = models.ForeignKey(user_Tbl, on_delete=models.CASCADE)

class complaint_Tbll(models.Model):
    date=models.DateField()
    complaint=models.CharField(max_length=500)
    reply=models.CharField(max_length=500)
    status=models.CharField(max_length=50)
    type = models.CharField(max_length=50)
    LOGIN = models.ForeignKey(User, on_delete=models.CASCADE)


class book(models.Model):
    date = models.DateField()
    USER = models.ForeignKey(user_Tbl, on_delete=models.CASCADE)
    SKILL = models.ForeignKey(skill_Tbl, on_delete=models.CASCADE)
    status = models.CharField(max_length=50)
    work_status = models.CharField(max_length=50)

class Review(models.Model):
    user = models.ForeignKey(user_Tbl, on_delete=models.CASCADE)
    book = models.ForeignKey(book, on_delete=models.CASCADE)
    rating = models.CharField(max_length=50)
    comment = models.CharField(max_length=50)
    date = models.DateField()

class payment_Tbl(models.Model):
    date=models.DateField()
    amount=models.BigIntegerField()
    status=models.CharField(max_length=50)
    BOOK=models.ForeignKey(book, on_delete= models.CASCADE)
    USER=models.ForeignKey(user_Tbl, on_delete= models.CASCADE)

class chat(models.Model):
    FROM_ID=models.ForeignKey(User,on_delete=models.CASCADE ,related_name='FROM_ID')
    TO_ID=models.ForeignKey(User,on_delete=models.CASCADE , related_name='TO_ID')
    date = models.DateField()
    # time = models.TimeField()
    message = models.CharField(max_length=50)



        # class book(models.Model):
#     SKILL

#     USER
#     status 
#     date