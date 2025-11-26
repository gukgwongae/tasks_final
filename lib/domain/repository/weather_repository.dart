import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tasks/data/model/weather_model.dart';

/// Open-Meteo API를 통해 현재 날씨 데이터를 가져오는 리포지토리
class WeatherRepository {
  static const String _baseUrl = 'https://api.open-meteo.com/v1/forecast';

  Future<WeatherModel> fetchWeather(double latitude, double longitude) async {
    final uri = Uri.parse(
      '$_baseUrl?latitude=$latitude&longitude=$longitude'
      '&timezone=auto&current=temperature_2m,is_day,wind_speed_10m,weather_code',
    );

    try {
      // 타임아웃 추가 (네트워크 지연 대비)
      final response = await http.get(uri).timeout(const Duration(seconds: 10));

      // 상태 코드 확인
      if (response.statusCode != 200) {
        throw Exception(
          'Open-Meteo 요청 실패\n'
          'Status: ${response.statusCode}\n'
          'Message: ${response.reasonPhrase ?? '알 수 없음'}',
        );
      }

      final jsonBody = jsonDecode(response.body) as Map<String, dynamic>;

      // 응답 유효성 검사
      if (jsonBody['current'] == null) {
        throw Exception('응답에 current 필드가 없습니다. (API 구조 변경 가능성)');
      }

      // JSON → 모델 변환
      return WeatherModel.fromJson(jsonBody['current']);
    } on FormatException {
      throw Exception('JSON 파싱 실패: 응답 형식이 잘못되었습니다.');
    } on http.ClientException {
      throw Exception('네트워크 연결 오류: 인터넷 연결을 확인하세요.');
    } on Exception catch (e) {
      // 기타 모든 예외
      throw Exception('Open-Meteo 호출 실패: $e');
    }
  }
}
