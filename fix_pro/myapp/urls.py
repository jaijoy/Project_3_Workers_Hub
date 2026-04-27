"""
URL configuration for fix_pro project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path

from myapp import views

urlpatterns = [

    path('logoutss/', views.logoutss),
    path('login_page/', views.login_page),
    path('login_page_POST/', views.login_page_POST),
    path('admin_index/', views.admin_index),


    path('admin_worker_view/', views.admin_worker_view),
    path('admin_worker_approve/<id>', views.admin_worker_approve),
    path('admin_worker_reject/<id>', views.admin_worker_reject),
    path('admin_worker_approved_view/', views.admin_worker_approved_view),


    path('i_changepassword/', views.i_changepassword),
    path('i_changepassword_post/', views.i_changepassword_post),


    path('admin_feedback/', views.admin_feedback),

    path('admin_complaints_user/', views.admin_complaints_user),
    path('admin_replay_complaint/', views.admin_replay_complaint),

    path('admin_complaints_worker/', views.admin_complaints_worker),
    path('admin_replay_complaint_worker/', views.admin_replay_complaint_worker),








    #----------------------------------------------------------------
    # path('worker_index/', views.worker_index),
    # path('worker_registration/', views.worker_registration),
    path('worker_registration/', views.worker_registration),
    path('android_login/', views.android_login),

    path('worker_complaint/', views.worker_complaint),
    path('worker_complaint_view/', views.worker_complaint_view),

    path('worker_skill_add', views.worker_skill_add),
    path('worker_skill_view', views.worker_skill_view),
    path('worker_skill_delete', views.worker_skill_delete),
    path('worker_skill_edit', views.worker_skill_edit),


    path('worker_view_booking_request/', views.worker_view_booking_request),
    path('worker_update_booking_status/', views.worker_update_booking_status),


    path('worker_view_booking_request_status/', views.worker_view_booking_request_status),
    path('worker_update_work_status/', views.worker_update_work_status),
    path('worker_view_rating/', views.worker_view_rating),
    path('worker_view_profile/', views.worker_view_profile),
    path('worker_viewchat', views.worker_viewchat),
    path('worker_sendchat', views.worker_sendchat),






    #-----------------------------------------

    path('user_registration/', views.user_registration),
    path('user_view_worker/', views.user_view_worker),
    path('user_view_worker_skill/', views.user_view_worker_skill),

    path('user_view_all_skill/', views.user_view_all_skill),
    path('user_book_skill/', views.user_book_skill),
    path('user_view_booking_status/', views.user_view_booking_status),
    path('payment/', views.payment),

    path('user_complaint/', views.user_complaint),
    path('user_complaint_view/', views.user_complaint_view),

    path('user_rating/', views.user_rating),
    path('user_feedback/', views.user_feedback),
    path('flutter_forget_password/', views.flutter_forget_password),


    # path('user_update_work_status/', views.user_update_work_status),


    path('user_chat_send/', views.user_chat_send),
    path('chat_view_user/', views.chat_view_user),

    path('worker_chat_send/', views.worker_chat_send),


    path('chat_view_worker/', views.chat_view_worker),


]
