import 'dart:async';
import 'dart:math';

class ReaderWriterProblem {
  int resource = 0;
  int readersCount = 0;
  bool isWriting = false;
  final StreamController<int> _readerController =
      StreamController<int>.broadcast();
  final StreamController<int> _writerController =
      StreamController<int>.broadcast();

  Future<void> read(int readerId) async {
    await for (int _ in _readerController.stream) {
      readersCount++;
      if (readersCount == 1) {
        await _writerController.stream.first;
      }
      print('Reader $readerId is reading resource: $resource');
      await Future.delayed(Duration(milliseconds: Random().nextInt(500) + 100));
      readersCount--;
      if (readersCount == 0) {
        _writerController.add(0);
      }
      await Future.delayed(Duration(milliseconds: Random().nextInt(500) + 100));
    }
  }

  Future<void> write(int writerId) async {
    await for (int _ in _writerController.stream) {
      isWriting = true;
      resource++;
      print('Writer $writerId is writing resource: $resource');
      await Future.delayed(Duration(milliseconds: Random().nextInt(500) + 100));
      isWriting = false;
      _readerController.add(0);
      await Future.delayed(Duration(milliseconds: Random().nextInt(500) + 100));
    }
  }

  void start() {
    for (int i = 0; i < 5; i++) {
      read(i);
    }
    for (int i = 0; i < 2; i++) {
      write(i);
    }
    _readerController.add(0);
  }
}

void main() {
  final rwProblem = ReaderWriterProblem();
  rwProblem.start();
}
