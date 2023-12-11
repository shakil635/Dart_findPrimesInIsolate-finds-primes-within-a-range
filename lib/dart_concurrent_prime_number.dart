/// Support for doing something awesome.
///
/// More dartdocs go here.
library;

export 'src/dart_concurrent_prime_number_base.dart';

// TODO: Export any libraries intended for clients of this package.

import 'dart:async';
import 'dart:isolate';

Future<List<int>> findPrimesInIsolate(int start, int end) async {
  final receive = ReceivePort();
  final completer = Completer<List<int>>();
  final isolate = await Isolate.spawn(calPrime, [receive.sendPort, start, end]);
  completer.complete(await receive.first);
  receive.close();
  isolate.kill();
  return completer.future;
}

calPrime(List<dynamic> input) async {
  SendPort sendport = input[0] as SendPort;
  int start = input[1] as int;
  int end = input[2] as int;
  List<int> newList = [];
  for (var i = start; i <= end; i++) {
    if (isPrime(i)) {
      newList.add(i);
    }
  }
  sendport.send(newList);
  Isolate.exit(sendport);
}

bool isPrime(int input) {
  if (input < 2) {
    return false;
  }
  for (var i = 2; i <= input / 2; i++) {
    if (input % i == 0) {
      return false;
    }
  }
  return true;
}
/*
Practice Question 1: Concurrent Prime Number Finder
Task:
Create a function findPrimesInIsolate that 
takes two integers, start and end, 
and finds all prime numbers in that 
range using a separate isolate. 
The function should return a 
Future<List<int>> with the list
 of primes found.
 */