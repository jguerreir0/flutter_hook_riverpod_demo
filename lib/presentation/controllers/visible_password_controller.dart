import 'package:hooks_riverpod/hooks_riverpod.dart';

class VisiblePasswordController extends StateNotifier<bool> {
  VisiblePasswordController() : super(false);

  void onTap(bool value) {
    state = value;
  }
}
