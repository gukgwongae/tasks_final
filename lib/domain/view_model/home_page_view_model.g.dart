// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomePageViewModel)
const homePageViewModelProvider = HomePageViewModelProvider._();

final class HomePageViewModelProvider
    extends $AsyncNotifierProvider<HomePageViewModel, List<ToDoModel>> {
  const HomePageViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homePageViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homePageViewModelHash();

  @$internal
  @override
  HomePageViewModel create() => HomePageViewModel();
}

String _$homePageViewModelHash() => r'4c8daf0a54b8cd67b1ae89a8343ad3ff2ab39646';

abstract class _$HomePageViewModel extends $AsyncNotifier<List<ToDoModel>> {
  FutureOr<List<ToDoModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<ToDoModel>>, List<ToDoModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ToDoModel>>, List<ToDoModel>>,
              AsyncValue<List<ToDoModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
