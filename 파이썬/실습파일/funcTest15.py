def func1(p1, p2, p3, p4) :
    global a, b, d
    a = p1
    b = p2
    c = p3
    d = p4
    print('[지역] a=', a, ' b=', b, ' c=', c, ' d=', d, sep='', end='\n\n')

a = 10
b = 20
c = 30
print('[전역(함수호출전)] a=', a, ' b=', b, ' c=', c, sep='', end='\n\n')
func1('A', 'B', 'C', 'D')
print('[전역(함수호출후)] a=', a, ' b=', b, ' c=', c, ' d=', d, sep='', end='\n\n')
