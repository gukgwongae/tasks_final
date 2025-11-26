import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tasks/core/app_theme.dart';
import 'package:tasks/domain/view_model/weather_info_view_model.dart';

class WeatherInfo extends ConsumerWidget {
  const WeatherInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final geoInfo = ref.watch(weatherInfoViewModelProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          color: vrc(context).background200,
          child: geoInfo.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('$e')),
            data: (weatherInfo) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 12,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 12,
                  children: [
                    Text(
                      DateFormat(
                        '업데이트 시간 : yy년 MM월 dd일 HH시 mm분',
                      ).format(weatherInfo.time),
                      style: TextStyle(
                        color: vrc(context).textColor100,
                        fontSize: 16,
                      ),
                    ),
                    Icon(
                      weatherInfo.isDay == 1
                          ? Icons.sunny
                          : Icons.nightlight_round,
                      color: vrc(context).textColor100,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 12,
                  children: [
                    Text(
                      '날씨: ${weatherInfo.weatherDescription}',
                      style: TextStyle(
                        color: vrc(context).textColor100,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '온도: ${weatherInfo.temperature.toString()}°C',
                      style: TextStyle(
                        color: vrc(context).textColor100,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '풍속: ${weatherInfo.windSpeed.toString()}m/s',
                      style: TextStyle(
                        color: vrc(context).textColor100,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).padding.bottom,
          color: vrc(context).background200,
        ),
      ],
    );
  }
}
