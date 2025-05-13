영화 정보 앱

TMDB API를 활용하여 영화 정보를 표시하는 Flutter 기반 애플리케이션입니다. 클린 아키텍처와 Riverpod를 적용하여 유지보수성과 확장성을 높였으며, Flutter의 Hero 위젯을 사용한 양방향 애니메이션, 공용 AppBar, iOS 및 Android 권한 관리를 구현했습니다. 이 프로젝트는 영화 정보 탐색과 UI/데이터 흐름 연습을 위해 제작되었습니다.

📖 프로젝트 개요
이 앱은 사용자가 다양한 영화 정보를 탐색할 수 있도록 설계되었습니다. 홈 화면에서는 인기 영화, 현재 상영중, 평점 높은 영화, 개봉 예정 영화를 확인할 수 있으며, 상세 페이지에서는 영화의 세부 정보와 흥행 데이터를 제공합니다. 카메라, 위치, 마이크 권한을 요청하여 QR 코드 스캔 및 위치 기반 영화관 추천 기능을 지원합니다. 클린 아키텍처를 기반으로 데이터 계층, 도메인 계층, 프레젠테이션 계층을 분리하여 코드의 가독성과 재사용성을 높였습니다.

✨ 주요 기능
🖥️ 화면 구성 (Lv.1)

홈 화면 (HomePage)
가장 인기있는 영화: 패딩 20 제외 가로 너비 전체를 차지하는 포스터 이미지.
카테고리별 리스트뷰: 현재 상영중, 인기순, 평점 높은순, 개봉예정 영화 20개씩 가로 리스트뷰로 표시, 높이 180.
라벨: 각 리스트뷰 위에 카테고리 이름 표시.
인기순 랭킹: 인기순 영화 이미지 좌측 하단에 순위 표시 (#1, #2 등).
디폴트 다크 모드: 라이트 모드 미지원.


상세 화면 (DetailPage)
영화 포스터, 제목, 개봉일, 태그라인, 러닝타임, 카테고리, 설명 표시.
흥행 정보: 평점, 투표수, 인기점수, 예산, 수익을 가로 리스트뷰로 표시.
제작사 로고: 흰색 배경(투명도 0.9)으로 가로 리스트뷰 표시.


권한 화면 (PermissionPage)
카메라, 위치, 마이크 권한 요청 UI.
권한 상태 표시 및 앱 설정으로 이동 기능.
모든 권한이 허가된 경우 자동으로 홈 화면으로 이동.


공용 AppBar
모든 페이지에 적용, "Movie App" 제목 표시.
DetailPage에서 뒤로 가기 버튼 제공, 다른 페이지에서는 제외.



🎥 Hero 애니메이션 (Lv.2)

HomePage와 DetailPage 간 영화 포스터 전환 시 Hero 위젯을 사용한 양방향 애니메이션 효과.
각 영화마다 고유한 tag 설정 (예: featured_popular_{id}, popular_{id})으로 애니메이션 충돌 방지.

🌐 TMDB API 통합 및 클린 아키텍처 (Lv.3)

TMDB API를 통해 영화 데이터 가져오기:
현재 상영중, 인기순, 평점 높은순, 개봉예정 영화 목록.
영화 상세 정보 (예산, 장르, 제작사, 비디오, 크레딧 등).


인증 방식: API 읽기 액세스 토큰(Bearer)을 사용하여 안전한 요청.
클린 아키텍처:
Data Layer: DTO, DataSource, Repository 구현.
Domain Layer: 엔티티, 유스케이스, Repository 인터페이스.
Presentation Layer: Riverpod 프로바이더와 위젯.


환경 변수 관리: .env 파일을 통해 액세스 토큰 안전하게 관리.

🔒 권한 관리 (Lv.5 자유 기능)

iOS 및 Android 권한 요청:
카메라: QR 코드 스캔.
위치: 근처 영화관 추천.
마이크: 음성 명령 처리.
인터넷: TMDB API 호출.


permission_handler 패키지를 사용하여 런타임 권한 요청.
권한 거부 시 사용자에게 이유 설명 및 앱 설정 화면 안내.
앱 시작 시 모든 권한이 허가된 경우 PermissionPage 자동 건너뛰기.
Android와 iOS별 권한 처리 분기.


🚀 설치 방법
사전 준비

Flutter SDK: 3.10 이상
Dart: 3.0 이상
TMDB API 읽기 액세스 토큰: TMDB에서 회원가입 후 액세스 토큰 발급

설치 단계

레포지토리 클론git clone https://github.com/your-repo/flutter_movie_app.git


프로젝트 디렉터리로 이동cd flutter_movie_app


환경 변수 설정
프로젝트 루트에 .env 파일을 생성하고 TMDB 액세스 토큰 추가:TMDB_ACCESS_TOKEN=your_access_token_here




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
├── .env                # 환경 변수 (액세스 토큰)
├── pubspec.yaml        # 의존성 정의
└── README.md           # 프로젝트 설명

주요 파일 및 역할

Core Layer:
api_constants.dart: TMDB API URL 및 상수.
http_client.dart: HTTP 클라이언트 싱글톤.
permission_service.dart: iOS/Android 권한 관리.


Data Layer:
movie_datasource_impl.dart: TMDB API 호출.
movie_response_dto.dart, movie_detail_dto.dart: JSON 파싱.
movie_repository_impl.dart: 데이터 소스와 엔티티 매핑.


Domain Layer:
movie.dart, movie_detail.dart: 데이터 모델.
fetch_now_playing_movies.dart, fetch_movie_detail.dart: 비즈니스 로직.
movie_repository.dart: 데이터 소스 추상화.


Presentation Layer:
home_page.dart, detail_page.dart, permission_page.dart: UI 페이지.
movie_list.dart, movie_card.dart, common_app_bar.dart: 재사용 위젯.
home_provider.dart, detail_provider.dart: 상태 관리.




🔄 사용자 클릭에 따른 작동 흐름
아래는 사용자가 HomePage에서 영화 카드를 클릭하여 DetailPage로 이동하고, 뒤로 가기 버튼으로 HomePage로 돌아오는 흐름을 클린 아키텍처 계층과 파일 기준으로 단계별로 설명합니다.
1. 앱 시작 및 HomePage 로드

행동: 사용자가 앱을 실행.
흐름:
main.dart:
.env에서 TMDB_ACCESS_TOKEN 로드.
PermissionService로 권한 확인, HomePage 또는 PermissionPage 렌더링.


permission_service.dart:
카메라, 위치, 마이크 권한 확인.


home_page.dart:
initState에서 homeProvider의 fetchAllMovies 호출.
CommonAppBar 렌더링 (제목: "Movie App", 뒤로 가기 버튼 없음).


home_provider.dart:
fetchAllMovies에서 유스케이스(fetchNowPlayingMoviesProvider 등) 호출.


usecase_providers.dart:
유스케이스 인스턴스 제공.


fetch_now_playing_movies.dart 등:
MovieRepository의 메서드 호출.


movie_repository_impl.dart:
MovieDataSource 호출, DTO를 엔티티로 변환.


movie_datasource_impl.dart:
TMDB API 호출(/movie/now_playing 등), MovieResponseDto 파싱.


movie_response_dto.dart:
JSON 데이터를 MovieDto로 파싱.


home_page.dart, movie_list.dart, movie_card.dart:
영화 목록 렌더링, Hero 위젯으로 포스터 애니메이션 준비.




결과: HomePage에 영화 목록 표시, 클릭 가능한 MovieCard.

2. 영화 카드 클릭 및 DetailPage로 이동

행동: 사용자가 HomePage의 영화 카드 또는 "가장 인기있는" 영화 클릭.
흐름:
movie_card.dart 또는 home_page.dart:
GestureDetector의 onTap 이벤트로 Navigator.push 호출.
DetailPage로 이동, movieId와 heroTag 전달 (예: popular_123, featured_popular_123).


detail_page.dart:
initState에서 detailProvider의 fetchMovieDetail 호출.
CommonAppBar 렌더링 (제목: "Movie App", 뒤로 가기 버튼 포함).
Hero 위젯으로 포스터 애니메이션 준비.


detail_provider.dart:
fetchMovieDetail에서 fetchMovieDetailProvider 호출, AsyncValue로 상태 관리.


usecase_providers.dart:
FetchMovieDetail 유스케이스 제공.


fetch_movie_detail.dart:
MovieRepository의 fetchMovieDetail 호출, appendToResponse: 'videos,credits'.


movie_repository_impl.dart:
MovieDataSource 호출, MovieDetailDto를 MovieDetail로 변환.


movie_datasource_impl.dart:
TMDB API 호출(/movie/{id}?append_to_response=videos,credits), MovieDetailDto 파싱.


movie_detail_dto.dart:
JSON 데이터를 MovieDetailDto로 파싱.


detail_page.dart:
detailProvider 상태 감시, 영화 상세 정보 렌더링.
Hero 애니메이션으로 포스터 전환.




결과: DetailPage에 영화 상세 정보 표시, HomePage → DetailPage Hero 애니메이션 작동.

3. 뒤로 가기 버튼 클릭 및 HomePage로 복귀

행동: 사용자가 DetailPage의 공용 AppBar에서 뒤로 가기 버튼 클릭.
흐름:
common_app_bar.dart:
IconButton의 onPressed로 Navigator.pop 호출.


detail_page.dart:
Navigator.pop으로 DetailPage 종료, HomePage로 복귀.
Hero 위젯으로 역방향 애니메이션 처리.


home_page.dart:
기존 homeProvider 데이터로 UI 렌더링.
Hero 위젯으로 포스터 애니메이션 완료.
CommonAppBar 표시.




결과: DetailPage → HomePage 이동, 역방향 Hero 애니메이션 작동.


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
1. API 인증 문제

현상: 영화 데이터가 로드되지 않음.
해결:
.env 파일에 올바른 TMDB_ACCESS_TOKEN 입력 확인.
토큰은 TMDB API 설정 페이지에서 발급.
movie_datasource_impl.dart에서 Authorization: Bearer 헤더 확인.



2. 네트워크 오류

현상: API 요청 실패.
해결:
인터넷 연결 확인.
AndroidManifest.xml에 <uses-permission android:name="android.permission.INTERNET" /> 확인.
Info.plist에 NSLocalNetworkUsageDescription 확인.



3. Hero 애니메이션 문제

현상: 애니메이션이 작동하지 않거나 충돌 발생.
해결:
HomePage와 DetailPage에서 동일한 heroTag 사용 확인.
디버그 콘솔에서 Hero tag 로그 점검.
Hero 위젯의 크기 및 가림 여부 확인.



4. 권한 요청 문제

현상: 권한 거부 또는 앱 설정 이동 실패.
해결:
AndroidManifest.xml과 Info.plist에 권한 선언 확인.
PermissionService의 openAppSettings 호출 확인.
iOS: Settings > Privacy & Security에서 권한 확인.
Android: Settings > Apps > [App Name] > Permissions 확인.



📸 스크린샷
(TODO: 홈 화면, 상세 화면, 권한 화면 스크린샷 추가)



