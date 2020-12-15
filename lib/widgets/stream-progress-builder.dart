import 'package:flutter/material.dart';

typedef ProgressWidgetBuilder<T> = Widget Function(BuildContext context, T data);

class StreamProgressBuilder<T> extends StreamBuilder<T> {
  StreamProgressBuilder({Key key, Stream<T> stream, ProgressWidgetBuilder<T> builder})
      : super(
            key: key,
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return builder(context, snapshot.data);
              }

              return CircularProgressIndicator();
            });
}
