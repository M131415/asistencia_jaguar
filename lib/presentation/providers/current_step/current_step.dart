import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_step.g.dart';

@riverpod
class CurrentStep extends _$CurrentStep {
  @override
  int build() {
    return 0;
  }

  void onStepTapped(int newIndex){
    state = newIndex;
  }

  void onStepContinue(){
    if (state < 3){
      state++;
    }
  }

  void onStepCancel(){
    if (state != 0){
      state--;
    }
  }

}