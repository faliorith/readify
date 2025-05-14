import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc(this._authService) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignInRequested>(_onSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<UpdateProfileRequested>(_onUpdateProfileRequested);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _authService.getCurrentUser();
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _authService.signUp(
        email: event.email,
        password: event.password,
        name: event.name,
      );
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _authService.signIn(
        email: event.email,
        password: event.password,
      );
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authService.signOut();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onUpdateProfileRequested(
    UpdateProfileRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is Authenticated) {
        await _authService.updateProfile(
          userId: currentState.user.id,
          name: event.name,
          photoUrl: event.photoUrl,
        );
        final updatedUser = await _authService.getCurrentUser();
        if (updatedUser != null) {
          emit(Authenticated(updatedUser));
        }
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
} 