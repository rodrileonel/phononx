import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phononxchallenge/app/users/bloc/users_bloc.dart';
import 'package:phononxchallenge/app/users/pages/users_list_page.dart';

import 'core/di.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<UsersBloc>(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kasalista App',
        initialRoute: UsersListPage.routeName,
        routes: {
          UsersListPage.routeName: (_) => const UsersListPage(),
        },
      ),
    );
  }
}
