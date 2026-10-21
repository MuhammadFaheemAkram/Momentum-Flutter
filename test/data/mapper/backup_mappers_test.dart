import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:momentum/core/network/dto/backup_dto.dart';
import 'package:momentum/data/mapper/backup_mappers.dart';

import '../../helpers/user_data_fixtures.dart';

void main() {
  BackupDto overTheWire(BackupDto backup) => BackupDto.fromJson(
    jsonDecode(jsonEncode(backup.toJson())) as Map<String, dynamic>,
  );

  test('every field survives a round trip through the backup JSON', () {
    final data = fullUserData();

    final backup = overTheWire(data.toBackupDto(exportedAt: fixtureAt));

    expect(backup.toUserData(), data);
    expect(backup.exportedAt, fixtureAt);
    expect(backup.formatVersion, BackupDto.currentFormat);
  });

  test('days, times and instants leave as text, instants in UTC', () {
    final json = fullUserData()
        .toBackupDto(exportedAt: DateTime(2026, 10, 21, 15))
        .toJson();
    final habits = json['habits'] as List<dynamic>;
    final water = habits.first as Map<String, dynamic>;

    expect(water['startDate'], '2026-09-21');
    expect(water['reminder'], '10:00');
    expect(water['createdAt'], '2026-10-21T13:00:00.000Z');
    expect(json['exportedAt'], endsWith('Z'));
  });

  test('a goal on all habits has no habit; weekdays are sorted', () {
    final backup = fullUserData().toBackupDto(exportedAt: fixtureAt);

    expect(backup.goals.first.habitId, isNull);
    expect(backup.goals.last.habitId, 'water');
    expect(backup.habits[1].weekdays, [1, 3, 5]);
  });

  test('a damaged backup is refused: a missing field, a bad day', () {
    final json = fullUserData().toBackupDto(exportedAt: fixtureAt).toJson();

    expect(
      () => BackupDto.fromJson(Map.of(json)..remove('habits')),
      throwsA(isA<CheckedFromJsonException>()),
    );
    final badDay = BackupDto.fromJson(
      jsonDecode(jsonEncode(json).replaceFirst('2026-09-21', '21/09/2026'))
          as Map<String, dynamic>,
    );
    expect(badDay.toUserData, throwsFormatException);
  });
}
