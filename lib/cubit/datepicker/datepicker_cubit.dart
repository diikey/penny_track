import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'datepicker_state.dart';

class DatepickerCubit extends Cubit<DatepickerState> {
  final DateTime initialDate;
  DatepickerCubit(this.initialDate)
      : super(DatepickerState(
            month: initialDate.month - 1, year: initialDate.year));

  void changeYear(YearFlag flag) {
    if (flag == YearFlag.increment) {
      if (state.year! + 1 > 2100) return;
      emit(state.copyWith(year: state.year! + 1));
    } else {
      if (state.year! - 1 < 2020) return;
      emit(state.copyWith(year: state.year! - 1));
    }
  }

  void changeMonth(int selectedMonth) {
    emit(state.copyWith(month: selectedMonth));
  }
}
