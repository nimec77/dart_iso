class TestClass {
  TestClass(this.a);

  final int a;

  TestClass add(int b) {
    return TestClass(a + b);
  }

  @override
  String toString() => '{a:$a}';

  @override
  int get hashCode => a.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is TestClass && a == other.a;
  }
}
