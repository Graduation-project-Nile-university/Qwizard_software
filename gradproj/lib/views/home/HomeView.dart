import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradproj/bloc/cubit.dart';
import 'package:gradproj/bloc/states.dart';
import 'package:gradproj/components/shared.dart';
import 'package:gradproj/views/home/drwr.dart';
import 'package:gradproj/widgets/centeredView/centeredView.dart';
import 'package:gradproj/widgets/homeBody/homeBody.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final swidth = MediaQuery.of(context).size.width;
    return BlocBuilder<AuthenticationCubit, States>(builder: (context, states) {
      return Scaffold(
        appBar: quizardAppBar(context),
        drawer: swidth < 800 ? const Drwr() : null,
        body: const centeredView(
          child: homeBody(),
        ),
      );
    });
  }
}
