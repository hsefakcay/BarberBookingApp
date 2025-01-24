import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashState {
  SplashState({
    this.isReaquiredForceUpdate,
    this.isRedirectHome,
  });

  final bool? isReaquiredForceUpdate;
  final bool? isRedirectHome;

  List<Object?> get props => [isReaquiredForceUpdate];

  SplashState copyWith({
    bool? isReaquiredForceUpdate,
    bool? isRedirectHome,
  }) {
    return SplashState(
      isReaquiredForceUpdate: isReaquiredForceUpdate ?? this.isReaquiredForceUpdate,
      isRedirectHome: isRedirectHome ?? this.isRedirectHome,
    );
  }
}

class SplashProvider extends StateNotifier<SplashState> {
  SplashProvider() : super(SplashState());

  Future<void> checkSplashState() async {
    await Future.delayed(const Duration(seconds: 5), () {});
    // Simüle edilmiş bir gecikme
    state = SplashState().copyWith(
      isRedirectHome: true,
    );
  }
}
