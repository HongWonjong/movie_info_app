영화 정보 앱

TMDB API를 활용하여 영화 정보를 표시하는 Flutter 기반 애플리케이션입니다. 클린 아키텍처와 Riverpod를 적용하여 유지보수성과 확장성을 높였습니다. 이 프로젝트는 Flutter의 Hero 위젯을 사용한 애니메이션, TMDB API 데이터 처리, iOS 및 Android 권한 관리를 연습하기 위해 제작되었습니다.

📖 프로젝트 개요
이 앱은 사용자가 다양한 영화 정보를 탐색할 수 있도록 설계되었습니다. 홈 화면에서는 인기 영화, 현재 상영중, 평점 높은 영화, 개봉 예정 영화를 확인할 수 있으며, 상세 페이지에서는 영화의 세부 정보와 흥행 데이터를 제공합니다. 또한, 카메라, 위치, 마이크 권한을 요청하여 QR 코드 스캔 및 위치 기반 영화관 추천 기능을 지원합니다. 클린 아키텍처를 기반으로 데이터 계층, 도메인 계층, 프레젠테이션 계층을 분리하여 코드의 가독성과 재사용성을 높였습니다.

✨ 주요 기능
🖥️ 화면 구성 (Lv.1)

홈 화면 (HomePage)
가장 인기있는 영화: 화면 가로 너비를 모두 차지하는 큰 포스터 이미지.
카테고리별 리스트뷰: 현재 상영중, 인기순, 평점 높은순, 개봉예정 영화 20개씩 가로 리스트뷰로 표시.
인기순 랭킹: 인기순 영화에 순위 표시.
디폴트 다크 모드: 라이트 모드 미지원.


상세 화면 (DetailPage)
영화 포스터, 제목, 개봉일, 태그라인, 러닝타임, 카테고리, 설명 표시.
흥행 정보: 평점, 투표수, 인기점수, 예산, 수익을 가로 리스트뷰로 표시.
제작사 로고: 흰색 배경(투명도 0.9)으로 가로 리스트뷰 표시.


권한 화면 (PermissionPage)
카메라, 위치, 마이크 권한 요청 UI.
권한 상태 표시 및 앱 설정으로 이동 기능.
모든 권한이 허가된 경우 자동으로 홈 화면으로 이동.



🎥 Hero 애니메이션 (Lv.2)

HomePage와 DetailPage 간 영화 포스터 전환 시 Hero 위젯을 사용한 부드러운 애니메이션 효과.
각 영화마다 고유한 tag를 설정하여 애니메이션 충돌 방지.

🌐 TMDB API 통합 및 클린 아키텍처 (Lv.3)

TMDB API를 통해 영화 데이터 가져오기:
현재 상영중, 인기순, 평점 높은순, 개봉예정 영화 목록.
영화 상세 정보 (예산, 장르, 제작사 등).


클린 아키텍처:
Data Layer: DTO, DataSource, Repository 구현.
Domain Layer: 엔티티, 유스케이스, Repository 인터페이스.
Presentation Layer: Riverpod 프로바이더와 위젯.


환경 변수 관리: .env 파일을 통해 API 키 안전하게 관리.

🔒 권한 관리 (Lv.5 자유 기능)

iOS 및 Android 권한 요청:
카메라: QR 코드 스캔.
위치: 근처 영화관 추천.
마이크: 음성 명령 처리.
인터넷: TMDB API 호출.


permission_handler 패키지를 사용하여 런타임 권한 요청.
권한 거부 시 사용자에게 이유 설명 및 앱 설정 화면 안내.
앱 시작 시 모든 권한이 허가된 경우 PermissionPage를 자동 건너뛰기.
Android와 iOS별 권한 처리 분기:
Android: 런타임 권한 요청 및 설정 안내.
iOS: Info.plist 설명 기반 요청.




🚀 설치 방법
사전 준비

Flutter SDK: 3.10 이상
Dart: 3.0 이상
TMDB API 키: TMDB에서 회원가입 후 API 키 발급

설치 단계

레포지토리 클론git clone https://github.com/your-repo/flutter_movie_app.git


프로젝트 디렉터리로 이동cd flutter_movie_app


환경 변수 설정
프로젝트 루트에 .env 파일을 생성하고 TMDB API 키를 추가:TMDB_API_KEY=your_api_key_here




의존성 설치flutter pub get


앱 실행flutter run




📂 프로젝트 구조
flutter_movie_app/
├── lib/
│   ├── core/           # 공통 유틸리티 (상수, 네트워크, 권한)
│   ├── data/           # 데이터 계층 (DTO, DataSource, Repository)
│   ├── domain/         # 도메인 계층 (엔티티, 유스케이스, Repository 인터페이스)
│   ├── presentation/   # 프레젠테이션 계층 (페이지, Riverpod 프로바이더, 위젯)
│   └── main.dart       # 앱 진입점
├── android/            # Android 설정 (AndroidManifest.xml)
├── ios/                # iOS 설정 (Info.plist)
├── .env                # 환경 변수 (API 키)
├── pubspec.yaml        # 의존성 정의
└── README.md           # 프로젝트 설명


🛠️ 사용된 의존성

http: TMDB API 요청
flutter_dotenv: 환경 변수 관리
flutter_riverpod: 상태 관리 및 의존성 주입
equatable: 객체 비교
dartz: 함수형 프로그래밍 유틸리티
permission_handler: iOS 및 Android 권한 관리
flutter_test: 테스트 프레임워크
mockito: 모킹 라이브러리

자세한 의존성은 pubspec.yaml 파일을 참고하세요.

🔍 트러블슈팅 가이드
1. API 키 관련 문제

현상: 영화 데이터가 로드되지 않음.
해결:
.env 파일에 올바른 TMDB API 키가 입력되었는지 확인.
키는 TMDB API 설정 페이지에서 발급 가능.



2. 네트워크 오류

현상: API 요청 실패.
해결:
인터넷 연결 확인.
AndroidManifest.xml에 <uses-permission android:name="android.permission.INTERNET" /> 추가 확인.
lib/core/constants/api_constants.dart의 엔드포인트 URL 확인.



3. Hero 애니메이션 문제

현상: 애니메이션이 작동하지 않거나 충돌 발생.
해결:
HomePage와 DetailPage에서 동일한 heroTag가 사용되었는지 확인.
동일 페이지 내에서 중복된 tag가 없도록 보장.



4. 권한 요청 문제

현상: 권한이 거부되거나 앱 설정으로 이동하지 않음.
해결:
AndroidManifest.xml과 Info.plist에 필요한 권한이 선언되었는지 확인.
PermissionService의 openAppSettings 호출 확인.
iOS: Settings > Privacy & Security에서 앱 권한 확인.
Android: Settings > Apps > [App Name] > Permissions에서 권한 확인.
main.dart에서 areAllPermissionsGranted가 올바르게 동작하는지 확인.


📸 스크린샷
(TODO: 앱의 홈 화면, 상세 화면, 권한 화면 스크린샷 추가)


