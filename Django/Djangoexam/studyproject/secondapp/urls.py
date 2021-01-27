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
]