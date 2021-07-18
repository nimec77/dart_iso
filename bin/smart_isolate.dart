import 'dart:isolate';

import 'test_class.dart';

void smartIsolate(SendPort isolateToMainStream) {
  final mainToIsolateStream = ReceivePort();
  isolateToMainStream.send(mainToIsolateStream.sendPort);

  mainToIsolateStream.listen((data) {
    print('[mainToIsolateStream] $data');
  });

  isolateToMainStream.send(TestClass(40));
}
