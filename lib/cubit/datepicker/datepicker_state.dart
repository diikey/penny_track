part of 'datepicker_cubit.dart';

enum YearFlag { increment, decrement }

final class DatepickerState extends Equatable {
  final int? month;
  final int? year;

  const DatepickerState({required this.month, required this.year});

  DatepickerState copyWith({
    int? month,
    int? year,
  }) =>
      DatepickerState(
        month: month ?? this.month,
        year: year ?? this.year,
      );

  @override
  List<Object?> get props => [month, year];
}
