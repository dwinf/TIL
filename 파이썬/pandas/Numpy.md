# Numpy

> 행렬이나 대규모 다차원 배열을 쉽게 처리 할 수 있도록 지원하는 파이썬의 라이브러리
>
> 데이터 구조 외에도 수치 계산을 위해 효율적으로 구현된 기능을 제공

| Python List                    | NumPy ndarray                 |
| ------------------------------ | ----------------------------- |
| 여러가지 타입의 원소           | 동일 타입의 원소              |
| linked List 구현               | contigous memory layout       |
| 메모리 용량이 크고 속도가 느림 | 메모리 최적화, 계산 속도 향상 |
| 벡터화 연산 불가               | 벡터화 연산 가능              |



#### NumPy 라이브러리

```python
import numpy as np
```



##  1. 벡터 생성

### (1) 행으로 구성된 벡터 - 1차원 ndarray 객체 

```python
vector_row = np.array([1, 2, 3])
```



### (2) 열로 구성된 벡터 - 2차원 ndarray 객체 

```python
vector_column = np.array([[1],
                          [2],
                          [3]])

matrix = np.array([[1, 2],
                   [1, 2],
                   [1, 2]])
```



### (3) arange 함수를 통한 생성

- np.arrange([start], stop, [step])
  - **start**부터 **stop-1**까지 step 간격을 준 벡터 생성
  - start의 기본값은 0, step의 기본값은 1

```python
a1 = np.arange(30) # 0 ~ 30
a2 = np.arange(1, 31) # 1 ~ 30
a3 = np.arange(5, 30) # 5 ~ 29
a4 = np.arange(5, 30, 3) # 5 8 11 ... 29
np.arange(0, 5, 0.5) # 0 0.5 1 1.5 ...
np.arange(0, 5, -0.5) # empty
np.arange(5, 0, -0.5) # 5 4.5 4 3.5 ... 0.5
```



### (4) 다양한 방식의 생성 방법

#### mat 함수

- **array**와 동일하여 최근에는 사용안됨

```python
matrix2 = np.mat([[1, 2], # 최근에는 array로 대체되어 잘 사용되지 않는다.
                  [1, 2],
                  [1, 2]])
```



#### empty 함수

- 초기화되지 않고 메모리만 할당받은 ndarray 객체를 생성
  - 사용하기 위해서는 초기화가 필요

```python
empty_matrix = np.empty((3, 2)) # 3 x 2 행렬 
```



#### zeros 함수

- 0으로 초기화하여 ndarray 객체를 생성

```python
empty_matrix = np.zeros((3, 2)) # 3 x 2 행렬 
```



#### ones 함수

- 1으로 초기화하여 ndarray 객체를 생성

```python
empty_matrix = np.ones((3, 2)) # 3 x 2 행렬 
```



#### 객체 복사

```python
copy_matrix = np.array(one_matrix) # 복제
ref_matrix = np.asarray(one_matrix) # 참조
```

- **array**는 one_matrix와 같은 새로운 ndarray 객체를 생성
  - **깊은 복사**
- **asarray**는 one_matrix와 같은 메모리를 공유하는 ndarray  객체 생성
  - **얕은 복사**(파이썬 배열의 경우 깊은 복사가 된다.)



### 구조 확인

- `ndarray.ndim` : ndarray 객체가 몇차원인지
- `ndarray.size` : ndarray 객체에 존재하는 원소의 수

```python
print(arr.ndim)
print(arr.size)
```

