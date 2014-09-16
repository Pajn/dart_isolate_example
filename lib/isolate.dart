import 'dart:async';
import 'dart:isolate';
import 'dart:io';

main(args, SendPort sendPort) {
    var receivePort = new ReceivePort();

    receivePort.listen((String message) {
        if (message is String) {
            var reversedMessage = message.split('').reversed.join('');
            sendPort.send(reversedMessage + ' ${args.first}');
        }
    });

    sendPort.send(receivePort.sendPort);

    new Timer.periodic(const Duration(seconds: 1), (_) {
        print('Hello Isolate ${args.first}');
    });

    if (args.first != 12) {
        var start = new DateTime.now();
        var num = 1.01276452783498;
        for (int i = 0; i < 1000000000; i++) {
            num *= num;
        }
        print(num);
        print(new DateTime.now().difference(start));
    }

}
