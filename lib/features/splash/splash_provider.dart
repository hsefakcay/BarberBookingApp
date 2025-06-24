import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashState {
  SplashState({
    this.isRequiredForceUpdate,
    this.isRedirectHome,
  });

  final bool? isRequiredForceUpdate;
  final bool? isRedirectHome;

  List<Object?> get props => [isRequiredForceUpdate];

  SplashState copyWith({
    bool? isReaquiredForceUpdate,
    bool? isRedirectHome,
  }) {
    return SplashState(
      isRequiredForceUpdate: isReaquiredForceUpdate ?? isRequiredForceUpdate,
      isRedirectHome: isRedirectHome ?? this.isRedirectHome,
    );
  }
}

class SplashProvider extends StateNotifier<SplashState> {
  SplashProvider() : super(SplashState());

  Future<void> checkSplashState() async {
    await Future.delayed(const Duration(seconds: 7), () {});
    // Simüle edilmiş bir gecikme
    state = SplashState().copyWith(
      isRedirectHome: true,
    );
  }
}
