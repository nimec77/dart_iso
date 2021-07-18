import 'dart:isolate';

void smartIsolate(SendPort isolateToMainStream) {
    final mainToIsolateStream = ReceivePort();
    isolateToMainStream.send(mainToIsolateStream.sendPort);

    mainToIsolateStream.listen((data) {
      print('[mainToIsolateStream] $data');
    });

    isolateToMainStream.send('This is from isolate');
  }
