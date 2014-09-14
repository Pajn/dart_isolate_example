import 'dart:isolate';

main(_, SendPort sendPort) {
    var receivePort = new ReceivePort();

    receivePort.listen((String message) {
        if (message is String) {
            var reversedMessage = message.split('').reversed.join('');
            sendPort.send(reversedMessage);
        }
    });

    sendPort.send(receivePort.sendPort);
}
