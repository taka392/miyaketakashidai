import 'dart:io';

bool isLeapYear(int year) {
  if (year % 4 == 0) {
    if (year % 100 == 0 && year % 400 != 0) {
      return false;
    }
    return true;
  }
  return false;
}

void main() {
  for (var i = 0; i < 3; i++) {
    stdout.write('西暦を入力してください: ');
    final year = int.parse(stdin.readLineSync()!);
    if (isLeapYear(year)) {
      print('isLeapYear(Year: $year)// true');
    } else {
      print('isLeapYear(Year: $year)// false');
    }
  }
}
