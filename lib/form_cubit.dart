import 'package:flutter_bloc/flutter_bloc.dart';

class FormCubit extends Cubit<Map<String, dynamic>> {
  FormCubit(Map<String, dynamic> initialState) : super(initialState);

  save({required Map<String, dynamic> formValue}) {
    emit(formValue);
  }
}
