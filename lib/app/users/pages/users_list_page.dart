import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phononxchallenge/app/users/bloc/users_bloc.dart';
import 'package:phononxchallenge/domain/models/user.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({Key? key}) : super(key: key);

  static const routeName = '';

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  final userController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              key: const Key('textfield'),
              controller: userController,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                BlocProvider.of<UsersBloc>(context).add(GetUserEvent(value));
              },
            ),
          ),
          BlocBuilder<UsersBloc, UsersState>(
            builder: (context, state) {
              if(state is SuccessfulState) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (BuildContext context, int index) {
                      return UserContainer(user:state.users[index]);
                    },
                  ),
                );
              } else if(state is LoadingState){
                return const Center(child: CircularProgressIndicator());
              } else if(state is ErrorState){
                return Center(child: Text(state.message));
              }else{
                return const SizedBox.shrink();
              }
            },
          )
        ],
      ),
    );
  }
}

class UserContainer extends StatelessWidget {

  final User user;

  const UserContainer({super.key, required this.user});
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(user.avatar??'', height: 50, width: 50,),
            const SizedBox(width: 8),
            Column(
              children: [
                Text(user.name??''),
                Text('${user.repositories} repositories'),
              ],
            ),
          ],
        ),
      )
    );
  }
}
