import datetime
import random
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

from django.contrib import messages
from django.contrib.auth import logout, authenticate, login
from django.contrib.auth.decorators import login_required
from django.contrib.auth.hashers import make_password, check_password
from django.core.files.storage import FileSystemStorage
from django.db.models import Q
from django.http import JsonResponse
from django.shortcuts import render, redirect
from django.contrib.auth.models import User, Group


# Create your views here.
from myapp.models import *


def logoutss(request):
    logout(request)
    return redirect('/myapp/login_page')

def login_page(request):
    return render(request, 'login.html')

def login_page_POST(request):
    username=request.POST["username"]
    passwd=request.POST["pass"]

    user= authenticate(username=username, password=passwd)

    if user is not None :
        if user.groups.filter(name="Admin"):
            login(request,user)
            return redirect("/myapp/admin_index/")

        elif user.groups.filter(name="Worker"):
            ob=worker_Tbl.objects.get(LOGIN_id=user.id)
            if ob.status=="Approved":
                login(request,user)
                return redirect("/myapp/worker_index/")
            else:
                messages.warning(request, "You got rejected!!")
                return redirect("/myapp/login_page/")

        else:
            messages.warning(request, "Invalid Username and Password")
            return redirect("/myapp/login_page/")
    else:
        messages.warning(request, "Invalid Username and Password")
        return redirect("/myapp/login_page/")


@login_required(login_url='/myapp/login_page')
def admin_index(request):
    return render(request, 'Admin/admin_index.html')


@login_required(login_url='/myapp/login_page')
def admin_worker_view(request):
    data=worker_Tbl.objects.all()
    return render(request, 'Admin/worker_verify.html' ,{'data':data})

@login_required(login_url='/myapp/login_page')
def admin_worker_approve(request,id):
    obj=worker_Tbl.objects.get(id=id)
    obj.status="Approved"
    obj.save()
    return redirect('/myapp/admin_worker_view/#a')

@login_required(login_url='/myapp/login_page')
def admin_worker_reject(request,id):
    obj = worker_Tbl.objects.get(id=id)
    obj.status = "Rejected"
    obj.save()
    return redirect('/myapp/admin_worker_view/#a')

@login_required(login_url='/myapp/login_page')
def admin_worker_approved_view(request):
    data=worker_Tbl.objects.filter(status="Approved")
    return render(request,'Admin/worker_approved_view.html',{'data':data})

@login_required(login_url='/myapp/login_page')
def i_changepassword(request):
    return render(request, 'Admin/change_password.html')

@login_required(login_url='/myapp/login_page')
def i_changepassword_post(request):
    currentpassword = request.POST["currentpassword"]
    newpassword = request.POST["newpassword"]
    confirmpassword = request.POST["confirmpassword"]
    user = request.user
    print("wwwwwwwwwwwwwwwwwwwwww")
    if check_password(currentpassword, user.password):
        if newpassword == confirmpassword:
            user.set_password(newpassword)
            user.save()
            logout(request)
            messages.success(request, "Password changed successfully. Please log in again.")
            return redirect('/myapp/login_page/')
        else:
            messages.warning(request, "New password and confirm password do not match.")
            return redirect('/myapp/i_changepassword/')
    else:
        messages.warning(request, "Current password is incorrect.")
        return redirect('/myapp/i_changepassword/')

@login_required(login_url='/myapp/login_page')
def admin_feedback(request):
        data = feedback.objects.all()
        return render(request, 'Admin/feedback.html', {'data': data})

@login_required(login_url='/myapp/login_page')
def admin_complaints_user(request):
    obj=complaint_Tbll.objects.filter(type="Customer")

    return render(request, 'Admin/complaints.html',{'data':obj})

@login_required(login_url='/myapp/login_page')
def admin_replay_complaint(request):
    id=request.POST["complaint_id"]
    reply=request.POST["reply"]
    obj = complaint_Tbll.objects.get(id=id)
    obj.reply=reply
    obj.save()
    return redirect('/myapp/admin_complaints_user/#a')





@login_required(login_url='/myapp/login_page')
def admin_complaints_worker(request):
    obj=complaint_Tbll.objects.filter(type="Worker")
    return render(request, 'Admin/worker_complaints.html',{'data':obj})

@login_required(login_url='/myapp/login_page')
def admin_replay_complaint_worker(request):
    id=request.POST["complaint_id"]
    reply=request.POST["reply"]
    obj = complaint_Tbll.objects.get(id=id)
    obj.reply=reply
    obj.save()
    return redirect('/myapp/admin_complaints_worker/#a')


















#****************************workerr*************************************8



def worker_registration(request):
    name=request.POST["name"]
    email=request.POST["gmail"]
    dob=request.POST["dob"]
    gender=request.POST["gender"]
    address=request.POST["address"]
    phone=request.POST["phone"]
    proof=request.FILES["proof"]
    photo=request.FILES["photo"]
    username=request.POST["username"]
    password=request.POST["password"]

    fs = FileSystemStorage()
    img = fs.save(photo.name, photo)
    prooff = fs.save(proof.name, proof)

    if User.objects.filter(Q(username=username)|Q(email=email)).exists():
        return JsonResponse({'status': 'Not ok'})

    user = User.objects.create(
        username=username,
        password=make_password(password),
        first_name=name,
        email=email

    )
    user.groups.add(Group.objects.get(name='Worker'))

    obj = worker_Tbl()
    obj.name=name
    obj.email=email
    obj.dob=dob
    obj.phone=phone
    obj.gender=gender
    obj.address=address
    obj.photo=img
    obj.proof=prooff
    obj.LOGIN=user
    obj.status="Pending"
    obj.save()
    return JsonResponse({'status': 'ok', 'lid': str(user.id), 'type': 'Worker'})


def android_login(request):
    username = request.POST['username']
    password = request.POST['password']
    print(request.POST,'data-----')
    user = authenticate(request, username=username, password=password)
    if user is not None:
        if user.groups.filter(name="Worker").exists():
            free=worker_Tbl.objects.get(LOGIN_id=user.id)
            if free.status == 'Approved':
                return JsonResponse({'status':'ok',
                'lid':str(user.id),
                'name': free.name,
                'email': free.email,
                'photo':free.photo.url,
                'type':str('Worker') })



            else :
                return JsonResponse({'status':'not ok'})

        elif user.groups.filter(name="Customer").exists():
            free=user_Tbl.objects.get(LOGIN_id=user.id)
            return JsonResponse({'status':'ok',
                'lid':str(user.id),
                'name': free.name,
                'email': free.email,
                'photo':free.photo.url,
                'type':str('Customer') })
        else:
            return JsonResponse({'status': 'not ok'})
    else :
         return JsonResponse({'status': 'not ok'})



def worker_complaint(request):
    complaint = request.POST["complaint"]
    login_id=request.POST["lid"]

    user=worker_Tbl.objects.get(LOGIN=login_id)
    obj=complaint_Tbll()
    obj.LOGIN=user.LOGIN
    obj.type="Worker"
    obj.complaint=complaint
    obj.date = datetime.datetime.now().today().date()
    obj.reply="pending"

    obj.save()
    return JsonResponse({'status': 'ok'})

def worker_complaint_view(request):
    login_id = request.POST["lid"]
    user = worker_Tbl.objects.get(LOGIN=login_id)
    data = complaint_Tbll.objects.filter(LOGIN=user.LOGIN)
    l=[]
    for i in data:
        l.append({
            'id': str(i.id),
            'date': str(i.date),
            'complaint': str(i.complaint),
            'reply':str(i.reply)
            })

    return JsonResponse({'status': 'ok','data':l})


def worker_skill_add(request):
    lid=request.POST["lid"]
    skill_name=request.POST["skill_name"]
    discription=request.POST["discription"]

    worker=worker_Tbl.objects.get(LOGIN=lid)

    obj=skill_Tbl()
    obj.skill_name=skill_name
    obj.discription=discription
    obj.WORKER=worker
    obj.save()
    return JsonResponse({'status':'ok'})



def worker_skill_view(request):
    lid = request.POST['lid']
    worker = worker_Tbl.objects.get(LOGIN=lid)
    data = skill_Tbl.objects.filter(WORKER=worker)
    res = []
    for i in data:
        res.append({
            'id': i.id,
            'skill_name': i.skill_name,
            'discription': i.discription
        })
    return JsonResponse({'status': 'ok', 'data': res})


def worker_skill_delete(request):
    sid = request.POST['sid']
    skill_Tbl.objects.get(id=sid).delete()
    return JsonResponse({'status': 'ok'})


def worker_skill_edit(request):
    sid = request.POST['sid']
    skill_name = request.POST['skill_name']
    discription = request.POST['discription']

    obj = skill_Tbl.objects.get(id=sid)
    obj.skill_name = skill_name
    obj.discription = discription
    obj.save()
    return JsonResponse({'status': 'ok'})



# def worker_view_booking_request(request):
#     lid = request.POST['lid']
#
#     worker = worker_Tbl.objects.get(LOGIN=lid)
#
#     bookings = book.objects.filter(
#         SKILL__WORKER=worker
#     )
#
#     l = []
#     for b in bookings:
#         l.append({
#             'book_id': str(b.id),
#             'skill_name': b.SKILL.skill_name,
#             'user_name': b.USER.name,
#             'user_id':str(b.USER.LOGIN.id),
#             'user_photo': b.USER.photo.url,   # ✅ ADD THIS
#             'date': str(b.date),
#             'status': b.status,
#         })
#
#     return JsonResponse({'status': 'ok', 'data': l})


# def worker_update_booking_status(request):
#     book_id = request.POST['book_id']
#     status = request.POST['status']  # approved / rejected
#
#     b = book.objects.get(id=book_id)
#     b.status = status
#     b.save()
#
#     return JsonResponse({'status': 'ok'})



from django.http import JsonResponse
from .models import book, worker_Tbl

# ================= WORKER VIEW BOOKINGS =================
def worker_view_booking_request(request):
    lid = request.POST.get('lid')

    # try:
    worker = worker_Tbl.objects.get(LOGIN_id=lid)
    # except worker_Tbl.DoesNotExist:
    #     return JsonResponse({'status': 'error', 'message': 'Worker not found'})

    bookings = book.objects.filter(SKILL__WORKER=worker)

    data = []
    for b in bookings:
        data.append({
            'book_id': str(b.id),
            'skill_name': b.SKILL.skill_name,
            'user_name': b.USER.name,
            'user_id': str(b.USER.LOGIN.id),
            'user_photo': b.USER.photo.url,
            'date': str(b.date.strftime("%Y-%m-%d")),
            'status': b.status,
            'work_status': b.work_status,
        })

    return JsonResponse({'status': 'ok', 'data': data})


def worker_view_rating(request):
    lid = request.POST.get('lid')
    worker = worker_Tbl.objects.get(LOGIN_id=lid)
    data=Review.objects.filter(book__SKILL__WORKER=worker)

    l=[]
    for r in data:
        l.append({
            'rating':str(r.rating),
            'user':str(r.user.name),
            'email':str(r.user.email),
            'photo':str(r.user.photo.url),
            'review':str(r.comment),
            'date':str(r.date),
            'skill_name':str(r.book.SKILL.skill_name)
        })
    return JsonResponse({'status': 'ok', 'data': l})


# ================= APPROVE / REJECT =================
def worker_update_booking_status(request):
    book_id = request.POST['book_id']
    status = request.POST['status']

    print(status)
    print(request.POST,'================')
    print(request.POST,'================')
    print(request.POST,'================')
    print(request.POST,'================')

    # b = book.objects.get(id=book_id)
    # b.work_status = status
    # b.save()

    b = book.objects.filter(id=book_id).update(status = status)

    return JsonResponse({'status': 'ok'})







# ================= UPDATE WORK STATUS =================


# def worker_view_booking_request_status(request):
#     lid = request.POST.get('lid')
#     worker = worker_Tbl.objects.get(LOGIN_id=lid)
#
#     bookings = book.objects.filter(
#         SKILL__WORKER=worker,
#         status__in=["approved", "paid"]
#     )
#     data = []
#     for b in bookings:
#         data.append({
#             'book_id': b.id,
#             'skill_name': b.SKILL.skill_name,
#             'user_name': b.USER.name,
#             'user_id': b.USER.LOGIN.id,
#             'user_photo': b.USER.photo.url,
#             'date': b.date.strftime("%Y-%m-%d"),
#             'status': b.status,
#             'work_status': b.work_status,
#         })
#
#     return JsonResponse({'status': 'ok', 'data': data})


def worker_view_booking_request_status(request):
    lid = request.POST.get('lid')

    worker = worker_Tbl.objects.get(LOGIN_id=lid)

    bookings = book.objects.filter(
        SKILL__WORKER=worker,
        status__in=["approved", "paid"]
    )

    data = []
    for b in bookings:
        payment_data = None

        if b.status == "paid":
                payment = payment_Tbl.objects.get(BOOK=b)
                payment_data = {
                    'amount': str(payment.amount),
                    'payment_date': str(payment.date),
                    'payment_status': str(payment.status),
                }
        data.append({
            'book_id': b.id,
            'skill_name': b.SKILL.skill_name,
            'user_name': b.USER.name,
            'user_id': str(b.USER.LOGIN.id),
            'user_photo': b.USER.photo.url,
            'date': b.date.strftime("%Y-%m-%d"),
            'status': b.status,
            'work_status': b.work_status,
            'payment': payment_data,
        })

        print(data,'data===========')
        print(data,'data===========')
        print(data,'data===========')
        print(data,'data===========')

    return JsonResponse({'status': 'ok', 'data': data})

def worker_update_work_status(request):
    book_id = request.POST.get('book_id')
    work_status = request.POST.get('work_status')
    print(work_status)
    b = book.objects.get(id=book_id)
    b.work_status = work_status
    b.save()
    return JsonResponse({'status': 'ok'})




def worker_view_profile(request):
    lid = request.POST.get("lid")

    data = worker_Tbl.objects.get(LOGIN_id=lid)

    l = []
    l.append({
        'name': data.name,
        'email': data.email,
        'dob': str(data.dob),
        'gender': data.gender,
        'phone': str(data.phone),
        'address': data.address,
        'photo': data.photo.url if data.photo else "",
        'proof': str(data.proof.url if data.proof else ""),
        'status': data.status
    })

    return JsonResponse({'status': 'ok', 'data': l})



#-----------------------user-------------------

def user_registration(request):
    name=request.POST["name"]
    email=request.POST["email"]
    gender=request.POST["gender"]
    phone=request.POST["phone"]
    dob = request.POST["dob"]
    place = request.POST["place"]
    post = request.POST["post"]
    pin = request.POST["pin"]
    district = request.POST["district"]

    photo=request.FILES["photo"]
    fs = FileSystemStorage()
    img = fs.save(photo.name, photo)

    username = request.POST["username"]
    password = request.POST["password"]

    if User.objects.filter(Q(username=username)|Q(email=email)).exists():
        return JsonResponse({'status': 'Not ok'})

    user = User.objects.create(username=username, password=make_password(password), first_name=name, email=email)
    user.save()
    user.groups.add(Group.objects.get(name='Customer'))
    obj=user_Tbl()
    obj.LOGIN=user
    obj.name=name
    obj.email=email
    obj.photo=img
    obj.gender=gender
    obj.phone=phone
    obj.dob=dob
    obj.place=place
    obj.post=post
    obj.pin=pin
    obj.district=district
    obj.save()
    return JsonResponse({'status': 'ok', 'lid': str(user.id), 'type': 'Customer'})


def user_view_worker(request):
    data = worker_Tbl.objects.all()
    l = []

    for i in data:
        l.append({
            'worker_id': str(i.id),
            'name': str(i.name),
            'email': str(i.email),
            'gender': str(i.gender),
            'phone': str(i.phone),
            'address': str(i.address),
            'photo': str(i.photo.url),
        })

    return JsonResponse({'status': 'ok', 'data':l})



def user_view_worker_skill(request):
    wid = request.POST['wid']
    lid = request.POST.get('lid')   # logged-in user id

    skills = skill_Tbl.objects.filter(WORKER_id=wid)
    user = user_Tbl.objects.get(LOGIN=lid)

    data = []

    for s in skills:
        already_booked = book.objects.filter(
            USER=user,
            SKILL=s
        ).exists()

        data.append({
            'skill_id': str(s.id),
            'skill_name': s.skill_name,
            'discription': s.discription,
            'booked': already_booked   # 🔑 IMPORTANT
        })

    return JsonResponse({'status': 'ok', 'data': data})



def user_view_all_skill(request):
    # wid = request.POST['wid']
    lid = request.POST.get('lid')   # logged-in user id

    skills = skill_Tbl.objects.all()
    user = user_Tbl.objects.get(LOGIN=lid)

    data = []

    for s in skills:
        already_booked = book.objects.filter(
            USER=user,
            SKILL=s
        ).exists()

        data.append({
            'skill_id': str(s.id),
            'worker_name': str(s.WORKER.name),
            'worker_email': str(s.WORKER.email),
            'skill_name': str(s.skill_name),
            'discription': str(s.discription) ,
            'booked': already_booked
        })

    return JsonResponse({'status': 'ok', 'data': data})

def user_book_skill(request):
    lid = request.POST['lid']
    skill_id = request.POST['skill_id']

    user = user_Tbl.objects.get(LOGIN=lid)
    skill = skill_Tbl.objects.get(id=skill_id)

    if book.objects.filter(USER=user, SKILL=skill).exists():
        return JsonResponse({'status': 'exists'})

    book.objects.create(
        USER=user,
        SKILL=skill,
        date=datetime.date.today(),
        status='pending',
        work_status='pending'
    )

    return JsonResponse({'status': 'ok'})



def user_view_booking_status(request):
    lid = request.POST['lid']

    user = user_Tbl.objects.get(LOGIN=lid)
    bookings = book.objects.filter(USER=user).order_by('-date')

    l = []
    for b in bookings:
        l.append({
            'booking_id': b.id,
            'skill_name': b.SKILL.skill_name,
            'worker_name': b.SKILL.WORKER.name,
            'worker_login_id': str(b.SKILL.WORKER.LOGIN.id),

            'worker_photo': b.SKILL.WORKER.photo.url,
            'date': str(b.date),
            'status': b.status,               # approved / rejected
            'work_status': b.work_status or 'pending',
        })

    return JsonResponse({'status': 'ok', 'data': l})




def payment(request):
    try:
        oid = request.POST['booking_id']  # This should now be the main order ID
        lid = request.POST['lid']
        user=user_Tbl.objects.get(LOGIN=lid)
        amount = request.POST['amount']
        print(oid, lid, '===========')

        b = book.objects.get(id=oid)
        b.status="paid"
        b.save()


        payment_record = payment_Tbl(
            BOOK=b,
            USER=user,
            amount=amount,
            date=datetime.datetime.now().today(),
            status='paid',
        )
        payment_record.save()

        return JsonResponse({'status': 'ok'})

    except user_Tbl.DoesNotExist:
        return JsonResponse({'status': 'error', 'message': 'User not found'})
    except Exception as e:
        print(f"Payment error: {e}")
        return JsonResponse({'status': 'error', 'message': 'Payment failed'})



def user_complaint(request):
    complaint = request.POST["complaint"]
    login_id=request.POST["lid"]
    user=user_Tbl.objects.get(LOGIN=login_id)
    obj=complaint_Tbll()
    obj.LOGIN=user.LOGIN
    obj.type="Customer"
    obj.complaint=complaint
    obj.date = datetime.datetime.now().today().date()
    obj.reply="pending"

    obj.save()
    return JsonResponse({'status': 'ok'})


def user_complaint_view(request):
    login_id = request.POST["lid"]

    user = user_Tbl.objects.get(LOGIN=login_id)
    data = complaint_Tbll.objects.filter(LOGIN=user.LOGIN)
    l = []
    for i in data:
        l.append({
            'id': i.id,
            'date': str(i.date),
            'complaint': str(i.complaint),
            'reply': str(i.reply)
        })

    return JsonResponse({'status': 'ok', 'data': l})



def user_rating(request):
        lidd = request.POST["lid"]
        review = request.POST["review"]
        rating = request.POST["rating"]
        dates = datetime.datetime.now()
        item_id = request.POST["book_id"]

        user = user_Tbl.objects.get(LOGIN=lidd)
        item = book.objects.get(id=item_id)

        existing = Review.objects.filter(user=user, book=item).first()

        if existing:
            existing.comment = review
            existing.rating = rating
            existing.date = dates
            existing.save()
            return JsonResponse({'status': 'updated'})
        else:
            obj = Review()
            obj.date = dates
            obj.comment = review
            obj.rating = rating
            obj.book = item
            obj.user = user
            obj.save()
            return JsonResponse({'status': 'ok'})

def user_feedback(request):
            lid = request.POST["lid"]
            user = user_Tbl.objects.get(LOGIN=lid)
            fk = request.POST["feedback"]

            old_fb = feedback.objects.filter(USER=user).first()

            if old_fb:
                old_fb.feedback = fk
                old_fb.date = datetime.datetime.now().today()
                old_fb.save()
            else:
                obj = feedback()
                obj.feedback = fk
                obj.date = datetime.datetime.now().today()
                obj.USER = user
                obj.save()
            return JsonResponse({'status': 'ok'})


#--------------------------------------------------
def user_chat_send(request):

    from_id = request.POST.get("from_id")  # match Flutter
    to_id = request.POST.get("to_id")      # match Flutter

    print(from_id,"--------------------------------------------------------")
    print(to_id,"--------------------------------------------------------")
    message = request.POST.get("message")

    import datetime
    d = datetime.datetime.now().date()
    t = datetime.datetime.now().time()
    chatobt = chat()
    chatobt.message = message
    chatobt.TO_ID_id = to_id
    chatobt.FROM_ID_id = from_id
    chatobt.date = d
    # chatobt.time = t
    chatobt.save()

    return JsonResponse({"status": "ok"})




def chat_view_user(request):
    from_id = request.POST.get("from_id")
    to_id = request.POST.get("to_id")


    print(from_id,'from_id=============')
    print(from_id,'from_id=============')
    print(to_id,'to_id============')
    print(to_id,'to_id============')
    print(to_id,'to_id============')
    print(to_id,'to_id============')

    res = chat.objects.filter(
        Q(FROM_ID_id=from_id, TO_ID_id=to_id) | Q(FROM_ID_id=to_id, TO_ID_id=from_id)
    )
    l = []
    for i in res:
        l.append({
            "id": i.id,
            "msg": str(i.message),
            "to": i.TO_ID.id,
            "date": str(i.date),
            "from": i.FROM_ID.id,
        })

    print(l)

    return JsonResponse({"data": l, 'toid': to_id,'status':'ok'})






def worker_chat_send(request):
    from_id = request.POST.get("from_id")  # match Flutter
    to_id = request.POST.get("to_id")      # match Flutter
    message = request.POST.get("message")
    print(from_id,'==========')
    print(to_id,'==========')
    import datetime
    d = datetime.datetime.now().date()
    t = datetime.datetime.now().time()
    chatobt = chat()
    chatobt.message = message
    chatobt.TO_ID_id = to_id
    chatobt.FROM_ID_id = from_id
    chatobt.date = d
    # chatobt.time = t
    chatobt.save()

    return JsonResponse({"status": "ok"})

def chat_view_worker(request):
    from_id = request.POST.get("from_id")
    to_id = request.POST.get("to_id")
    res = chat.objects.filter(
        Q(FROM_ID_id=from_id, TO_ID_id=to_id) | Q(FROM_ID_id=to_id, TO_ID_id=from_id)
    )
    l = []
    for i in res:
        l.append({
            "id": str(i.id),
            "msg": str(i.message),
            "to": i.TO_ID.id,
            "date": i.date,
            "from": i.FROM_ID.id,
        })

    print(l)

    return JsonResponse({"data": l, 'toid': to_id,'status':'ok'})




#---------------------------------------------------


def flutter_forget_password(request):
    if request.method == "POST":
        email = request.POST.get('email', '').strip()
        print(email,"-------------------")
        user = User.objects.get(email=email )

        new_pass = str(random.randint(1000, 9999))
        user.password = make_password(new_pass)
        user.save()

        smtp_server = "smtp.gmail.com"
        smtp_port = 587
        sender_email = "trainingstarted@gmail.com"
        app_password = "nlxasujxgazlbmgz"
        subject = "Your New Password"
        body = f"Your new password is: {new_pass}"
        message = MIMEMultipart()
        message["From"] = sender_email
        message["To"] = email
        message["Subject"] = subject
        message.attach(MIMEText(body, "plain"))

        server = smtplib.SMTP(smtp_server, smtp_port)
        server.starttls()
        server.login(sender_email, app_password)
        server.send_message(message)
        server.quit()

        return JsonResponse({'status': 'ok', 'message': 'Password sent to your email'})





def worker_viewchat(request):
    fromid = request.POST["from_id"]
    toid = request.POST["to_id"]
    # lmid = request.POST["lastmsgid"]    from django.db.models import Q

    res = chat.objects.filter(Q(FROM_ID_id=fromid, TO_ID_id=toid) | Q(FROM_ID_id=toid, TO_ID_id=fromid)).order_by("id")
    l = []

    for i in res:
        l.append({"id": i.id, "msg": i.message, "from": i.FROM_ID_id, "date": i.date, "to": i.TO_ID_id})

    return JsonResponse({"status":"ok",'data':l})


def worker_sendchat(request):
    FROM_id=request.POST['from_id']
    TOID_id=request.POST['to_id']
    print(FROM_id)
    print(TOID_id)
    msg=request.POST['message']

    from  datetime import datetime
    c=chat()
    c.FROM_ID_id=FROM_id
    c.TO_ID_id=TOID_id
    c.message=msg
    c.date=datetime.now()
    c.save()
    return JsonResponse({'status':"ok"})



