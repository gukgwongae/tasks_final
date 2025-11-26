import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasks/data/model/weather_model.dart';
import 'package:tasks/domain/repository/weather_repository.dart';

part 'weather_info_view_model.g.dart';

@riverpod
class WeatherInfoViewModel extends _$WeatherInfoViewModel {
  final WeatherRepository weatherRepository = WeatherRepository();

  @override
  Future<WeatherModel> build() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    final position = await Geolocator.getCurrentPosition();
    final weather = await weatherRepository.fetchWeather(
      position.latitude,
      position.longitude,
    );
    return weather;
  }
}
