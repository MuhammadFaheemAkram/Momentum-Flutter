// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'app_database.dart';

// ignore_for_file: type=lint
class $HabitsTable extends Habits with TableInfo<$HabitsTable, HabitRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  late final GeneratedColumnWithTypeConverter<HabitCategory, String> category =
      GeneratedColumn<String>(
        'category',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<HabitCategory>($HabitsTable.$convertercategory);
  @override
  late final GeneratedColumnWithTypeConverter<HabitColor, String> color =
      GeneratedColumn<String>(
        'color',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<HabitColor>($HabitsTable.$convertercolor);
  @override
  late final GeneratedColumnWithTypeConverter<HabitIcon, String> icon =
      GeneratedColumn<String>(
        'icon',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<HabitIcon>($HabitsTable.$convertericon);
  @override
  late final GeneratedColumnWithTypeConverter<ScheduleType, String>
  scheduleType = GeneratedColumn<String>(
    'schedule_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<ScheduleType>($HabitsTable.$converterscheduleType);
  static const VerificationMeta _weekdaysMeta = const VerificationMeta(
    'weekdays',
  );
  @override
  late final GeneratedColumn<int> weekdays = GeneratedColumn<int>(
    'weekdays',
    aliasedName,
    false,
    check: () => ComparableExpr(weekdays).isBetweenValues(0, 127),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _timesPerWeekMeta = const VerificationMeta(
    'timesPerWeek',
  );
  @override
  late final GeneratedColumn<int> timesPerWeek = GeneratedColumn<int>(
    'times_per_week',
    aliasedName,
    true,
    check: () => ComparableExpr(timesPerWeek).isBetweenValues(1, 6),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dailyTargetMeta = const VerificationMeta(
    'dailyTarget',
  );
  @override
  late final GeneratedColumn<int> dailyTarget = GeneratedColumn<int>(
    'daily_target',
    aliasedName,
    false,
    check: () => ComparableExpr(dailyTarget).isBetweenValues(1, 20),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<CalendarDate, int> startDate =
      GeneratedColumn<int>(
        'start_date',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<CalendarDate>($HabitsTable.$converterstartDate);
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDayValue?, String>
  reminderTime = GeneratedColumn<String>(
    'reminder_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<TimeOfDayValue?>($HabitsTable.$converterreminderTimen);
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    category,
    color,
    icon,
    scheduleType,
    weekdays,
    timesPerWeek,
    dailyTarget,
    startDate,
    reminderTime,
    archivedAt,
    createdAt,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('weekdays')) {
      context.handle(
        _weekdaysMeta,
        weekdays.isAcceptableOrUnknown(data['weekdays']!, _weekdaysMeta),
      );
    }
    if (data.containsKey('times_per_week')) {
      context.handle(
        _timesPerWeekMeta,
        timesPerWeek.isAcceptableOrUnknown(
          data['times_per_week']!,
          _timesPerWeekMeta,
        ),
      );
    }
    if (data.containsKey('daily_target')) {
      context.handle(
        _dailyTargetMeta,
        dailyTarget.isAcceptableOrUnknown(
          data['daily_target']!,
          _dailyTargetMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dailyTargetMeta);
    }
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      category: $HabitsTable.$convertercategory.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}category'],
        )!,
      ),
      color: $HabitsTable.$convertercolor.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}color'],
        )!,
      ),
      icon: $HabitsTable.$convertericon.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}icon'],
        )!,
      ),
      scheduleType: $HabitsTable.$converterscheduleType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}schedule_type'],
        )!,
      ),
      weekdays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekdays'],
      )!,
      timesPerWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}times_per_week'],
      ),
      dailyTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily_target'],
      )!,
      startDate: $HabitsTable.$converterstartDate.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}start_date'],
        )!,
      ),
      reminderTime: $HabitsTable.$converterreminderTimen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}reminder_time'],
        ),
      ),
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<HabitCategory, String, String> $convertercategory =
      const EnumNameConverter<HabitCategory>(HabitCategory.values);
  static JsonTypeConverter2<HabitColor, String, String> $convertercolor =
      const EnumNameConverter<HabitColor>(HabitColor.values);
  static JsonTypeConverter2<HabitIcon, String, String> $convertericon =
      const EnumNameConverter<HabitIcon>(HabitIcon.values);
  static JsonTypeConverter2<ScheduleType, String, String>
  $converterscheduleType = const EnumNameConverter<ScheduleType>(
    ScheduleType.values,
  );
  static TypeConverter<CalendarDate, int> $converterstartDate =
      const CalendarDateConverter();
  static TypeConverter<TimeOfDayValue, String> $converterreminderTime =
      const TimeOfDayConverter();
  static TypeConverter<TimeOfDayValue?, String?> $converterreminderTimen =
      NullAwareTypeConverter.wrap($converterreminderTime);
}

class HabitRow extends DataClass implements Insertable<HabitRow> {
  final String id;
  final String title;
  final String description;
  final HabitCategory category;
  final HabitColor color;
  final HabitIcon icon;
  final ScheduleType scheduleType;

  /// For `onWeekdays`: one bit per day, Monday = 1, Tuesday = 2, … Sunday =
  /// 64. A bitmask keeps the schedule in its row, and a weekday test is one
  /// `&`. Zero for the other schedules.
  final int weekdays;

  /// For `timesPerWeek`: 1–6 (seven a week is `daily`). Null otherwise.
  final int? timesPerWeek;
  final int dailyTarget;
  final CalendarDate startDate;
  final TimeOfDayValue? reminderTime;
  final DateTime? archivedAt;
  final DateTime createdAt;
  final int sortOrder;
  const HabitRow({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.color,
    required this.icon,
    required this.scheduleType,
    required this.weekdays,
    this.timesPerWeek,
    required this.dailyTarget,
    required this.startDate,
    this.reminderTime,
    this.archivedAt,
    required this.createdAt,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    {
      map['category'] = Variable<String>(
        $HabitsTable.$convertercategory.toSql(category),
      );
    }
    {
      map['color'] = Variable<String>(
        $HabitsTable.$convertercolor.toSql(color),
      );
    }
    {
      map['icon'] = Variable<String>($HabitsTable.$convertericon.toSql(icon));
    }
    {
      map['schedule_type'] = Variable<String>(
        $HabitsTable.$converterscheduleType.toSql(scheduleType),
      );
    }
    map['weekdays'] = Variable<int>(weekdays);
    if (!nullToAbsent || timesPerWeek != null) {
      map['times_per_week'] = Variable<int>(timesPerWeek);
    }
    map['daily_target'] = Variable<int>(dailyTarget);
    {
      map['start_date'] = Variable<int>(
        $HabitsTable.$converterstartDate.toSql(startDate),
      );
    }
    if (!nullToAbsent || reminderTime != null) {
      map['reminder_time'] = Variable<String>(
        $HabitsTable.$converterreminderTimen.toSql(reminderTime),
      );
    }
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      category: Value(category),
      color: Value(color),
      icon: Value(icon),
      scheduleType: Value(scheduleType),
      weekdays: Value(weekdays),
      timesPerWeek: timesPerWeek == null && nullToAbsent
          ? const Value.absent()
          : Value(timesPerWeek),
      dailyTarget: Value(dailyTarget),
      startDate: Value(startDate),
      reminderTime: reminderTime == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderTime),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
      createdAt: Value(createdAt),
      sortOrder: Value(sortOrder),
    );
  }

  factory HabitRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      category: $HabitsTable.$convertercategory.fromJson(
        serializer.fromJson<String>(json['category']),
      ),
      color: $HabitsTable.$convertercolor.fromJson(
        serializer.fromJson<String>(json['color']),
      ),
      icon: $HabitsTable.$convertericon.fromJson(
        serializer.fromJson<String>(json['icon']),
      ),
      scheduleType: $HabitsTable.$converterscheduleType.fromJson(
        serializer.fromJson<String>(json['scheduleType']),
      ),
      weekdays: serializer.fromJson<int>(json['weekdays']),
      timesPerWeek: serializer.fromJson<int?>(json['timesPerWeek']),
      dailyTarget: serializer.fromJson<int>(json['dailyTarget']),
      startDate: serializer.fromJson<CalendarDate>(json['startDate']),
      reminderTime: serializer.fromJson<TimeOfDayValue?>(json['reminderTime']),
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'category': serializer.toJson<String>(
        $HabitsTable.$convertercategory.toJson(category),
      ),
      'color': serializer.toJson<String>(
        $HabitsTable.$convertercolor.toJson(color),
      ),
      'icon': serializer.toJson<String>(
        $HabitsTable.$convertericon.toJson(icon),
      ),
      'scheduleType': serializer.toJson<String>(
        $HabitsTable.$converterscheduleType.toJson(scheduleType),
      ),
      'weekdays': serializer.toJson<int>(weekdays),
      'timesPerWeek': serializer.toJson<int?>(timesPerWeek),
      'dailyTarget': serializer.toJson<int>(dailyTarget),
      'startDate': serializer.toJson<CalendarDate>(startDate),
      'reminderTime': serializer.toJson<TimeOfDayValue?>(reminderTime),
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  HabitRow copyWith({
    String? id,
    String? title,
    String? description,
    HabitCategory? category,
    HabitColor? color,
    HabitIcon? icon,
    ScheduleType? scheduleType,
    int? weekdays,
    Value<int?> timesPerWeek = const Value.absent(),
    int? dailyTarget,
    CalendarDate? startDate,
    Value<TimeOfDayValue?> reminderTime = const Value.absent(),
    Value<DateTime?> archivedAt = const Value.absent(),
    DateTime? createdAt,
    int? sortOrder,
  }) => HabitRow(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    category: category ?? this.category,
    color: color ?? this.color,
    icon: icon ?? this.icon,
    scheduleType: scheduleType ?? this.scheduleType,
    weekdays: weekdays ?? this.weekdays,
    timesPerWeek: timesPerWeek.present ? timesPerWeek.value : this.timesPerWeek,
    dailyTarget: dailyTarget ?? this.dailyTarget,
    startDate: startDate ?? this.startDate,
    reminderTime: reminderTime.present ? reminderTime.value : this.reminderTime,
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
    createdAt: createdAt ?? this.createdAt,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  HabitRow copyWithCompanion(HabitsCompanion data) {
    return HabitRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      category: data.category.present ? data.category.value : this.category,
      color: data.color.present ? data.color.value : this.color,
      icon: data.icon.present ? data.icon.value : this.icon,
      scheduleType: data.scheduleType.present
          ? data.scheduleType.value
          : this.scheduleType,
      weekdays: data.weekdays.present ? data.weekdays.value : this.weekdays,
      timesPerWeek: data.timesPerWeek.present
          ? data.timesPerWeek.value
          : this.timesPerWeek,
      dailyTarget: data.dailyTarget.present
          ? data.dailyTarget.value
          : this.dailyTarget,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      reminderTime: data.reminderTime.present
          ? data.reminderTime.value
          : this.reminderTime,
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('scheduleType: $scheduleType, ')
          ..write('weekdays: $weekdays, ')
          ..write('timesPerWeek: $timesPerWeek, ')
          ..write('dailyTarget: $dailyTarget, ')
          ..write('startDate: $startDate, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    category,
    color,
    icon,
    scheduleType,
    weekdays,
    timesPerWeek,
    dailyTarget,
    startDate,
    reminderTime,
    archivedAt,
    createdAt,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.category == this.category &&
          other.color == this.color &&
          other.icon == this.icon &&
          other.scheduleType == this.scheduleType &&
          other.weekdays == this.weekdays &&
          other.timesPerWeek == this.timesPerWeek &&
          other.dailyTarget == this.dailyTarget &&
          other.startDate == this.startDate &&
          other.reminderTime == this.reminderTime &&
          other.archivedAt == this.archivedAt &&
          other.createdAt == this.createdAt &&
          other.sortOrder == this.sortOrder);
}

class HabitsCompanion extends UpdateCompanion<HabitRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<HabitCategory> category;
  final Value<HabitColor> color;
  final Value<HabitIcon> icon;
  final Value<ScheduleType> scheduleType;
  final Value<int> weekdays;
  final Value<int?> timesPerWeek;
  final Value<int> dailyTarget;
  final Value<CalendarDate> startDate;
  final Value<TimeOfDayValue?> reminderTime;
  final Value<DateTime?> archivedAt;
  final Value<DateTime> createdAt;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.color = const Value.absent(),
    this.icon = const Value.absent(),
    this.scheduleType = const Value.absent(),
    this.weekdays = const Value.absent(),
    this.timesPerWeek = const Value.absent(),
    this.dailyTarget = const Value.absent(),
    this.startDate = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitsCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    required HabitCategory category,
    required HabitColor color,
    required HabitIcon icon,
    required ScheduleType scheduleType,
    this.weekdays = const Value.absent(),
    this.timesPerWeek = const Value.absent(),
    required int dailyTarget,
    required CalendarDate startDate,
    this.reminderTime = const Value.absent(),
    this.archivedAt = const Value.absent(),
    required DateTime createdAt,
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       category = Value(category),
       color = Value(color),
       icon = Value(icon),
       scheduleType = Value(scheduleType),
       dailyTarget = Value(dailyTarget),
       startDate = Value(startDate),
       createdAt = Value(createdAt),
       sortOrder = Value(sortOrder);
  static Insertable<HabitRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? category,
    Expression<String>? color,
    Expression<String>? icon,
    Expression<String>? scheduleType,
    Expression<int>? weekdays,
    Expression<int>? timesPerWeek,
    Expression<int>? dailyTarget,
    Expression<int>? startDate,
    Expression<String>? reminderTime,
    Expression<DateTime>? archivedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (color != null) 'color': color,
      if (icon != null) 'icon': icon,
      if (scheduleType != null) 'schedule_type': scheduleType,
      if (weekdays != null) 'weekdays': weekdays,
      if (timesPerWeek != null) 'times_per_week': timesPerWeek,
      if (dailyTarget != null) 'daily_target': dailyTarget,
      if (startDate != null) 'start_date': startDate,
      if (reminderTime != null) 'reminder_time': reminderTime,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? description,
    Value<HabitCategory>? category,
    Value<HabitColor>? color,
    Value<HabitIcon>? icon,
    Value<ScheduleType>? scheduleType,
    Value<int>? weekdays,
    Value<int?>? timesPerWeek,
    Value<int>? dailyTarget,
    Value<CalendarDate>? startDate,
    Value<TimeOfDayValue?>? reminderTime,
    Value<DateTime?>? archivedAt,
    Value<DateTime>? createdAt,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return HabitsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      scheduleType: scheduleType ?? this.scheduleType,
      weekdays: weekdays ?? this.weekdays,
      timesPerWeek: timesPerWeek ?? this.timesPerWeek,
      dailyTarget: dailyTarget ?? this.dailyTarget,
      startDate: startDate ?? this.startDate,
      reminderTime: reminderTime ?? this.reminderTime,
      archivedAt: archivedAt ?? this.archivedAt,
      createdAt: createdAt ?? this.createdAt,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(
        $HabitsTable.$convertercategory.toSql(category.value),
      );
    }
    if (color.present) {
      map['color'] = Variable<String>(
        $HabitsTable.$convertercolor.toSql(color.value),
      );
    }
    if (icon.present) {
      map['icon'] = Variable<String>(
        $HabitsTable.$convertericon.toSql(icon.value),
      );
    }
    if (scheduleType.present) {
      map['schedule_type'] = Variable<String>(
        $HabitsTable.$converterscheduleType.toSql(scheduleType.value),
      );
    }
    if (weekdays.present) {
      map['weekdays'] = Variable<int>(weekdays.value);
    }
    if (timesPerWeek.present) {
      map['times_per_week'] = Variable<int>(timesPerWeek.value);
    }
    if (dailyTarget.present) {
      map['daily_target'] = Variable<int>(dailyTarget.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<int>(
        $HabitsTable.$converterstartDate.toSql(startDate.value),
      );
    }
    if (reminderTime.present) {
      map['reminder_time'] = Variable<String>(
        $HabitsTable.$converterreminderTimen.toSql(reminderTime.value),
      );
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('scheduleType: $scheduleType, ')
          ..write('weekdays: $weekdays, ')
          ..write('timesPerWeek: $timesPerWeek, ')
          ..write('dailyTarget: $dailyTarget, ')
          ..write('startDate: $startDate, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HabitLogsTable extends HabitLogs
    with TableInfo<$HabitLogsTable, HabitLogRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habits (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<CalendarDate, int> day =
      GeneratedColumn<int>(
        'day',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<CalendarDate>($HabitLogsTable.$converterday);
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
    'count',
    aliasedName,
    false,
    check: () => ComparableExpr(count).isBiggerOrEqualValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _skippedMeta = const VerificationMeta(
    'skipped',
  );
  @override
  late final GeneratedColumn<bool> skipped = GeneratedColumn<bool>(
    'skipped',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("skipped" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [habitId, day, count, skipped];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitLogRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
        _countMeta,
        count.isAcceptableOrUnknown(data['count']!, _countMeta),
      );
    } else if (isInserting) {
      context.missing(_countMeta);
    }
    if (data.containsKey('skipped')) {
      context.handle(
        _skippedMeta,
        skipped.isAcceptableOrUnknown(data['skipped']!, _skippedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {habitId, day};
  @override
  HabitLogRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitLogRow(
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_id'],
      )!,
      day: $HabitLogsTable.$converterday.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}day'],
        )!,
      ),
      count: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}count'],
      )!,
      skipped: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}skipped'],
      )!,
    );
  }

  @override
  $HabitLogsTable createAlias(String alias) {
    return $HabitLogsTable(attachedDatabase, alias);
  }

  static TypeConverter<CalendarDate, int> $converterday =
      const CalendarDateConverter();
}

class HabitLogRow extends DataClass implements Insertable<HabitLogRow> {
  final String habitId;
  final CalendarDate day;
  final int count;
  final bool skipped;
  const HabitLogRow({
    required this.habitId,
    required this.day,
    required this.count,
    required this.skipped,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['habit_id'] = Variable<String>(habitId);
    {
      map['day'] = Variable<int>($HabitLogsTable.$converterday.toSql(day));
    }
    map['count'] = Variable<int>(count);
    map['skipped'] = Variable<bool>(skipped);
    return map;
  }

  HabitLogsCompanion toCompanion(bool nullToAbsent) {
    return HabitLogsCompanion(
      habitId: Value(habitId),
      day: Value(day),
      count: Value(count),
      skipped: Value(skipped),
    );
  }

  factory HabitLogRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitLogRow(
      habitId: serializer.fromJson<String>(json['habitId']),
      day: serializer.fromJson<CalendarDate>(json['day']),
      count: serializer.fromJson<int>(json['count']),
      skipped: serializer.fromJson<bool>(json['skipped']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'habitId': serializer.toJson<String>(habitId),
      'day': serializer.toJson<CalendarDate>(day),
      'count': serializer.toJson<int>(count),
      'skipped': serializer.toJson<bool>(skipped),
    };
  }

  HabitLogRow copyWith({
    String? habitId,
    CalendarDate? day,
    int? count,
    bool? skipped,
  }) => HabitLogRow(
    habitId: habitId ?? this.habitId,
    day: day ?? this.day,
    count: count ?? this.count,
    skipped: skipped ?? this.skipped,
  );
  HabitLogRow copyWithCompanion(HabitLogsCompanion data) {
    return HabitLogRow(
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      day: data.day.present ? data.day.value : this.day,
      count: data.count.present ? data.count.value : this.count,
      skipped: data.skipped.present ? data.skipped.value : this.skipped,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitLogRow(')
          ..write('habitId: $habitId, ')
          ..write('day: $day, ')
          ..write('count: $count, ')
          ..write('skipped: $skipped')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(habitId, day, count, skipped);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitLogRow &&
          other.habitId == this.habitId &&
          other.day == this.day &&
          other.count == this.count &&
          other.skipped == this.skipped);
}

class HabitLogsCompanion extends UpdateCompanion<HabitLogRow> {
  final Value<String> habitId;
  final Value<CalendarDate> day;
  final Value<int> count;
  final Value<bool> skipped;
  final Value<int> rowid;
  const HabitLogsCompanion({
    this.habitId = const Value.absent(),
    this.day = const Value.absent(),
    this.count = const Value.absent(),
    this.skipped = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitLogsCompanion.insert({
    required String habitId,
    required CalendarDate day,
    required int count,
    this.skipped = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : habitId = Value(habitId),
       day = Value(day),
       count = Value(count);
  static Insertable<HabitLogRow> custom({
    Expression<String>? habitId,
    Expression<int>? day,
    Expression<int>? count,
    Expression<bool>? skipped,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (habitId != null) 'habit_id': habitId,
      if (day != null) 'day': day,
      if (count != null) 'count': count,
      if (skipped != null) 'skipped': skipped,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitLogsCompanion copyWith({
    Value<String>? habitId,
    Value<CalendarDate>? day,
    Value<int>? count,
    Value<bool>? skipped,
    Value<int>? rowid,
  }) {
    return HabitLogsCompanion(
      habitId: habitId ?? this.habitId,
      day: day ?? this.day,
      count: count ?? this.count,
      skipped: skipped ?? this.skipped,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (day.present) {
      map['day'] = Variable<int>(
        $HabitLogsTable.$converterday.toSql(day.value),
      );
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (skipped.present) {
      map['skipped'] = Variable<bool>(skipped.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitLogsCompanion(')
          ..write('habitId: $habitId, ')
          ..write('day: $day, ')
          ..write('count: $count, ')
          ..write('skipped: $skipped, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RoutinesTable extends Routines
    with TableInfo<$RoutinesTable, RoutineRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<RoutineTime, String> time =
      GeneratedColumn<String>(
        'time',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<RoutineTime>($RoutinesTable.$convertertime);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, time, createdAt, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routines';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoutineRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutineRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutineRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      time: $RoutinesTable.$convertertime.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}time'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $RoutinesTable createAlias(String alias) {
    return $RoutinesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RoutineTime, String, String> $convertertime =
      const EnumNameConverter<RoutineTime>(RoutineTime.values);
}

class RoutineRow extends DataClass implements Insertable<RoutineRow> {
  final String id;
  final String title;
  final RoutineTime time;
  final DateTime createdAt;
  final int sortOrder;
  const RoutineRow({
    required this.id,
    required this.title,
    required this.time,
    required this.createdAt,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    {
      map['time'] = Variable<String>($RoutinesTable.$convertertime.toSql(time));
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  RoutinesCompanion toCompanion(bool nullToAbsent) {
    return RoutinesCompanion(
      id: Value(id),
      title: Value(title),
      time: Value(time),
      createdAt: Value(createdAt),
      sortOrder: Value(sortOrder),
    );
  }

  factory RoutineRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutineRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      time: $RoutinesTable.$convertertime.fromJson(
        serializer.fromJson<String>(json['time']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'time': serializer.toJson<String>(
        $RoutinesTable.$convertertime.toJson(time),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  RoutineRow copyWith({
    String? id,
    String? title,
    RoutineTime? time,
    DateTime? createdAt,
    int? sortOrder,
  }) => RoutineRow(
    id: id ?? this.id,
    title: title ?? this.title,
    time: time ?? this.time,
    createdAt: createdAt ?? this.createdAt,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  RoutineRow copyWithCompanion(RoutinesCompanion data) {
    return RoutineRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      time: data.time.present ? data.time.value : this.time,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoutineRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('time: $time, ')
          ..write('createdAt: $createdAt, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, time, createdAt, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutineRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.time == this.time &&
          other.createdAt == this.createdAt &&
          other.sortOrder == this.sortOrder);
}

class RoutinesCompanion extends UpdateCompanion<RoutineRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<RoutineTime> time;
  final Value<DateTime> createdAt;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const RoutinesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.time = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoutinesCompanion.insert({
    required String id,
    required String title,
    required RoutineTime time,
    required DateTime createdAt,
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       time = Value(time),
       createdAt = Value(createdAt),
       sortOrder = Value(sortOrder);
  static Insertable<RoutineRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? time,
    Expression<DateTime>? createdAt,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (time != null) 'time': time,
      if (createdAt != null) 'created_at': createdAt,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoutinesCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<RoutineTime>? time,
    Value<DateTime>? createdAt,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return RoutinesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      time: time ?? this.time,
      createdAt: createdAt ?? this.createdAt,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (time.present) {
      map['time'] = Variable<String>(
        $RoutinesTable.$convertertime.toSql(time.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutinesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('time: $time, ')
          ..write('createdAt: $createdAt, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RoutineItemsTable extends RoutineItems
    with TableInfo<$RoutineItemsTable, RoutineItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutineItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _routineIdMeta = const VerificationMeta(
    'routineId',
  );
  @override
  late final GeneratedColumn<String> routineId = GeneratedColumn<String>(
    'routine_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES routines (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, routineId, title, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routine_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoutineItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('routine_id')) {
      context.handle(
        _routineIdMeta,
        routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_routineIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutineItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutineItemRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      routineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}routine_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $RoutineItemsTable createAlias(String alias) {
    return $RoutineItemsTable(attachedDatabase, alias);
  }
}

class RoutineItemRow extends DataClass implements Insertable<RoutineItemRow> {
  final String id;
  final String routineId;
  final String title;
  final int sortOrder;
  const RoutineItemRow({
    required this.id,
    required this.routineId,
    required this.title,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['routine_id'] = Variable<String>(routineId);
    map['title'] = Variable<String>(title);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  RoutineItemsCompanion toCompanion(bool nullToAbsent) {
    return RoutineItemsCompanion(
      id: Value(id),
      routineId: Value(routineId),
      title: Value(title),
      sortOrder: Value(sortOrder),
    );
  }

  factory RoutineItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutineItemRow(
      id: serializer.fromJson<String>(json['id']),
      routineId: serializer.fromJson<String>(json['routineId']),
      title: serializer.fromJson<String>(json['title']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'routineId': serializer.toJson<String>(routineId),
      'title': serializer.toJson<String>(title),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  RoutineItemRow copyWith({
    String? id,
    String? routineId,
    String? title,
    int? sortOrder,
  }) => RoutineItemRow(
    id: id ?? this.id,
    routineId: routineId ?? this.routineId,
    title: title ?? this.title,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  RoutineItemRow copyWithCompanion(RoutineItemsCompanion data) {
    return RoutineItemRow(
      id: data.id.present ? data.id.value : this.id,
      routineId: data.routineId.present ? data.routineId.value : this.routineId,
      title: data.title.present ? data.title.value : this.title,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoutineItemRow(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('title: $title, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, routineId, title, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutineItemRow &&
          other.id == this.id &&
          other.routineId == this.routineId &&
          other.title == this.title &&
          other.sortOrder == this.sortOrder);
}

class RoutineItemsCompanion extends UpdateCompanion<RoutineItemRow> {
  final Value<String> id;
  final Value<String> routineId;
  final Value<String> title;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const RoutineItemsCompanion({
    this.id = const Value.absent(),
    this.routineId = const Value.absent(),
    this.title = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoutineItemsCompanion.insert({
    required String id,
    required String routineId,
    required String title,
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       routineId = Value(routineId),
       title = Value(title),
       sortOrder = Value(sortOrder);
  static Insertable<RoutineItemRow> custom({
    Expression<String>? id,
    Expression<String>? routineId,
    Expression<String>? title,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routineId != null) 'routine_id': routineId,
      if (title != null) 'title': title,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoutineItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? routineId,
    Value<String>? title,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return RoutineItemsCompanion(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      title: title ?? this.title,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<String>(routineId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutineItemsCompanion(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('title: $title, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RoutineChecksTable extends RoutineChecks
    with TableInfo<$RoutineChecksTable, RoutineCheckRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutineChecksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES routine_items (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<CalendarDate, int> day =
      GeneratedColumn<int>(
        'day',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<CalendarDate>($RoutineChecksTable.$converterday);
  @override
  List<GeneratedColumn> get $columns => [itemId, day];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routine_checks';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoutineCheckRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {itemId, day};
  @override
  RoutineCheckRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutineCheckRow(
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      day: $RoutineChecksTable.$converterday.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}day'],
        )!,
      ),
    );
  }

  @override
  $RoutineChecksTable createAlias(String alias) {
    return $RoutineChecksTable(attachedDatabase, alias);
  }

  static TypeConverter<CalendarDate, int> $converterday =
      const CalendarDateConverter();
}

class RoutineCheckRow extends DataClass implements Insertable<RoutineCheckRow> {
  final String itemId;
  final CalendarDate day;
  const RoutineCheckRow({required this.itemId, required this.day});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item_id'] = Variable<String>(itemId);
    {
      map['day'] = Variable<int>($RoutineChecksTable.$converterday.toSql(day));
    }
    return map;
  }

  RoutineChecksCompanion toCompanion(bool nullToAbsent) {
    return RoutineChecksCompanion(itemId: Value(itemId), day: Value(day));
  }

  factory RoutineCheckRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutineCheckRow(
      itemId: serializer.fromJson<String>(json['itemId']),
      day: serializer.fromJson<CalendarDate>(json['day']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'itemId': serializer.toJson<String>(itemId),
      'day': serializer.toJson<CalendarDate>(day),
    };
  }

  RoutineCheckRow copyWith({String? itemId, CalendarDate? day}) =>
      RoutineCheckRow(itemId: itemId ?? this.itemId, day: day ?? this.day);
  RoutineCheckRow copyWithCompanion(RoutineChecksCompanion data) {
    return RoutineCheckRow(
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      day: data.day.present ? data.day.value : this.day,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoutineCheckRow(')
          ..write('itemId: $itemId, ')
          ..write('day: $day')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(itemId, day);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutineCheckRow &&
          other.itemId == this.itemId &&
          other.day == this.day);
}

class RoutineChecksCompanion extends UpdateCompanion<RoutineCheckRow> {
  final Value<String> itemId;
  final Value<CalendarDate> day;
  final Value<int> rowid;
  const RoutineChecksCompanion({
    this.itemId = const Value.absent(),
    this.day = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoutineChecksCompanion.insert({
    required String itemId,
    required CalendarDate day,
    this.rowid = const Value.absent(),
  }) : itemId = Value(itemId),
       day = Value(day);
  static Insertable<RoutineCheckRow> custom({
    Expression<String>? itemId,
    Expression<int>? day,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (itemId != null) 'item_id': itemId,
      if (day != null) 'day': day,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoutineChecksCompanion copyWith({
    Value<String>? itemId,
    Value<CalendarDate>? day,
    Value<int>? rowid,
  }) {
    return RoutineChecksCompanion(
      itemId: itemId ?? this.itemId,
      day: day ?? this.day,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (day.present) {
      map['day'] = Variable<int>(
        $RoutineChecksTable.$converterday.toSql(day.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutineChecksCompanion(')
          ..write('itemId: $itemId, ')
          ..write('day: $day, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoalsTable extends Goals with TableInfo<$GoalsTable, GoalRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<GoalKind, String> kind =
      GeneratedColumn<String>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<GoalKind>($GoalsTable.$converterkind);
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
    'habit_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habits (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<GoalPeriod, String> period =
      GeneratedColumn<String>(
        'period',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<GoalPeriod>($GoalsTable.$converterperiod);
  static const VerificationMeta _targetMeta = const VerificationMeta('target');
  @override
  late final GeneratedColumn<int> target = GeneratedColumn<int>(
    'target',
    aliasedName,
    false,
    check: () => ComparableExpr(target).isBetweenValues(1, 200),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<CalendarDate, int> createdOn =
      GeneratedColumn<int>(
        'created_on',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<CalendarDate>($GoalsTable.$convertercreatedOn);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    kind,
    habitId,
    period,
    target,
    createdOn,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<GoalRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    }
    if (data.containsKey('target')) {
      context.handle(
        _targetMeta,
        target.isAcceptableOrUnknown(data['target']!, _targetMeta),
      );
    } else if (isInserting) {
      context.missing(_targetMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoalRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      kind: $GoalsTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_id'],
      ),
      period: $GoalsTable.$converterperiod.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}period'],
        )!,
      ),
      target: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target'],
      )!,
      createdOn: $GoalsTable.$convertercreatedOn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}created_on'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $GoalsTable createAlias(String alias) {
    return $GoalsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<GoalKind, String, String> $converterkind =
      const EnumNameConverter<GoalKind>(GoalKind.values);
  static JsonTypeConverter2<GoalPeriod, String, String> $converterperiod =
      const EnumNameConverter<GoalPeriod>(GoalPeriod.values);
  static TypeConverter<CalendarDate, int> $convertercreatedOn =
      const CalendarDateConverter();
}

class GoalRow extends DataClass implements Insertable<GoalRow> {
  final String id;
  final String title;
  final GoalKind kind;
  final String? habitId;
  final GoalPeriod period;
  final int target;
  final CalendarDate createdOn;
  final DateTime createdAt;
  const GoalRow({
    required this.id,
    required this.title,
    required this.kind,
    this.habitId,
    required this.period,
    required this.target,
    required this.createdOn,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    {
      map['kind'] = Variable<String>($GoalsTable.$converterkind.toSql(kind));
    }
    if (!nullToAbsent || habitId != null) {
      map['habit_id'] = Variable<String>(habitId);
    }
    {
      map['period'] = Variable<String>(
        $GoalsTable.$converterperiod.toSql(period),
      );
    }
    map['target'] = Variable<int>(target);
    {
      map['created_on'] = Variable<int>(
        $GoalsTable.$convertercreatedOn.toSql(createdOn),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  GoalsCompanion toCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      id: Value(id),
      title: Value(title),
      kind: Value(kind),
      habitId: habitId == null && nullToAbsent
          ? const Value.absent()
          : Value(habitId),
      period: Value(period),
      target: Value(target),
      createdOn: Value(createdOn),
      createdAt: Value(createdAt),
    );
  }

  factory GoalRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      kind: $GoalsTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      habitId: serializer.fromJson<String?>(json['habitId']),
      period: $GoalsTable.$converterperiod.fromJson(
        serializer.fromJson<String>(json['period']),
      ),
      target: serializer.fromJson<int>(json['target']),
      createdOn: serializer.fromJson<CalendarDate>(json['createdOn']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'kind': serializer.toJson<String>(
        $GoalsTable.$converterkind.toJson(kind),
      ),
      'habitId': serializer.toJson<String?>(habitId),
      'period': serializer.toJson<String>(
        $GoalsTable.$converterperiod.toJson(period),
      ),
      'target': serializer.toJson<int>(target),
      'createdOn': serializer.toJson<CalendarDate>(createdOn),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  GoalRow copyWith({
    String? id,
    String? title,
    GoalKind? kind,
    Value<String?> habitId = const Value.absent(),
    GoalPeriod? period,
    int? target,
    CalendarDate? createdOn,
    DateTime? createdAt,
  }) => GoalRow(
    id: id ?? this.id,
    title: title ?? this.title,
    kind: kind ?? this.kind,
    habitId: habitId.present ? habitId.value : this.habitId,
    period: period ?? this.period,
    target: target ?? this.target,
    createdOn: createdOn ?? this.createdOn,
    createdAt: createdAt ?? this.createdAt,
  );
  GoalRow copyWithCompanion(GoalsCompanion data) {
    return GoalRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      kind: data.kind.present ? data.kind.value : this.kind,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      period: data.period.present ? data.period.value : this.period,
      target: data.target.present ? data.target.value : this.target,
      createdOn: data.createdOn.present ? data.createdOn.value : this.createdOn,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoalRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('kind: $kind, ')
          ..write('habitId: $habitId, ')
          ..write('period: $period, ')
          ..write('target: $target, ')
          ..write('createdOn: $createdOn, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    kind,
    habitId,
    period,
    target,
    createdOn,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.kind == this.kind &&
          other.habitId == this.habitId &&
          other.period == this.period &&
          other.target == this.target &&
          other.createdOn == this.createdOn &&
          other.createdAt == this.createdAt);
}

class GoalsCompanion extends UpdateCompanion<GoalRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<GoalKind> kind;
  final Value<String?> habitId;
  final Value<GoalPeriod> period;
  final Value<int> target;
  final Value<CalendarDate> createdOn;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const GoalsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.kind = const Value.absent(),
    this.habitId = const Value.absent(),
    this.period = const Value.absent(),
    this.target = const Value.absent(),
    this.createdOn = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoalsCompanion.insert({
    required String id,
    required String title,
    required GoalKind kind,
    this.habitId = const Value.absent(),
    required GoalPeriod period,
    required int target,
    required CalendarDate createdOn,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       kind = Value(kind),
       period = Value(period),
       target = Value(target),
       createdOn = Value(createdOn),
       createdAt = Value(createdAt);
  static Insertable<GoalRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? kind,
    Expression<String>? habitId,
    Expression<String>? period,
    Expression<int>? target,
    Expression<int>? createdOn,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (kind != null) 'kind': kind,
      if (habitId != null) 'habit_id': habitId,
      if (period != null) 'period': period,
      if (target != null) 'target': target,
      if (createdOn != null) 'created_on': createdOn,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoalsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<GoalKind>? kind,
    Value<String?>? habitId,
    Value<GoalPeriod>? period,
    Value<int>? target,
    Value<CalendarDate>? createdOn,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return GoalsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      kind: kind ?? this.kind,
      habitId: habitId ?? this.habitId,
      period: period ?? this.period,
      target: target ?? this.target,
      createdOn: createdOn ?? this.createdOn,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $GoalsTable.$converterkind.toSql(kind.value),
      );
    }
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (period.present) {
      map['period'] = Variable<String>(
        $GoalsTable.$converterperiod.toSql(period.value),
      );
    }
    if (target.present) {
      map['target'] = Variable<int>(target.value);
    }
    if (createdOn.present) {
      map['created_on'] = Variable<int>(
        $GoalsTable.$convertercreatedOn.toSql(createdOn.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('kind: $kind, ')
          ..write('habitId: $habitId, ')
          ..write('period: $period, ')
          ..write('target: $target, ')
          ..write('createdOn: $createdOn, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AchievementUnlocksTable extends AchievementUnlocks
    with TableInfo<$AchievementUnlocksTable, AchievementUnlockRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AchievementUnlocksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _achievementIdMeta = const VerificationMeta(
    'achievementId',
  );
  @override
  late final GeneratedColumn<String> achievementId = GeneratedColumn<String>(
    'achievement_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<CalendarDate, int> unlockedOn =
      GeneratedColumn<int>(
        'unlocked_on',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<CalendarDate>(
        $AchievementUnlocksTable.$converterunlockedOn,
      );
  static const VerificationMeta _unlockedAtMeta = const VerificationMeta(
    'unlockedAt',
  );
  @override
  late final GeneratedColumn<DateTime> unlockedAt = GeneratedColumn<DateTime>(
    'unlocked_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [achievementId, unlockedOn, unlockedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'achievement_unlocks';
  @override
  VerificationContext validateIntegrity(
    Insertable<AchievementUnlockRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('achievement_id')) {
      context.handle(
        _achievementIdMeta,
        achievementId.isAcceptableOrUnknown(
          data['achievement_id']!,
          _achievementIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_achievementIdMeta);
    }
    if (data.containsKey('unlocked_at')) {
      context.handle(
        _unlockedAtMeta,
        unlockedAt.isAcceptableOrUnknown(data['unlocked_at']!, _unlockedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_unlockedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {achievementId};
  @override
  AchievementUnlockRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AchievementUnlockRow(
      achievementId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}achievement_id'],
      )!,
      unlockedOn: $AchievementUnlocksTable.$converterunlockedOn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}unlocked_on'],
        )!,
      ),
      unlockedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}unlocked_at'],
      )!,
    );
  }

  @override
  $AchievementUnlocksTable createAlias(String alias) {
    return $AchievementUnlocksTable(attachedDatabase, alias);
  }

  static TypeConverter<CalendarDate, int> $converterunlockedOn =
      const CalendarDateConverter();
}

class AchievementUnlockRow extends DataClass
    implements Insertable<AchievementUnlockRow> {
  final String achievementId;
  final CalendarDate unlockedOn;
  final DateTime unlockedAt;
  const AchievementUnlockRow({
    required this.achievementId,
    required this.unlockedOn,
    required this.unlockedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['achievement_id'] = Variable<String>(achievementId);
    {
      map['unlocked_on'] = Variable<int>(
        $AchievementUnlocksTable.$converterunlockedOn.toSql(unlockedOn),
      );
    }
    map['unlocked_at'] = Variable<DateTime>(unlockedAt);
    return map;
  }

  AchievementUnlocksCompanion toCompanion(bool nullToAbsent) {
    return AchievementUnlocksCompanion(
      achievementId: Value(achievementId),
      unlockedOn: Value(unlockedOn),
      unlockedAt: Value(unlockedAt),
    );
  }

  factory AchievementUnlockRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AchievementUnlockRow(
      achievementId: serializer.fromJson<String>(json['achievementId']),
      unlockedOn: serializer.fromJson<CalendarDate>(json['unlockedOn']),
      unlockedAt: serializer.fromJson<DateTime>(json['unlockedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'achievementId': serializer.toJson<String>(achievementId),
      'unlockedOn': serializer.toJson<CalendarDate>(unlockedOn),
      'unlockedAt': serializer.toJson<DateTime>(unlockedAt),
    };
  }

  AchievementUnlockRow copyWith({
    String? achievementId,
    CalendarDate? unlockedOn,
    DateTime? unlockedAt,
  }) => AchievementUnlockRow(
    achievementId: achievementId ?? this.achievementId,
    unlockedOn: unlockedOn ?? this.unlockedOn,
    unlockedAt: unlockedAt ?? this.unlockedAt,
  );
  AchievementUnlockRow copyWithCompanion(AchievementUnlocksCompanion data) {
    return AchievementUnlockRow(
      achievementId: data.achievementId.present
          ? data.achievementId.value
          : this.achievementId,
      unlockedOn: data.unlockedOn.present
          ? data.unlockedOn.value
          : this.unlockedOn,
      unlockedAt: data.unlockedAt.present
          ? data.unlockedAt.value
          : this.unlockedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AchievementUnlockRow(')
          ..write('achievementId: $achievementId, ')
          ..write('unlockedOn: $unlockedOn, ')
          ..write('unlockedAt: $unlockedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(achievementId, unlockedOn, unlockedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AchievementUnlockRow &&
          other.achievementId == this.achievementId &&
          other.unlockedOn == this.unlockedOn &&
          other.unlockedAt == this.unlockedAt);
}

class AchievementUnlocksCompanion
    extends UpdateCompanion<AchievementUnlockRow> {
  final Value<String> achievementId;
  final Value<CalendarDate> unlockedOn;
  final Value<DateTime> unlockedAt;
  final Value<int> rowid;
  const AchievementUnlocksCompanion({
    this.achievementId = const Value.absent(),
    this.unlockedOn = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AchievementUnlocksCompanion.insert({
    required String achievementId,
    required CalendarDate unlockedOn,
    required DateTime unlockedAt,
    this.rowid = const Value.absent(),
  }) : achievementId = Value(achievementId),
       unlockedOn = Value(unlockedOn),
       unlockedAt = Value(unlockedAt);
  static Insertable<AchievementUnlockRow> custom({
    Expression<String>? achievementId,
    Expression<int>? unlockedOn,
    Expression<DateTime>? unlockedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (achievementId != null) 'achievement_id': achievementId,
      if (unlockedOn != null) 'unlocked_on': unlockedOn,
      if (unlockedAt != null) 'unlocked_at': unlockedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AchievementUnlocksCompanion copyWith({
    Value<String>? achievementId,
    Value<CalendarDate>? unlockedOn,
    Value<DateTime>? unlockedAt,
    Value<int>? rowid,
  }) {
    return AchievementUnlocksCompanion(
      achievementId: achievementId ?? this.achievementId,
      unlockedOn: unlockedOn ?? this.unlockedOn,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (achievementId.present) {
      map['achievement_id'] = Variable<String>(achievementId.value);
    }
    if (unlockedOn.present) {
      map['unlocked_on'] = Variable<int>(
        $AchievementUnlocksTable.$converterunlockedOn.toSql(unlockedOn.value),
      );
    }
    if (unlockedAt.present) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AchievementUnlocksCompanion(')
          ..write('achievementId: $achievementId, ')
          ..write('unlockedOn: $unlockedOn, ')
          ..write('unlockedAt: $unlockedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $HabitLogsTable habitLogs = $HabitLogsTable(this);
  late final $RoutinesTable routines = $RoutinesTable(this);
  late final $RoutineItemsTable routineItems = $RoutineItemsTable(this);
  late final $RoutineChecksTable routineChecks = $RoutineChecksTable(this);
  late final $GoalsTable goals = $GoalsTable(this);
  late final $AchievementUnlocksTable achievementUnlocks =
      $AchievementUnlocksTable(this);
  late final Index habitsByOrder = Index(
    'habits_by_order',
    'CREATE INDEX habits_by_order ON habits (sort_order)',
  );
  late final Index habitLogsByDay = Index(
    'habit_logs_by_day',
    'CREATE INDEX habit_logs_by_day ON habit_logs (day)',
  );
  late final Index routineItemsByRoutine = Index(
    'routine_items_by_routine',
    'CREATE INDEX routine_items_by_routine ON routine_items (routine_id, sort_order)',
  );
  late final Index routineChecksByDay = Index(
    'routine_checks_by_day',
    'CREATE INDEX routine_checks_by_day ON routine_checks (day)',
  );
  late final Index goalsByHabit = Index(
    'goals_by_habit',
    'CREATE INDEX goals_by_habit ON goals (habit_id)',
  );
  late final UserDataDao userDataDao = UserDataDao(this as AppDatabase);
  late final HabitsDao habitsDao = HabitsDao(this as AppDatabase);
  late final HabitLogsDao habitLogsDao = HabitLogsDao(this as AppDatabase);
  late final RoutinesDao routinesDao = RoutinesDao(this as AppDatabase);
  late final GoalsDao goalsDao = GoalsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    habits,
    habitLogs,
    routines,
    routineItems,
    routineChecks,
    goals,
    achievementUnlocks,
    habitsByOrder,
    habitLogsByDay,
    routineItemsByRoutine,
    routineChecksByDay,
    goalsByHabit,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'habits',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('habit_logs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'routines',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('routine_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'routine_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('routine_checks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'habits',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('goals', kind: UpdateKind.delete)],
    ),
  ]);
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$HabitsTableCreateCompanionBuilder = HabitsCompanion Function({
  required String id,
  required String title,
  Value<String> description,
  required HabitCategory category,
  required HabitColor color,
  required HabitIcon icon,
  required ScheduleType scheduleType,
  Value<int> weekdays,
  Value<int?> timesPerWeek,
  required int dailyTarget,
  required CalendarDate startDate,
  Value<TimeOfDayValue?> reminderTime,
  Value<DateTime?> archivedAt,
  required DateTime createdAt,
  required int sortOrder,
  Value<int> rowid,
});
typedef $$HabitsTableUpdateCompanionBuilder = HabitsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> description,
  Value<HabitCategory> category,
  Value<HabitColor> color,
  Value<HabitIcon> icon,
  Value<ScheduleType> scheduleType,
  Value<int> weekdays,
  Value<int?> timesPerWeek,
  Value<int> dailyTarget,
  Value<CalendarDate> startDate,
  Value<TimeOfDayValue?> reminderTime,
  Value<DateTime?> archivedAt,
  Value<DateTime> createdAt,
  Value<int> sortOrder,
  Value<int> rowid,
});

final class $$HabitsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitsTable, HabitRow> {
  $$HabitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HabitLogsTable, List<HabitLogRow>>
  _habitLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.habitLogs,
    aliasName: 'habits__id__habit_logs__habit_id',
  );

  $$HabitLogsTableProcessedTableManager get habitLogsRefs {
    final manager = $$HabitLogsTableTableManager(
      $_db,
      $_db.habitLogs,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_habitLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GoalsTable, List<GoalRow>> _goalsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.goals,
    aliasName: 'habits__id__goals__habit_id',
  );

  $$GoalsTableProcessedTableManager get goalsRefs {
    final manager = $$GoalsTableTableManager(
      $_db,
      $_db.goals,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_goalsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HabitsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<HabitCategory, HabitCategory, String>
  get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<HabitColor, HabitColor, String> get color =>
      $composableBuilder(
        column: $table.color,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<HabitIcon, HabitIcon, String> get icon =>
      $composableBuilder(
        column: $table.icon,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<ScheduleType, ScheduleType, String>
  get scheduleType => $composableBuilder(
    column: $table.scheduleType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get weekdays => $composableBuilder(
    column: $table.weekdays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timesPerWeek => $composableBuilder(
    column: $table.timesPerWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dailyTarget => $composableBuilder(
    column: $table.dailyTarget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CalendarDate, CalendarDate, int>
  get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<TimeOfDayValue?, TimeOfDayValue, String>
  get reminderTime => $composableBuilder(
    column: $table.reminderTime,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> habitLogsRefs(
    Expression<bool> Function($$HabitLogsTableFilterComposer f) f,
  ) {
    final $$HabitLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitLogs,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitLogsTableFilterComposer(
            $db: $db,
            $table: $db.habitLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> goalsRefs(
    Expression<bool> Function($$GoalsTableFilterComposer f) f,
  ) {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableFilterComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scheduleType => $composableBuilder(
    column: $table.scheduleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekdays => $composableBuilder(
    column: $table.weekdays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timesPerWeek => $composableBuilder(
    column: $table.timesPerWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dailyTarget => $composableBuilder(
    column: $table.dailyTarget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reminderTime => $composableBuilder(
    column: $table.reminderTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HabitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<HabitCategory, String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumnWithTypeConverter<HabitColor, String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumnWithTypeConverter<HabitIcon, String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ScheduleType, String> get scheduleType =>
      $composableBuilder(
        column: $table.scheduleType,
        builder: (column) => column,
      );

  GeneratedColumn<int> get weekdays =>
      $composableBuilder(column: $table.weekdays, builder: (column) => column);

  GeneratedColumn<int> get timesPerWeek => $composableBuilder(
    column: $table.timesPerWeek,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dailyTarget => $composableBuilder(
    column: $table.dailyTarget,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<CalendarDate, int> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TimeOfDayValue?, String> get reminderTime =>
      $composableBuilder(
        column: $table.reminderTime,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  Expression<T> habitLogsRefs<T extends Object>(
    Expression<T> Function($$HabitLogsTableAnnotationComposer a) f,
  ) {
    final $$HabitLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitLogs,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.habitLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> goalsRefs<T extends Object>(
    Expression<T> Function($$GoalsTableAnnotationComposer a) f,
  ) {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableAnnotationComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitsTable,
          HabitRow,
          $$HabitsTableFilterComposer,
          $$HabitsTableOrderingComposer,
          $$HabitsTableAnnotationComposer,
          $$HabitsTableCreateCompanionBuilder,
          $$HabitsTableUpdateCompanionBuilder,
          (HabitRow, $$HabitsTableReferences),
          HabitRow,
          PrefetchHooks Function({bool habitLogsRefs, bool goalsRefs})
        > {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<HabitCategory> category = const Value.absent(),
                Value<HabitColor> color = const Value.absent(),
                Value<HabitIcon> icon = const Value.absent(),
                Value<ScheduleType> scheduleType = const Value.absent(),
                Value<int> weekdays = const Value.absent(),
                Value<int?> timesPerWeek = const Value.absent(),
                Value<int> dailyTarget = const Value.absent(),
                Value<CalendarDate> startDate = const Value.absent(),
                Value<TimeOfDayValue?> reminderTime = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitsCompanion(
                id: id,
                title: title,
                description: description,
                category: category,
                color: color,
                icon: icon,
                scheduleType: scheduleType,
                weekdays: weekdays,
                timesPerWeek: timesPerWeek,
                dailyTarget: dailyTarget,
                startDate: startDate,
                reminderTime: reminderTime,
                archivedAt: archivedAt,
                createdAt: createdAt,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<String> description = const Value.absent(),
                required HabitCategory category,
                required HabitColor color,
                required HabitIcon icon,
                required ScheduleType scheduleType,
                Value<int> weekdays = const Value.absent(),
                Value<int?> timesPerWeek = const Value.absent(),
                required int dailyTarget,
                required CalendarDate startDate,
                Value<TimeOfDayValue?> reminderTime = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                required DateTime createdAt,
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => HabitsCompanion.insert(
                id: id,
                title: title,
                description: description,
                category: category,
                color: color,
                icon: icon,
                scheduleType: scheduleType,
                weekdays: weekdays,
                timesPerWeek: timesPerWeek,
                dailyTarget: dailyTarget,
                startDate: startDate,
                reminderTime: reminderTime,
                archivedAt: archivedAt,
                createdAt: createdAt,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HabitsTable, HabitRow>(table),
                  $$HabitsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitLogsRefs = false, goalsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (habitLogsRefs) db.habitLogs,
                if (goalsRefs) db.goals,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (habitLogsRefs)
                    await $_getPrefetchedData<
                      HabitRow,
                      $HabitsTable,
                      HabitLogRow
                    >(
                      currentTable: table,
                      referencedTable: $$HabitsTableReferences
                          ._habitLogsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$HabitsTableReferences(db, table, p0).habitLogsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.habitId == item.id),
                      typedResults: items,
                    ),
                  if (goalsRefs)
                    await $_getPrefetchedData<HabitRow, $HabitsTable, GoalRow>(
                      currentTable: table,
                      referencedTable: $$HabitsTableReferences._goalsRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$HabitsTableReferences(db, table, p0).goalsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.habitId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$HabitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitsTable,
      HabitRow,
      $$HabitsTableFilterComposer,
      $$HabitsTableOrderingComposer,
      $$HabitsTableAnnotationComposer,
      $$HabitsTableCreateCompanionBuilder,
      $$HabitsTableUpdateCompanionBuilder,
      (HabitRow, $$HabitsTableReferences),
      HabitRow,
      PrefetchHooks Function({bool habitLogsRefs, bool goalsRefs})
    >;
typedef $$HabitLogsTableCreateCompanionBuilder = HabitLogsCompanion Function({
  required String habitId,
  required CalendarDate day,
  required int count,
  Value<bool> skipped,
  Value<int> rowid,
});
typedef $$HabitLogsTableUpdateCompanionBuilder = HabitLogsCompanion Function({
  Value<String> habitId,
  Value<CalendarDate> day,
  Value<int> count,
  Value<bool> skipped,
  Value<int> rowid,
});

final class $$HabitLogsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitLogsTable, HabitLogRow> {
  $$HabitLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HabitsTable _habitIdTable(_$AppDatabase db) =>
      db.habits.createAlias('habit_logs__habit_id__habits__id');

  $$HabitsTableProcessedTableManager get habitId {
    final $_column = $_itemColumn<String>('habit_id')!;

    final manager = $$HabitsTableTableManager(
      $_db,
      $_db.habits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HabitLogsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnWithTypeConverterFilters<CalendarDate, CalendarDate, int> get day =>
      $composableBuilder(
        column: $table.day,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get skipped => $composableBuilder(
    column: $table.skipped,
    builder: (column) => ColumnFilters(column),
  );

  $$HabitsTableFilterComposer get habitId {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableFilterComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get skipped => $composableBuilder(
    column: $table.skipped,
    builder: (column) => ColumnOrderings(column),
  );

  $$HabitsTableOrderingComposer get habitId {
    final $$HabitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableOrderingComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumnWithTypeConverter<CalendarDate, int> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);

  GeneratedColumn<bool> get skipped =>
      $composableBuilder(column: $table.skipped, builder: (column) => column);

  $$HabitsTableAnnotationComposer get habitId {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableAnnotationComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitLogsTable,
          HabitLogRow,
          $$HabitLogsTableFilterComposer,
          $$HabitLogsTableOrderingComposer,
          $$HabitLogsTableAnnotationComposer,
          $$HabitLogsTableCreateCompanionBuilder,
          $$HabitLogsTableUpdateCompanionBuilder,
          (HabitLogRow, $$HabitLogsTableReferences),
          HabitLogRow,
          PrefetchHooks Function({bool habitId})
        > {
  $$HabitLogsTableTableManager(_$AppDatabase db, $HabitLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> habitId = const Value.absent(),
                Value<CalendarDate> day = const Value.absent(),
                Value<int> count = const Value.absent(),
                Value<bool> skipped = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitLogsCompanion(
                habitId: habitId,
                day: day,
                count: count,
                skipped: skipped,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String habitId,
                required CalendarDate day,
                required int count,
                Value<bool> skipped = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitLogsCompanion.insert(
                habitId: habitId,
                day: day,
                count: count,
                skipped: skipped,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HabitLogsTable, HabitLogRow>(table),
                  $$HabitLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (habitId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.habitId,
                        referencedTable: $$HabitLogsTableReferences
                            ._habitIdTable(db),
                        referencedColumn: $$HabitLogsTableReferences
                            ._habitIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HabitLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitLogsTable,
      HabitLogRow,
      $$HabitLogsTableFilterComposer,
      $$HabitLogsTableOrderingComposer,
      $$HabitLogsTableAnnotationComposer,
      $$HabitLogsTableCreateCompanionBuilder,
      $$HabitLogsTableUpdateCompanionBuilder,
      (HabitLogRow, $$HabitLogsTableReferences),
      HabitLogRow,
      PrefetchHooks Function({bool habitId})
    >;
typedef $$RoutinesTableCreateCompanionBuilder = RoutinesCompanion Function({
  required String id,
  required String title,
  required RoutineTime time,
  required DateTime createdAt,
  required int sortOrder,
  Value<int> rowid,
});
typedef $$RoutinesTableUpdateCompanionBuilder = RoutinesCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<RoutineTime> time,
  Value<DateTime> createdAt,
  Value<int> sortOrder,
  Value<int> rowid,
});

final class $$RoutinesTableReferences
    extends BaseReferences<_$AppDatabase, $RoutinesTable, RoutineRow> {
  $$RoutinesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RoutineItemsTable, List<RoutineItemRow>>
  _routineItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.routineItems,
    aliasName: 'routines__id__routine_items__routine_id',
  );

  $$RoutineItemsTableProcessedTableManager get routineItemsRefs {
    final manager = $$RoutineItemsTableTableManager(
      $_db,
      $_db.routineItems,
    ).filter((f) => f.routineId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_routineItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RoutinesTableFilterComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RoutineTime, RoutineTime, String> get time =>
      $composableBuilder(
        column: $table.time,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> routineItemsRefs(
    Expression<bool> Function($$RoutineItemsTableFilterComposer f) f,
  ) {
    final $$RoutineItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.routineItems,
      getReferencedColumn: (t) => t.routineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineItemsTableFilterComposer(
            $db: $db,
            $table: $db.routineItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoutinesTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RoutinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RoutineTime, String> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  Expression<T> routineItemsRefs<T extends Object>(
    Expression<T> Function($$RoutineItemsTableAnnotationComposer a) f,
  ) {
    final $$RoutineItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.routineItems,
      getReferencedColumn: (t) => t.routineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.routineItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoutinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutinesTable,
          RoutineRow,
          $$RoutinesTableFilterComposer,
          $$RoutinesTableOrderingComposer,
          $$RoutinesTableAnnotationComposer,
          $$RoutinesTableCreateCompanionBuilder,
          $$RoutinesTableUpdateCompanionBuilder,
          (RoutineRow, $$RoutinesTableReferences),
          RoutineRow,
          PrefetchHooks Function({bool routineItemsRefs})
        > {
  $$RoutinesTableTableManager(_$AppDatabase db, $RoutinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<RoutineTime> time = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoutinesCompanion(
                id: id,
                title: title,
                time: time,
                createdAt: createdAt,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required RoutineTime time,
                required DateTime createdAt,
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => RoutinesCompanion.insert(
                id: id,
                title: title,
                time: time,
                createdAt: createdAt,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RoutinesTable, RoutineRow>(table),
                  $$RoutinesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({routineItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (routineItemsRefs) db.routineItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (routineItemsRefs)
                    await $_getPrefetchedData<
                      RoutineRow,
                      $RoutinesTable,
                      RoutineItemRow
                    >(
                      currentTable: table,
                      referencedTable: $$RoutinesTableReferences
                          ._routineItemsRefsTable(db),
                      managerFromTypedResult: (p0) => $$RoutinesTableReferences(
                        db,
                        table,
                        p0,
                      ).routineItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.routineId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RoutinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutinesTable,
      RoutineRow,
      $$RoutinesTableFilterComposer,
      $$RoutinesTableOrderingComposer,
      $$RoutinesTableAnnotationComposer,
      $$RoutinesTableCreateCompanionBuilder,
      $$RoutinesTableUpdateCompanionBuilder,
      (RoutineRow, $$RoutinesTableReferences),
      RoutineRow,
      PrefetchHooks Function({bool routineItemsRefs})
    >;
typedef $$RoutineItemsTableCreateCompanionBuilder =
    RoutineItemsCompanion Function({
      required String id,
      required String routineId,
      required String title,
      required int sortOrder,
      Value<int> rowid,
    });
typedef $$RoutineItemsTableUpdateCompanionBuilder =
    RoutineItemsCompanion Function({
      Value<String> id,
      Value<String> routineId,
      Value<String> title,
      Value<int> sortOrder,
      Value<int> rowid,
    });

final class $$RoutineItemsTableReferences
    extends BaseReferences<_$AppDatabase, $RoutineItemsTable, RoutineItemRow> {
  $$RoutineItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RoutinesTable _routineIdTable(_$AppDatabase db) =>
      db.routines.createAlias('routine_items__routine_id__routines__id');

  $$RoutinesTableProcessedTableManager get routineId {
    final $_column = $_itemColumn<String>('routine_id')!;

    final manager = $$RoutinesTableTableManager(
      $_db,
      $_db.routines,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_routineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$RoutineChecksTable, List<RoutineCheckRow>>
  _routineChecksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.routineChecks,
    aliasName: 'routine_items__id__routine_checks__item_id',
  );

  $$RoutineChecksTableProcessedTableManager get routineChecksRefs {
    final manager = $$RoutineChecksTableTableManager(
      $_db,
      $_db.routineChecks,
    ).filter((f) => f.itemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_routineChecksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RoutineItemsTableFilterComposer
    extends Composer<_$AppDatabase, $RoutineItemsTable> {
  $$RoutineItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$RoutinesTableFilterComposer get routineId {
    final $$RoutinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableFilterComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> routineChecksRefs(
    Expression<bool> Function($$RoutineChecksTableFilterComposer f) f,
  ) {
    final $$RoutineChecksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.routineChecks,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineChecksTableFilterComposer(
            $db: $db,
            $table: $db.routineChecks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoutineItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutineItemsTable> {
  $$RoutineItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$RoutinesTableOrderingComposer get routineId {
    final $$RoutinesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableOrderingComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoutineItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutineItemsTable> {
  $$RoutineItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$RoutinesTableAnnotationComposer get routineId {
    final $$RoutinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableAnnotationComposer(
            $db: $db,
            $table: $db.routines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> routineChecksRefs<T extends Object>(
    Expression<T> Function($$RoutineChecksTableAnnotationComposer a) f,
  ) {
    final $$RoutineChecksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.routineChecks,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineChecksTableAnnotationComposer(
            $db: $db,
            $table: $db.routineChecks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoutineItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutineItemsTable,
          RoutineItemRow,
          $$RoutineItemsTableFilterComposer,
          $$RoutineItemsTableOrderingComposer,
          $$RoutineItemsTableAnnotationComposer,
          $$RoutineItemsTableCreateCompanionBuilder,
          $$RoutineItemsTableUpdateCompanionBuilder,
          (RoutineItemRow, $$RoutineItemsTableReferences),
          RoutineItemRow,
          PrefetchHooks Function({bool routineId, bool routineChecksRefs})
        > {
  $$RoutineItemsTableTableManager(_$AppDatabase db, $RoutineItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutineItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutineItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutineItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> routineId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoutineItemsCompanion(
                id: id,
                routineId: routineId,
                title: title,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String routineId,
                required String title,
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => RoutineItemsCompanion.insert(
                id: id,
                routineId: routineId,
                title: title,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RoutineItemsTable, RoutineItemRow>(table),
                  $$RoutineItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({routineId = false, routineChecksRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (routineChecksRefs) db.routineChecks,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (routineId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.routineId,
                            referencedTable: $$RoutineItemsTableReferences
                                ._routineIdTable(db),
                            referencedColumn: $$RoutineItemsTableReferences
                                ._routineIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (routineChecksRefs)
                        await $_getPrefetchedData<
                          RoutineItemRow,
                          $RoutineItemsTable,
                          RoutineCheckRow
                        >(
                          currentTable: table,
                          referencedTable: $$RoutineItemsTableReferences
                              ._routineChecksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RoutineItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).routineChecksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.itemId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RoutineItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutineItemsTable,
      RoutineItemRow,
      $$RoutineItemsTableFilterComposer,
      $$RoutineItemsTableOrderingComposer,
      $$RoutineItemsTableAnnotationComposer,
      $$RoutineItemsTableCreateCompanionBuilder,
      $$RoutineItemsTableUpdateCompanionBuilder,
      (RoutineItemRow, $$RoutineItemsTableReferences),
      RoutineItemRow,
      PrefetchHooks Function({bool routineId, bool routineChecksRefs})
    >;
typedef $$RoutineChecksTableCreateCompanionBuilder =
    RoutineChecksCompanion Function({
      required String itemId,
      required CalendarDate day,
      Value<int> rowid,
    });
typedef $$RoutineChecksTableUpdateCompanionBuilder =
    RoutineChecksCompanion Function({
      Value<String> itemId,
      Value<CalendarDate> day,
      Value<int> rowid,
    });

final class $$RoutineChecksTableReferences
    extends
        BaseReferences<_$AppDatabase, $RoutineChecksTable, RoutineCheckRow> {
  $$RoutineChecksTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RoutineItemsTable _itemIdTable(_$AppDatabase db) =>
      db.routineItems.createAlias('routine_checks__item_id__routine_items__id');

  $$RoutineItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<String>('item_id')!;

    final manager = $$RoutineItemsTableTableManager(
      $_db,
      $_db.routineItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RoutineChecksTableFilterComposer
    extends Composer<_$AppDatabase, $RoutineChecksTable> {
  $$RoutineChecksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnWithTypeConverterFilters<CalendarDate, CalendarDate, int> get day =>
      $composableBuilder(
        column: $table.day,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  $$RoutineItemsTableFilterComposer get itemId {
    final $$RoutineItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.routineItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineItemsTableFilterComposer(
            $db: $db,
            $table: $db.routineItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoutineChecksTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutineChecksTable> {
  $$RoutineChecksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  $$RoutineItemsTableOrderingComposer get itemId {
    final $$RoutineItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.routineItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineItemsTableOrderingComposer(
            $db: $db,
            $table: $db.routineItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoutineChecksTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutineChecksTable> {
  $$RoutineChecksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumnWithTypeConverter<CalendarDate, int> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  $$RoutineItemsTableAnnotationComposer get itemId {
    final $$RoutineItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.routineItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.routineItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoutineChecksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutineChecksTable,
          RoutineCheckRow,
          $$RoutineChecksTableFilterComposer,
          $$RoutineChecksTableOrderingComposer,
          $$RoutineChecksTableAnnotationComposer,
          $$RoutineChecksTableCreateCompanionBuilder,
          $$RoutineChecksTableUpdateCompanionBuilder,
          (RoutineCheckRow, $$RoutineChecksTableReferences),
          RoutineCheckRow,
          PrefetchHooks Function({bool itemId})
        > {
  $$RoutineChecksTableTableManager(_$AppDatabase db, $RoutineChecksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutineChecksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutineChecksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutineChecksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> itemId = const Value.absent(),
            Value<CalendarDate> day = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => RoutineChecksCompanion(itemId: itemId, day: day, rowid: rowid),
          createCompanionCallback:
              ({
                required String itemId,
                required CalendarDate day,
                Value<int> rowid = const Value.absent(),
              }) => RoutineChecksCompanion.insert(
                itemId: itemId,
                day: day,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RoutineChecksTable, RoutineCheckRow>(table),
                  $$RoutineChecksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({itemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (itemId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.itemId,
                        referencedTable: $$RoutineChecksTableReferences
                            ._itemIdTable(db),
                        referencedColumn: $$RoutineChecksTableReferences
                            ._itemIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RoutineChecksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutineChecksTable,
      RoutineCheckRow,
      $$RoutineChecksTableFilterComposer,
      $$RoutineChecksTableOrderingComposer,
      $$RoutineChecksTableAnnotationComposer,
      $$RoutineChecksTableCreateCompanionBuilder,
      $$RoutineChecksTableUpdateCompanionBuilder,
      (RoutineCheckRow, $$RoutineChecksTableReferences),
      RoutineCheckRow,
      PrefetchHooks Function({bool itemId})
    >;
typedef $$GoalsTableCreateCompanionBuilder = GoalsCompanion Function({
  required String id,
  required String title,
  required GoalKind kind,
  Value<String?> habitId,
  required GoalPeriod period,
  required int target,
  required CalendarDate createdOn,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$GoalsTableUpdateCompanionBuilder = GoalsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<GoalKind> kind,
  Value<String?> habitId,
  Value<GoalPeriod> period,
  Value<int> target,
  Value<CalendarDate> createdOn,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$GoalsTableReferences
    extends BaseReferences<_$AppDatabase, $GoalsTable, GoalRow> {
  $$GoalsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HabitsTable _habitIdTable(_$AppDatabase db) =>
      db.habits.createAlias('goals__habit_id__habits__id');

  $$HabitsTableProcessedTableManager? get habitId {
    final $_column = $_itemColumn<String>('habit_id');
    if ($_column == null) return null;
    final manager = $$HabitsTableTableManager(
      $_db,
      $_db.habits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GoalsTableFilterComposer extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<GoalKind, GoalKind, String> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<GoalPeriod, GoalPeriod, String> get period =>
      $composableBuilder(
        column: $table.period,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CalendarDate, CalendarDate, int>
  get createdOn => $composableBuilder(
    column: $table.createdOn,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$HabitsTableFilterComposer get habitId {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableFilterComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get period => $composableBuilder(
    column: $table.period,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdOn => $composableBuilder(
    column: $table.createdOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$HabitsTableOrderingComposer get habitId {
    final $$HabitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableOrderingComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumnWithTypeConverter<GoalKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumnWithTypeConverter<GoalPeriod, String> get period =>
      $composableBuilder(column: $table.period, builder: (column) => column);

  GeneratedColumn<int> get target =>
      $composableBuilder(column: $table.target, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CalendarDate, int> get createdOn =>
      $composableBuilder(column: $table.createdOn, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$HabitsTableAnnotationComposer get habitId {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableAnnotationComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoalsTable,
          GoalRow,
          $$GoalsTableFilterComposer,
          $$GoalsTableOrderingComposer,
          $$GoalsTableAnnotationComposer,
          $$GoalsTableCreateCompanionBuilder,
          $$GoalsTableUpdateCompanionBuilder,
          (GoalRow, $$GoalsTableReferences),
          GoalRow,
          PrefetchHooks Function({bool habitId})
        > {
  $$GoalsTableTableManager(_$AppDatabase db, $GoalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<GoalKind> kind = const Value.absent(),
                Value<String?> habitId = const Value.absent(),
                Value<GoalPeriod> period = const Value.absent(),
                Value<int> target = const Value.absent(),
                Value<CalendarDate> createdOn = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalsCompanion(
                id: id,
                title: title,
                kind: kind,
                habitId: habitId,
                period: period,
                target: target,
                createdOn: createdOn,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required GoalKind kind,
                Value<String?> habitId = const Value.absent(),
                required GoalPeriod period,
                required int target,
                required CalendarDate createdOn,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => GoalsCompanion.insert(
                id: id,
                title: title,
                kind: kind,
                habitId: habitId,
                period: period,
                target: target,
                createdOn: createdOn,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GoalsTable, GoalRow>(table),
                  $$GoalsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (habitId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.habitId,
                        referencedTable: $$GoalsTableReferences._habitIdTable(
                          db,
                        ),
                        referencedColumn: $$GoalsTableReferences
                            ._habitIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoalsTable,
      GoalRow,
      $$GoalsTableFilterComposer,
      $$GoalsTableOrderingComposer,
      $$GoalsTableAnnotationComposer,
      $$GoalsTableCreateCompanionBuilder,
      $$GoalsTableUpdateCompanionBuilder,
      (GoalRow, $$GoalsTableReferences),
      GoalRow,
      PrefetchHooks Function({bool habitId})
    >;
typedef $$AchievementUnlocksTableCreateCompanionBuilder =
    AchievementUnlocksCompanion Function({
      required String achievementId,
      required CalendarDate unlockedOn,
      required DateTime unlockedAt,
      Value<int> rowid,
    });
typedef $$AchievementUnlocksTableUpdateCompanionBuilder =
    AchievementUnlocksCompanion Function({
      Value<String> achievementId,
      Value<CalendarDate> unlockedOn,
      Value<DateTime> unlockedAt,
      Value<int> rowid,
    });

class $$AchievementUnlocksTableFilterComposer
    extends Composer<_$AppDatabase, $AchievementUnlocksTable> {
  $$AchievementUnlocksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get achievementId => $composableBuilder(
    column: $table.achievementId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CalendarDate, CalendarDate, int>
  get unlockedOn => $composableBuilder(
    column: $table.unlockedOn,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AchievementUnlocksTableOrderingComposer
    extends Composer<_$AppDatabase, $AchievementUnlocksTable> {
  $$AchievementUnlocksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get achievementId => $composableBuilder(
    column: $table.achievementId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unlockedOn => $composableBuilder(
    column: $table.unlockedOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AchievementUnlocksTableAnnotationComposer
    extends Composer<_$AppDatabase, $AchievementUnlocksTable> {
  $$AchievementUnlocksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get achievementId => $composableBuilder(
    column: $table.achievementId,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<CalendarDate, int> get unlockedOn =>
      $composableBuilder(
        column: $table.unlockedOn,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => column,
  );
}

class $$AchievementUnlocksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AchievementUnlocksTable,
          AchievementUnlockRow,
          $$AchievementUnlocksTableFilterComposer,
          $$AchievementUnlocksTableOrderingComposer,
          $$AchievementUnlocksTableAnnotationComposer,
          $$AchievementUnlocksTableCreateCompanionBuilder,
          $$AchievementUnlocksTableUpdateCompanionBuilder,
          (
            AchievementUnlockRow,
            BaseReferences<
              _$AppDatabase,
              $AchievementUnlocksTable,
              AchievementUnlockRow
            >,
          ),
          AchievementUnlockRow,
          PrefetchHooks Function()
        > {
  $$AchievementUnlocksTableTableManager(
    _$AppDatabase db,
    $AchievementUnlocksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AchievementUnlocksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AchievementUnlocksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AchievementUnlocksTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> achievementId = const Value.absent(),
                Value<CalendarDate> unlockedOn = const Value.absent(),
                Value<DateTime> unlockedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AchievementUnlocksCompanion(
                achievementId: achievementId,
                unlockedOn: unlockedOn,
                unlockedAt: unlockedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String achievementId,
                required CalendarDate unlockedOn,
                required DateTime unlockedAt,
                Value<int> rowid = const Value.absent(),
              }) => AchievementUnlocksCompanion.insert(
                achievementId: achievementId,
                unlockedOn: unlockedOn,
                unlockedAt: unlockedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AchievementUnlocksTable, AchievementUnlockRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $AchievementUnlocksTable,
                    AchievementUnlockRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AchievementUnlocksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AchievementUnlocksTable,
      AchievementUnlockRow,
      $$AchievementUnlocksTableFilterComposer,
      $$AchievementUnlocksTableOrderingComposer,
      $$AchievementUnlocksTableAnnotationComposer,
      $$AchievementUnlocksTableCreateCompanionBuilder,
      $$AchievementUnlocksTableUpdateCompanionBuilder,
      (
        AchievementUnlockRow,
        BaseReferences<
          _$AppDatabase,
          $AchievementUnlocksTable,
          AchievementUnlockRow
        >,
      ),
      AchievementUnlockRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$HabitLogsTableTableManager get habitLogs =>
      $$HabitLogsTableTableManager(_db, _db.habitLogs);
  $$RoutinesTableTableManager get routines =>
      $$RoutinesTableTableManager(_db, _db.routines);
  $$RoutineItemsTableTableManager get routineItems =>
      $$RoutineItemsTableTableManager(_db, _db.routineItems);
  $$RoutineChecksTableTableManager get routineChecks =>
      $$RoutineChecksTableTableManager(_db, _db.routineChecks);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db, _db.goals);
  $$AchievementUnlocksTableTableManager get achievementUnlocks =>
      $$AchievementUnlocksTableTableManager(_db, _db.achievementUnlocks);
}
