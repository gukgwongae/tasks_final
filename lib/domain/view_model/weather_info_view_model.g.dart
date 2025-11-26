// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_info_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WeatherInfoViewModel)
const weatherInfoViewModelProvider = WeatherInfoViewModelProvider._();

final class WeatherInfoViewModelProvider
    extends $AsyncNotifierProvider<WeatherInfoViewModel, WeatherModel> {
  const WeatherInfoViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weatherInfoViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weatherInfoViewModelHash();

  @$internal
  @override
  WeatherInfoViewModel create() => WeatherInfoViewModel();
}

String _$weatherInfoViewModelHash() =>
    r'29c4d9264528d303a93b0dfd4b4e5d4ae73b4e25';

abstract class _$WeatherInfoViewModel extends $AsyncNotifier<WeatherModel> {
  FutureOr<WeatherModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<WeatherModel>, WeatherModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<WeatherModel>, WeatherModel>,
              AsyncValue<WeatherModel>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
