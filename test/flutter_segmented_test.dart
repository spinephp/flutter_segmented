import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_segmented/flutter_segmented.dart';

void main() {
  test('adds one to input values', () {
    final segment = SegmentBar(
      titleNames: ["One", "Two"],
      onSelectChanged: (int index) => print("$index"),
    );
    expect(segment.titleNames, ["One", "Two"]);
  });
}
