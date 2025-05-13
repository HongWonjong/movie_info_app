🎬 영화 정보 앱: Movie Explorer


TMDB API를 활용한 Flutter 기반 영화 정보 앱으로, 클린 아키텍처와 Riverpod를 적용해 유지보수성과 확장성을 극대화했습니다! ✨ Flutter의 Hero 위젯으로 구현한 부드러운 양방향 애니메이션, 공용 AppBar, iOS/Android 권한 관리까지! 이 프로젝트는 영화 탐색의 재미와 UI/데이터 흐름 연습을 위해 탄생했습니다. 🎥

🌟 프로젝트 개요
이 앱은 영화 팬들을 위한 최적의 탐색 도구입니다! 🖥️ 홈 화면에서 인기 영화, 현재 상영중, 평점 높은 영화, 개봉 예정작을 한눈에 확인하고, 상세 페이지에서 영화의 모든 정보를 깊이 파헤칠 수 있습니다. 📊 카메라, 위치, 마이크 권한을 활용한 QR 코드 스캔과 위치 기반 영화관 추천 기능까지! 클린 아키텍처로 데이터, 도메인, 프레젠테이션 계층을 깔끔하게 분리해 코드의 가독성과 재사용성을 높였습니다. 💻

🚀 주요 기능
🖼️ 화면 구성
🏠 홈 화면 (HomePage)

🔥 가장 인기있는 영화: 패딩 20을 제외한 가로 너비를 꽉 채운 포스터 이미지.
📜 카테고리별 리스트뷰: 현재 상영중, 인기순, 평점 높은순, 개봉 예정 영화 20개를 가로 리스트뷰로 표시 (높이 180).
🏷️ 라벨: 각 리스트뷰 위에 카테고리 이름이 선명하게 표시.
🏆 인기순 랭킹: 인기 영화 이미지 좌측 하단에 순위 표시 (#1, #2 등).
🌙 디폴트 다크 모드: 세련된 다크 테마만 지원 (라이트 모드 미지원).
📋 상세 화면 (DetailPage)

🎥 영화 정보: 포스터, 제목, 개봉일, 태그라인, 러닝타임, 카테고리, 설명을 한눈에!
📈 흥행 정보: 평점, 투표수, 인기점수, 예산, 수익을 가로 리스트뷰로 깔끔하게 표시.
🏢 제작사 로고: 흰색 배경(투명도 0.9)으로 가로 리스트뷰에 스타일리시하게 표시.
🔐 권한 화면 (PermissionPage)

📸 카메라, 📍 위치, 🎙️ 마이크 권한 요청 UI.
✅ 권한 상태: 실시간 권한 상태 표시 및 앱 설정 이동 기능.
⚡ 자동 전환: 모든 권한 허가 시 홈 화면으로 즉시 이동.
🔝 공용 AppBar

모든 페이지에 적용된 "Movie App" 타이틀.
DetailPage에서 뒤로 가기 버튼 제공, 다른 페이지에서는 간결하게 생략.
🎥 Hero 애니메이션
HomePage ↔ DetailPage 간 영화 포스터 전환 시 Hero 위젯으로 부드러운 양방향 애니메이션! 🎞️
각 영화마다 고유한 tag 설정 (예: featured_popular_{id}, popular_{id})으로 충돌 방지. 🚀
🌐 TMDB API 통합 & 클린 아키텍처
TMDB API로 실시간 영화 데이터 가져오기:
현재 상영중, 인기순, 평점 높은순, 개봉 예정 영화 목록.
영화 상세 정보 (예산, 장르, 제작사, 비디오, 크레딧 등).
인증 방식: Bearer 토큰으로 안전한 API 요청.
클린 아키텍처:
Data Layer: DTO, DataSource, Repository 구현.
Domain Layer: 엔티티, 유스케이스, Repository 인터페이스.
Presentation Layer: Riverpod 프로바이더와 위젯.
환경 변수 관리: .env 파일로 액세스 토큰 안전하게 관리.
🔒 권한 관리
iOS & Android 권한 요청:
📸 카메라: QR 코드 스캔.
📍 위치: 근처 영화관 추천.
🎙️ 마이크: 음성 명령 처리.
🌐 인터넷: TMDB API 호출.
permission_handler 패키지로 런타임 권한 요청.
권한 거부 시 사용자에게 이유 설명 및 앱 설정 화면 안내.
앱 시작 시 모든 권한 허가 완료 → PermissionPage 자동 건너뛰기.
Android/iOS별 권한 처리 분기.
🛠️ 설치 방법
📋 사전 준비
Flutter SDK: 3.10 이상
Dart: 3.0 이상
TMDB API 읽기 액세스 토큰: TMDB에서 회원가입 후 발급
🚀 설치 단계
레포지토리 클론:
bash

Copy
git clone https://github.com/your-repo/flutter_movie_app.git
프로젝트 디렉터리로 이동:
bash

Copy
cd flutter_movie_app
환경 변수 설정:
프로젝트 루트에 .env 파일 생성:
env

Copy
TMDB_ACCESS_TOKEN=your_access_token_here
의존성 설치:
bash

Copy
flutter pub get
앱 실행:
bash

Copy
flutter run
📂 프로젝트 구조
text

Copy
flutter_movie_app/
├── lib/
│   ├── core/           # 공통 유틸리티 (상수, 네트워크, 권한)
│   ├── data/           # 데이터 계층 (DTO, DataSource, Repository)
│   ├── domain/         # 도메인 계층 (엔티티, 유스케이스, Repository 인터페이스)
│   ├── presentation/   # 프레젠테이션 계층 (페이지, Riverpod 프로바이더, 위젯)
│   └── main.dart       # 앱 진입점
├── android/            # Android 설정 (AndroidManifest.xml)
├── ios/                # iOS 설정 (Info.plist)
├── .env                # 환경 변수 (액세스 토큰)
├── pubspec.yaml        # 의존성 정의
└── README.md           # 프로젝트 설명
📜 주요 파일 및 역할
Core Layer:
core/constants/api_constants.dart: TMDB API URL 및 상수.
core/network/http_client.dart: HTTP 클라이언트 싱글톤.
core/permissions/permission_service.dart: iOS/Android 권한 관리.
Data Layer:
data/datasource/movie_datasource_impl.dart: TMDB API 호출.
data/dto/movie_response_dto.dart, data/dto/movie_detail_dto.dart: JSON 파싱.
data/repository/movie_repository_impl.dart: 데이터 소스와 엔티티 매핑.
Domain Layer:
domain/entity/movie.dart, domain/entity/movie_detail.dart: 데이터 모델.
domain/usecase/fetch_now_playing_movies.dart, domain/usecase/fetch_movie_detail.dart: 비즈니스 로직.
domain/repository/movie_repository.dart: 데이터 소스 추상화.
Presentation Layer:
presentation/pages/home_page.dart, detail_page.dart, permission_page.dart: UI 페이지.
presentation/widgets/movie_list.dart, movie_card.dart, common_app_bar.dart: 재사용 위젯.
presentation/providers/home_provider.dart, detail_provider.dart: 상태 관리.
🔄 사용자 클릭 흐름 (클린 아키텍처 기준)
1. 앱 시작 및 HomePage 로드
   행동: 사용자가 앱 실행.
   흐름:
   main.dart: .env에서 TMDB_ACCESS_TOKEN 로드 → 권한 확인 → HomePage 렌더링.
   permission_service.dart: 카메라, 위치, 마이크 권한 확인 (Android/iOS 분기).
   home_page.dart: homeProvider로 영화 데이터 로드 → movie_list.dart, movie_card.dart로 UI 렌더링.
   Hero 위젯 준비: 포스터 애니메이션용 고유 heroTag.
   결과: 영화 목록 표시, 클릭 가능한 MovieCard.
2. 영화 카드 클릭 및 DetailPage 이동
   행동: 홈 화면에서 영화 카드 클릭.
   흐름:
   movie_card.dart: Navigator.push로 DetailPage 이동, movieId와 heroTag 전달.
   detail_page.dart: detailProvider로 영화 상세 데이터 로드 → UI 렌더링.
   Hero 애니메이션: 포스터 전환 효과.
   결과: 영화 상세 정보 표시, 부드러운 전환 애니메이션.
3. 뒤로 가기 및 HomePage 복귀
   행동: DetailPage의 AppBar에서 뒤로 가기 버튼 클릭.
   흐름:
   common_app_bar.dart: Navigator.pop 호출.
   home_page.dart: 기존 데이터로 UI 복원.
   Hero 애니메이션: 역방향 포스터 전환.
   결과: HomePage로 복귀, 역방향 애니메이션 완료.
   🛠️ 사용된 의존성
   http: TMDB API 요청
   flutter_dotenv: 환경 변수 관리
   flutter_riverpod: 상태 관리 및 의존성 주입
   equatable: 객체 비교
   dartz: 함수형 프로그래밍 유틸리티
   permission_handler: iOS/Android 권한 관리
   flutter_test: 테스트 프레임워크
   mockito: 모킹 라이브러리
   📌 자세한 의존성은 pubspec.yaml 참조.

🔍 트러블슈팅 가이드
1. API 인증 문제
   현상: 영화 데이터 로드 실패.
   해결:
   .env 파일의 TMDB_ACCESS_TOKEN 확인.
   TMDB API 설정 페이지에서 토큰 재발급.
   movie_datasource_impl.dart의 Bearer 헤더 확인.
2. 네트워크 오류
   현상: API 요청 실패.
   해결:
   인터넷 연결 확인.
   AndroidManifest.xml: <uses-permission android:name="android.permission.INTERNET" /> 확인.
   Info.plist: NSLocalNetworkUsageDescription 확인.
3. Hero 애니메이션 문제
   현상: 애니메이션 미작동 또는 충돌.
   해결:
   HomePage와 DetailPage의 heroTag 일치 여부 확인.
   디버그 콘솔에서 Hero tag 로그 점검.
   Hero 위젯의 크기/가림 여부 확인.
4. 권한 요청 문제
   현상: 권한 거부 또는 앱 설정 이동 실패.
   해결:
   AndroidManifest.xml, Info.plist의 권한 선언 확인.
   PermissionService의 openAppSettings 호출 확인.
   iOS: 설정 > 개인정보 보호 확인.
   Android: 설정 > 앱 > [앱 이름] > 권한 확인.
   🤝 기여 방법
   이슈 등록: 개선점이나 버그 제안.
   포크 & 브랜치: 새로운 기능 추가.
   풀 리퀘스트: 코드 리뷰 요청.
   📜 라이선스
   이 프로젝트는 MIT 라이선스 하에 배포됩니다. 자세한 내용은 LICENSE 파일을 확인하세요.

📸 스크린샷
(TODO: 홈 화면, 상세 화면, 권한 화면 스크린샷 추가)



