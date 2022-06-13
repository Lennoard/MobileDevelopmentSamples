import 'package:flutter/cupertino.dart';
import 'package:q01/textformat/text_spans.dart';

class SpanBuilder {
  static TextStyle buildSpan(Set<TextFormatSpan> spans) {
    TextStyle style = const TextStyle(fontSize: 32);

    for (var span in spans) {
      if (span == TextFormatSpan.bold) {
        style = style.merge(const TextStyle(fontWeight: FontWeight.bold));
      }

      if (span == TextFormatSpan.italic) {
        style = style.merge(const TextStyle(fontStyle: FontStyle.italic));
      }

      if (span == TextFormatSpan.underline) {
        style = style.merge(const TextStyle(decoration: TextDecoration.underline));
      }
    }

    return style;
  }
}
