import 'package:bloc/bloc.dart';

class AppThemeCubit extends Cubit<AppTheme> {
  AppThemeCubit() : super(AppTheme.light);

  void toggleTheme() {
    emit(state == AppTheme.light ? AppTheme.dark : AppTheme.light);
  }
}

enum AppTheme { light, dark }
