import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clover/bloc/event_logger.dart';
import 'package:clover/bloc/prize.bloc.dart';
import 'package:clover/bloc/session.bloc.dart';
import 'package:clover/bloc/user.bloc.dart';
import 'package:clover/common/bloc_handlers.dart';
import 'package:clover/common/router.dart';
import 'package:clover/repositories/_client.dart';
import 'package:clover/repositories/prize.dart';
import 'package:clover/repositories/session.dart';
import 'package:clover/repositories/user.dart';
import 'package:clover/views/splash/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Bloc.observer = BlocEventLogger();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final AppwriteClient _client;
  late final SessionRepository _sessionRepository;
  late final UserRepository _userRepository;
  late final PrizeRepository _prizeRepository;

  @override
  void initState() {
    super.initState();
    _client = AppwriteClient();
    _sessionRepository = SessionRepository(account: _client.account);
    _userRepository = UserRepository(db: _client.db);
    _prizeRepository = PrizeRepository(db: _client.db);
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        BlocProvider<SessionCubit>(
          create: (BuildContext context) => SessionCubit(sessionRepository: _sessionRepository),
        ),
        BlocProvider<UserCubit>(
          create: (BuildContext context) => UserCubit(userRepository: _userRepository),
        ),
        BlocProvider<PrizeCubit>(
          create: (BuildContext context) => PrizeCubit(prizeRepository: _prizeRepository),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  void initState() {
    super.initState();
    context.read<SessionCubit>().get();
  }

  void _handleGetSessionSuccess(GetSessionSuccess state) {
    context.read<UserCubit>().findById(state.session.$id);
  }

  void _handleFindUserByIdSuccess(FindUserByIdSuccess state) {
    Routing(context).home(state.user);
  }

  void _handleGetSessionFailure(GetSessionFailure state) {
    Routing(context).askPhoneNumber();
  }

  void _handleFindUserByIdFailure(FindUserByIdFailure state) {
    Routing(context).askPhoneNumber();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MultiBlocListener(
          listeners: [
            BlocListener<SessionCubit, SessionState>(
              listener: (context, state) {
                switch (state) {
                  case SessionFailure _:
                    handleFailure(context, state.failure);
                  case GetSessionSuccess _:
                    _handleGetSessionSuccess(state);
                  case GetSessionFailure _:
                    _handleGetSessionFailure(state);
                }
              },
            ),
            BlocListener<UserCubit, UserState>(
              listener: (context, state) {
                switch (state.runtimeType) {
                  case == FindUserByIdSuccess:
                    _handleFindUserByIdSuccess(state as FindUserByIdSuccess);
                  case == FindUserByIdFailure:
                    _handleFindUserByIdFailure(state as FindUserByIdFailure);
                }
              },
            ),
          ],
          child: const LoadingSplash(),
        );
      },
    );
  }
}
