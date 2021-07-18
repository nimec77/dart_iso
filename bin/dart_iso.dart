import 'dart:async';
import 'dart:isolate';

import 'smart_isolate.dart' as smart;
import 'test_class.dart';

StreamSubscription? streamSubscription;

Future<SendPort> initIsolate(Stream stream, SendPort sendPort) async {
  final completer = Completer<SendPort>();

  streamSubscription = stream.listen((data) {
    if (!completer.isCompleted && data is SendPort) {
      completer.complete(data);
      streamSubscription?.cancel();
    }
  });

  await Isolate.spawn(smart.smartIsolate, sendPort);

  return completer.future;
}

void main(List<String> arguments) async {
  final isolateToMainStream = ReceivePort();
  SendPort? mainToIsolateStream;

  final stream = isolateToMainStream.asBroadcastStream()
    ..listen((data) {
      if (data is SendPort) {
        return;
      }
      print('[isolateToMainStream] $data');
      if (data is TestClass) {
        mainToIsolateStream?.send(data.add(2));
      } else if (data is Stream) {
        data.forEach(print);
      }
    });

  mainToIsolateStream = await initIsolate(stream, isolateToMainStream.sendPort);

  mainToIsolateStream.send('This is from main()');
}
