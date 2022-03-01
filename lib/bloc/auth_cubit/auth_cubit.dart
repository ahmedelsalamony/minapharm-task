import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login(
      {required String userName, required String password}) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: userName, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      print('what happens here $e');
      if (e.code == 'weak-password') {
        emit(LoginFailure(errorMsg: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(LoginFailure(
            errorMsg: 'The account already exists for that email.'));
      } else {
        emit(LoginFailure(errorMsg: e.code));
      }
    }
  }

  Future<void> register(
      {required String name,
      required String userName,
      required String password}) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: userName, password: password);
      print('success  ${userCredential.user}');
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(errorMsg: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(
            errorMsg: 'The account already exists for that email.'));
      } else {
        emit(RegisterFailure(errorMsg: e.code));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signout() async {
    emit(AuthLoading());
    await auth.signOut();
    emit(SignOutSuccess());
  }
}
