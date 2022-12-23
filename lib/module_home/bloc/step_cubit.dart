
import 'package:flutter_bloc/flutter_bloc.dart';


class StepCubit extends Cubit<bool> {
  StepCubit() : super(true);

  next(bool bol) => emit(bol);

}

