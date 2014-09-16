import 'dart:async';
import 'dart:io';
import 'dart:isolate';

main(List<String> args) {
    if (args.length < 1) {
        print ('A message to pass to the isolate is needed');
        exit(1);
    }
    var userMessage = args.join(' ');

    var receivePort = new ReceivePort();
    var receivePort2 = new ReceivePort();
    var uri = new Uri.file('../lib/isolate.dart');
    Isolate.spawnUri(uri, [1], receivePort.sendPort);
    Isolate.spawnUri(uri, [2], receivePort2.sendPort);
    SendPort sendPort;
    SendPort sendPort2;

    receivePort.listen((message) {
        if (sendPort == null && message is SendPort) {
            sendPort = message;
            sendPort.send(userMessage);
        } else if (message is String) {
            print(message);
        }
    });

    receivePort2.listen((message) {
        if (sendPort2 == null && message is SendPort) {
            sendPort2 = message;
            sendPort2.send(userMessage);
        } else if (message is String) {
            print(message);
        }
    });

    print('from main thread');

    new Timer.periodic(const Duration(seconds: 1), (_) {
        print('Hello from the main Isolate');
    });

    print('last in main thread');
}
