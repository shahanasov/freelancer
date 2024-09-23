import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/theme/color.dart';

import 'widgets/bloc/toggle_bloc.dart';
import 'widgets/login_form.dart';
import 'widgets/sign_up.dart';
import 'widgets/login_toggle_button.dart';

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
                      return  SignUp();
                    }else {
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
