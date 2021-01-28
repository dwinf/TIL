from django.urls import path
from . import views
import firstapp.views
urlpatterns = [
    path('', views.exam1, name='exam1'),
    path('exam2/', views.exam2, name='exam2'),
    path('exam2_1/', views.exam2_1, name='exam2_1'),
    path('exam3/', views.exam3, name='exam3'),
    path('exam4/', views.exam4, name='exam4'),
    path('exam5/', views.exam5, name='exam5'),
    path('exam6/', views.exam6, name='exam6'),
    path('exam7/', views.exam7, name='exam7'),
    path('exam8/', views.exam8, name='exam8'),
    path('exam9/', views.exam9, name='exam9'),
    path('exam10/<name>/', views.exam10, name='exam10'),
    path('exam11/<name>/<int:age>', views.exam11, name='exam11'),
    path('exam12/<int:num1>/<num2>', views.exam12, name='exam12'),
    path('exam13/', views.exam13, name='exam13'),
    path('exam14/<word>/<int:num1>/<int:num2>', views.exam14, name='exam14'),
    path('exam15/', views.exam15, name='exam15'),
    path('exam16/', views.exam16, name='unico'),
    path('exam17/', views.exam17, name='exam17'),
    path('exam18/', views.exam18, name='exam18'),
    path('exam19/', views.exam19, name='exam19'),
]