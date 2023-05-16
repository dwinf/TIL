> 웹 서버 소프트웨어

# 웹 서버
웹 서버(Web Server)
- 클라이언트에게 **정적인 콘텐츠**를 제공
어플리케이션 서버(Application Server)
- 클라이언트의 요청에 따라 응답이 달라지는 **동적인 콘텐츠**

### 웹 서버가 필요한 이유
- 응답속도도 높이고 어플리케이션 서버의 부하도 낮출 수 있다.
	- 정적 콘텐츠에 대해서는 어떤 응답을 하면 되는지 알고 있는 서버가 있다면 웹 서버가 응답
	- 그렇지 않은 요청은 어플리케이션 서버에 요청을 전달(proxy)
- 콘텐츠 제공에 있어서 요청에 필수적으로 처리해야 하는 작업을 앞에서 먼저 해서 어플리케이션 서버에 부하를 낮출수 있는 작업들을 처리

-   예: SSL 인증서 인증(SSL offloading)

## 웹 서버의 종류
1. **NGINX**
	- 
2. Caddy
	- 
3. Envoy
	- 
4. 그 외
	- 1

### NGINX를 선택한 이유
1. 성능이 좋다.
2. 레퍼런스가 많다.
3. 오픈소스 버전을 무료로 사용할 수 있다.
4. 사용하고 있는 회사가 많고, 이미 NGINX로 구축된 서비스도 많다. (약 [30%](https://www.stackscale.com/blog/top-web-servers/))
5. 전통적인 웹서버의 아키텍처, 설정의 방식을 가지고 있어서 이해가 쉽다.
6. Kubernetes(K8S)의 공식 ingress/egress controller이다.


# NGINX
## Install
```bash
sudo yum install nginx

sudo nginx -h # 사용법 확인
```
