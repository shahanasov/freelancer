import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/login_page/widgets/bloc/toggle_bloc.dart';
import 'package:freelance/theme/color.dart';

class ToggleButton extends StatelessWidget {
  const ToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 40,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(25.0),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: BlocBuilder<ToggleBloc, ToggleState>(
          builder: (context, state) {
            bool isLogin = state is LoginState;
            return Stack(
              children: [
                AnimatedAlign(
                  duration: const Duration(milliseconds: 300),
                  alignment:
                      isLogin ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: black,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () =>
                            context.read<ToggleBloc>().add(ToggleLogin()),
                        child: Center(
                          child: Text(
                            'Log In',
                            style: TextStyle(color: isLogin ? white : black),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () =>
                            context.read<ToggleBloc>().add(ToggleSignUP()),
                        child: Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: isLogin ? black : white),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ));
  }
}
