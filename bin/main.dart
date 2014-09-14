import 'dart:io';
import 'dart:isolate';

main(List<String> args) {
    if (args.length < 1) {
        print ('A message to pass to the isolate is needed');
        exit(1);
    }
    var userMessage = args.join(' ');

    var receivePort = new ReceivePort();
    var uri = new Uri.file('../lib/isolate.dart');
    Isolate.spawnUri(uri, [], receivePort.sendPort);
    SendPort sendPort;

    receivePort.listen((message) {
        if (sendPort == null && message is SendPort) {
            sendPort = message;
            sendPort.send(userMessage);
        } else if (message is String) {
            print(message);
            exit(0);
        }
    });
}
