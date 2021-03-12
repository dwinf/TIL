# R ggplot2 패키지

> ggplot2는 그래프 기능을 제공하는 또 다른 유용한 패키지이다



## 1. ggplot2 패키지란?

Hadley Wickham 교수에 의해 2005년부터 개발되고 있으며 ‘Grammar of Graphics’의 개념을 적용하여 기본 R 그래픽스에 서 제공하는 대부분의 작업을 효과적으로 수행한다. 

#### [ ggplot2의 장점 ] 
동일한 문법으로 다양한 그래프를 그릴 수 있다. 비교적 쉽게 높은 수준의 그래프를 그릴 수 있다. 데이터를 다루고 이해하는데 좋다.

#### [ Plot의 구성요소 ] 

- A set of layers 
  - Data 
  - Aesthetic mappings (aes) 
  - A geometric object (geom) 
  - A statistical transformation (stat) 
  - A position adjustment (position)
- A set of scales 
  - Scale은 데이터 값이 에스테틱에 대입되는 과 정을 조절하고 guide(축과 범례 등)가 어떻게 표시될지를 결정한다. 
  - 보통 ggplot이 알아서 scale을 추가하지만, 원 하는 사항에 대해서는 명시해야 한다.
- A coordinate system 
  - 좌표를 결정하는 에스테틱들이 어떻게 연결되 는지를 결정한다. 
  - 기본값은 Cartesian 좌표평 면이다 stat과 geom이 반영된 이후에 변경할 수 있다.
- A facetting specification



### ggplot2의 ‘Grammar of Graphics’

- **Data** 
  - 그래프를 그리려는 데이터로 구조는 데이터 프레임이고 데이터의 기록 방식은 long-farmat에 기반한 tidy data여야 한다. 
- **(Aesthetic)Mapping** 
  - 데이터의 요소와 그래프의 요소를 대응시키는 과정으로 그리려고 하는 그래프가 필수적으로 요구하는 대응요소만 만족시 키면 된다. 하나의 변수가 여러 가지 시각적 요소에 대응될 수도 있다. 
- **Geometric Object** 
  - 어떤 형태의 그래프를 그릴지 지정해야 한다. ggplot2에서는 이것을 Geometric Object, 줄여서 geom이라고 한다. 
- **Position** 
  - 그래프의 형태를 지정했으면 그래프에서 각 도형이 어떤 식으로 배치될 지를 결정할 수 있다. 이 옵션이 바로 position이다. 막대그래프나 선 그래프라면 누적 그래프를 그리거나 할 때 position 옵션을 조정해서 형태를 바꿀 수 있다. 
- **Statistical Transformation** 
  - 마지막으로 값이 어떻게 그래프에 반영되는지 결정하는 옵션이 있다. Statistical Transformation, 줄여서 stat 옵션이다. 히 스토그램과 같이 구간내에 존재하는 값의 개수를 세거나 밀도를 계산하는 등, 주어진 값을 변형시켜서 그래프에 반영시킬 때 사용한다.

#### 참고사항

- 각 변수는 개별의 열(column)로 존재한다. 
- 각 관측치는 행(row)으로 구성한다. 
- 각 표는 단 하나의 관측기준에 의해서 조직된 데이터를 저장한다. 
- 만약 여러 개의 표가 존재한다면, 적어도 하나 이상의 열(column)이 공유되어야 한다



## 2. ggplot2 패키지로 그래프 그리는 과정