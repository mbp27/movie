import 'package:movie/environment.dart';
import 'package:movie/main_common.dart';

Future<void> main() async {
  await mainCommon(Environment.development);
}
