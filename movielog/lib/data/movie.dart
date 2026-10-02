class Movie {
  const Movie({
    required this.id,
    required this.title,
    required this.genre,
    required this.year,
    required this.posterAsset,
    required this.rating,
    required this.reviewCount,
    required this.runtime,
    required this.tags,
    required this.synopsis,
  });

  final int id;
  final String title;
  final String genre;
  final int year;
  final String posterAsset;

  // 3주차에는 서버 없이 화면 표시용 Mock 값만 사용합니다.
  final double rating;
  final int reviewCount;
  final int runtime; // 분
  final List<String> tags;
  final String synopsis;
}

const movies = [
  Movie(
    id: 1,
    title: '별빛 아래 우리',
    genre: '드라마',
    year: 2024,
    posterAsset: 'assets/images/posters/hero_under_the_starlight.jpg',
    rating: 4.5,
    reviewCount: 1245,
    runtime: 124,
    tags: ['로맨스', '드라마', '감동적인'],
    synopsis:
        '바쁜 현대 사회 속에서 서로의 존재를 잊고 살아가던 두 남녀가 우연한 계기로 '
        '작은 천문대에서 만나게 됩니다. 매일 밤 별을 관측하며 서로의 상처를 치유하고, '
        '잊고 있던 꿈과 사랑을 다시금 깨닫게 되는 따뜻한 이야기입니다.\n\n'
        '과거의 아픔으로 인해 사람에게 마음을 열지 못하던 여주인공은, 별자리처럼 '
        '변함없는 모습으로 자신을 기다려주는 남주인공을 통해 서서히 마음의 문을 열게 '
        '됩니다. 하지만 두 사람 앞에 놓인 현실적인 장벽들은 그들의 관계를 시험하게 '
        '되는데...\n\n'
        '별이 쏟아지는 밤하늘 아래, 그들이 나눈 조용한 약속들은 과연 영원할 수 '
        '있을까요? 눈부신 영상미와 감성적인 OST가 어우러져 깊은 여운을 남기는 올 '
        '겨울 최고의 로맨스 영화.\n\n'
        '잔잔한 감동과 함께 삶의 의미를 다시 한번 되돌아보게 만드는 수작입니다.',
  ),
  Movie(
    id: 2,
    title: '우주의 끝에서',
    genre: 'SF',
    year: 2024,
    posterAsset: 'assets/images/posters/poster_echoes_of_the_void.jpg',
    rating: 4.2,
    reviewCount: 863,
    runtime: 138,
    tags: ['SF', '우주', '미스터리'],
    synopsis:
        '인류의 마지막 탐사선이 도착한 낯선 행성. 홀로 남겨진 우주비행사는 '
        '모래 폭풍 너머에서 정체를 알 수 없는 신호를 발견합니다.\n\n'
        '신호를 따라갈수록 드러나는 거대한 구조물의 비밀과, 지구에 남겨둔 '
        '가족에 대한 기억 사이에서 그는 돌아갈 수 없는 선택을 하게 됩니다.',
  ),
  Movie(
    id: 3,
    title: '기억의 숲',
    genre: '애니메이션',
    year: 2023,
    posterAsset: 'assets/images/posters/poster_whispering_woods.jpg',
    rating: 4.9,
    reviewCount: 2310,
    runtime: 102,
    tags: ['애니메이션', '판타지', '가족'],
    synopsis:
        '속삭이는 숲에 길을 잃은 소녀가 작은 숲의 정령을 만나 잊혀진 기억을 '
        '되찾아가는 모험을 그린 애니메이션.\n\n'
        '아름다운 색감과 따뜻한 음악이 어우러져 아이와 어른 모두에게 '
        '오래 남을 이야기를 선물합니다.',
  ),
  Movie(
    id: 4,
    title: '밤의 그림자',
    genre: '스릴러',
    year: 2024,
    posterAsset: 'assets/images/posters/poster_night_shadows.jpg',
    rating: 3.8,
    reviewCount: 541,
    runtime: 117,
    tags: ['스릴러', '범죄', '느와르'],
    synopsis:
        '비 내리는 도시의 뒷골목, 연쇄 실종 사건을 쫓던 형사는 사건의 중심에 '
        '자신의 과거가 얽혀 있다는 사실을 알게 됩니다.\n\n'
        '네온사인 아래 숨겨진 진실을 마주한 순간, 쫓는 자와 쫓기는 자의 경계가 '
        '무너지기 시작합니다.',
  ),
  Movie(
    id: 5,
    title: '네 번째 오후',
    genre: '로맨스',
    year: 2023,
    posterAsset: 'assets/images/posters/poster_fourth_afternoon.jpg',
    rating: 4.3,
    reviewCount: 978,
    runtime: 109,
    tags: ['로맨스', '일상', '힐링'],
    synopsis:
        '작은 카페에서 매주 같은 요일, 같은 시간에 마주치는 두 사람. '
        '네 번째 오후가 찾아왔을 때 두 사람은 처음으로 말을 건넵니다.\n\n'
        '커피 한 잔과 함께 천천히 쌓여가는 마음을 담백하게 그려낸 이야기.',
  ),
  Movie(
    id: 6,
    title: '미션 임프로버블',
    genre: '코미디',
    year: 2022,
    posterAsset: 'assets/images/posters/poster_abyss_walker.jpg',
    rating: 4.0,
    reviewCount: 1502,
    runtime: 121,
    tags: ['코미디', '액션', '첩보'],
    synopsis:
        '은퇴를 꿈꾸던 전설의 요원 맥스가 마지막 임무를 위해 다시 돌아왔습니다. '
        '하지만 이번 임무는 계획대로 되는 일이 하나도 없습니다.\n\n'
        '폭발보다 더 크게 터지는 웃음과 함께하는 유쾌한 첩보 액션 코미디.',
  ),
];

// 영화 목록의 장르 필터에서 사용하는 장르 목록
final genres = movies.map((movie) => movie.genre).toSet().toList();

Movie? findMovieById(int? id) {
  for (final movie in movies) {
    if (movie.id == id) return movie;
  }
  return null;
}
