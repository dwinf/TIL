from django.urls import path
from . import views
import firstapp.views
urlpatterns = [
    path('', views.exam1, name='exam1'),
    path('exam2/', views.exam2, name='exam2'),
    path('exam2_1/', views.exam2_1, name='exam2_1'),

]