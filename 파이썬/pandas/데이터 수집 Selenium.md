# Selenium

> 동적으로 렌더링되는 동적 콘텐츠의 스크래핑 도구

## 1. WebDriver 객체 생성

```python
driver = webdriver.Chrome('C:/Temp/chromedriver')
```

- 크롬 드라이버를 기반으로 selenium.webdriver.chrome.webdriver.WebDriver 객체 생성
- Selenium에 의해 관리되는 크롬 브라우저가 기동 됨



## 2. 페이지 가져오기

```
driver.get('http://www.google.com/ncr') 
```

- `get()` 메서드를 사용하여 크롤링하려는 웹 페이지를 제어하는 크롬 브라우저에 로드하고 렌더링

```
driver.implicitly_wait(3)
driver.get('http://www.google.com/ncr') 
```

- 페이지 로드가 완료되기 전에 다음 명령어가 실행될 경우를 고려

```
driver.get('http://www.google.com/ncr', 5) 
```

- driver.implicitly_wait(5)를 준 것과 동일



## 3. WebDriver의 요소 찾기

### (1) 태그의 id 속성 값으로 찾기

```python
byId = driver.find_element_by_id('btype')
byId = driver.find_element(by=By.ID, value='btype')
```

### (2) 태그의 class 속성 값으로 찾기

```python
target = driver.find_element_by_class_name('quickResultLstCon')
target = driver.find_element(By.CLASS_NAME, "quickResultLstCon")
```

### (3) 태그명으로 찾기

```python
byTagName = driver.find_element_by_tag_name('h1') 
byTagName = driver.find_element(By.TAG_NAME, 'h1')
```

### (4) 링크 텍스트로 태그 찾기

```python
byLinkText = driver.find_element_by_link_text('파이썬 학습 사이트')
byLinkText = driver.find_element(By.LINK_TEXT, '파이썬 학습 사이트')
```

### (5) 부분 링크 텍스트로 태그 찾기

```python
byLinkText = driver.find_element_by_partial_link_text('사이트')
byLinkText = driver.find_element(By.PARTIAL_LINK_TEXT, '사이트')
```

### (6) CSS 선택자로 태그 찾기

```python
byCss1 = driver.find_element_by_css_selector('section>h2') 
byCss1 = driver.find_element(By.CSS_SELECTOR, 'section>h2')
```

### (7) Xpath로 태그 찾기

```python
byXpath1 = driver.find_element_by_xpath('//*[@id="f_subtitle"]')
byXpath1 = driver.find_element(By.XPATH, '//*[@id="f_subtitle"]')
```

### (8) 그 외

#### 1. 조건에 맞는 요소 한 개 찾기 :  WebElement 객체 리턴

```python
driver.find_element_by_xxx("xxx에 알맞는 식")
```

#### 2. 조건에 맞는 모든 요소 찾기 : list 객체 리턴

```python
driver.find_elements_by_xxx("xxx에 알맞는 식")
```

#### 3. 요소의 정보 추출

```python
element = driver.find_element_by_id("element_id")
# 태그명
element.tag_name
# 텍스트 형식의 콘텐츠
element.text
# 속성값
element.get_attribute('속성명')
```