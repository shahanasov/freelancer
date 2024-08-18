import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/login/widgets/bloc/toggle_bloc.dart';
import 'package:freelance/presentation/login/widgets/loginform.dart';
import 'package:freelance/presentation/login/widgets/signin.dart';
import 'package:freelance/presentation/login/widgets/togglebutton.dart';
import 'package:freelance/theme/color.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: white, borderRadius: BorderRadius.circular(20)),
          height: 523,
          width: 315,
          child:  SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: ToggleButton(),
                ),
                BlocBuilder<ToggleBloc, ToggleState>(
                  builder: (context, state) {
                     if(state is SignUpState){
                      return  SignIn();
                    }else{
                      return  LoginForm();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
