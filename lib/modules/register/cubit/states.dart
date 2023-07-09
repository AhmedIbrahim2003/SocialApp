// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterPasswordState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final String? error;
  RegisterErrorState({this.error});
}

class CreatUserLoadingState extends RegisterStates {}

class CreatUserSuccessState extends RegisterStates {}

class CreatUserErrorState extends RegisterStates {
  final String? error;
  CreatUserErrorState({this.error});
}
