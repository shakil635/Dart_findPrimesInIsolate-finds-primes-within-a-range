import 'package:dart_concurrent_prime_number/dart_concurrent_prime_number.dart';
import 'package:test/test.dart';

void main() {
  test('findPrimesInIsolate finds primes within a range', () async {
    var primes = await findPrimesInIsolate(10, 20);
    expect(primes, equals([11, 13, 17, 19]));
  });

  test('findPrimesInIsolate handles range with no primes', () async {
    var primes = await findPrimesInIsolate(26, 28);
    expect(primes, isEmpty);
  });

  test('findPrimesInIsolate handles large range', () async {
    var primes = await findPrimesInIsolate(1, 50);
    // Expected primes in the range
    expect(primes,
        equals([2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]));
  });
}
