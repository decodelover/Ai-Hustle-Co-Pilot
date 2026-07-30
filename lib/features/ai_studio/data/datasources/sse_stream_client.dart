/// Real-time SSE Stream Client & Throttling Transformer (Amendment 3.1B)
library;

import 'dart:async';

/// Helper client managing Server-Sent Event (SSE) streaming connections and frame-budget throttling.
final class SseStreamClient {
  /// Throttles incoming high-frequency text tokens into 16ms frame windows.
  ///
  /// Prevents high-frequency micro-updates from overwhelming the Flutter UI main thread,
  /// guaranteeing continuous 60/120 FPS rendering during rapid LLM generation.
  static Stream<String> frameThrottle(Stream<String> sourceStream) {
    late StreamController<String> controller;
    Timer? frameTimer;
    final buffer = StringBuffer();
    StreamSubscription<String>? subscription;

    controller = StreamController<String>(
      onListen: () {
        subscription = sourceStream.listen(
          (chunk) {
            buffer.write(chunk);
            frameTimer ??= Timer.periodic(
              const Duration(milliseconds: 16),
              (_) {
                if (buffer.isNotEmpty) {
                  controller.add(buffer.toString());
                  buffer.clear();
                }
              },
            );
          },
          onError: (Object error, StackTrace st) {
            controller.addError(error, st);
          },
          onDone: () {
            frameTimer?.cancel();
            if (buffer.isNotEmpty) {
              controller.add(buffer.toString());
              buffer.clear();
            }
            controller.close();
          },
        );
      },
      onCancel: () {
        frameTimer?.cancel();
        subscription?.cancel();
      },
    );

    return controller.stream;
  }
}
