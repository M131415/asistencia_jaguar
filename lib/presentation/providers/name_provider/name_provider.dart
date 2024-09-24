import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'name_provider.g.dart';

@riverpod
String showName(ShowNameRef ref){
  return 'Mauricio';
}