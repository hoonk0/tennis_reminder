
enum EnumLoginType {
  apple,
  kakao,
  naver,
  google
}

enum UserGrade {
  admin,
  guest
}

// 영어로 된 enum 정의
enum SeoulDistrict {
  Gangnam,
  Gangdong,
  Gangbuk,
  Gangseo,
  Gwanak,
  Gwangjin,
  Guro,
  Geumcheon,
  Nowon,
  Dobong,
  Dongdaemun,
  Dongjak,
  Mapo,
  Seodaemun,
  Seocho,
  Seongdong,
  Seongbuk,
  Songpa,
  Yangcheon,
  Yeongdeungpo,
  Yongsan,
  Eunpyeong,
  Jongno,
  Jung,
  Jungnang,
}

// 영어 이름을 한국어로 변환하는 Map
const Map<SeoulDistrict, String> seoulDistrictKorean = {
  SeoulDistrict.Gangnam: '강남구',
  SeoulDistrict.Gangdong: '강동구',
  SeoulDistrict.Jongno: '종로구',
  SeoulDistrict.Jung: '중구',
  SeoulDistrict.Yongsan: '용산구',
  SeoulDistrict.Seongdong: '성동구',
  SeoulDistrict.Gwangjin: '광진구',
  SeoulDistrict.Dongdaemun: '동대문구',
  SeoulDistrict.Jungnang: '중랑구',
  SeoulDistrict.Seongbuk: '성북구',
  SeoulDistrict.Gangbuk: '강북구',
  SeoulDistrict.Dobong: '도봉구',
  SeoulDistrict.Nowon: '노원구',
  SeoulDistrict.Eunpyeong: '은평구',
  SeoulDistrict.Seodaemun: '서대문구',
  SeoulDistrict.Mapo: '마포구',
  SeoulDistrict.Yangcheon: '양천구',
  SeoulDistrict.Gangseo: '강서구',
  SeoulDistrict.Guro: '구로구',
  SeoulDistrict.Geumcheon: '금천구',
  SeoulDistrict.Yeongdeungpo: '영등포구',
  SeoulDistrict.Dongjak: '동작구',
  SeoulDistrict.Gwanak: '관악구',
  SeoulDistrict.Seocho: '서초구',
  SeoulDistrict.Songpa: '송파구',

};


// UserGrade.admin.name : "admin"
// UserGrade.client.name : "Client"
//분류할 때 사용