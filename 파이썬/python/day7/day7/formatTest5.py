print('{} and {}'.format('You', 'Me'))
print('{0} and {1} and {0}'.format('You', 'Me'))
print('{var1} are {var2}'.format(var1='You', var2='Niceman'))

print('%s: %d' % ('나이', 30))                   	 #문자열과 정수 출력
print('{}: {}'.format('나이', 30))                            # %[-]폭[.유효자리수]서식

print('%f,%.2f' % (1.123, 1.123))        		 #실수 출력
print('{:f}, {:.2f}'.format(1.123, 1.123))

print('%o, %x, %X' % (10, 10, 10))      		 #진법 출력
print('{:b}, {:o}'.format(10, 10))
print('{:x}, {:X}'.format(10, 10))

print('|%5d|' % 123)      			 #고정 길이 출력
print('|%5s|' % 'abc')
print('|{:5}|'.format(123))
print('|{:5}|'.format('abc'))

print('|%-5d|' % 123)    			 # 고정 길이의 정렬
print('|%5s|' % 'abc')
print('|{:<5}|'.format(123))
print('|{:>5}|'.format('abc'))
print('|{:^5}|'.format('abc'))

print('|%05d|' % 123)           			#여백 채우기
print('|{:05}|'.format(123))
print('|{:_>5}|'.format('abc'))
print('|{:-^5}|'.format('abc'))

print('{:,}'.format(1000000))        		#정수, 실수 단위 구분
print('{:,.2f}'.format(1000000))
