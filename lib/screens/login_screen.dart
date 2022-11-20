import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_docs_clone/repository/auth_repository.dart';
import 'package:google_docs_clone/screens/home_screen.dart';

import '../utils/values/consant_colors.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  void signInWithGoogle(WidgetRef ref, BuildContext context) async {
    final sMessanger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final errorModel =
        await ref.read(authRepositoryProvider).signInWithGoogle();
    if (errorModel.error != null) {
      sMessanger.showSnackBar(SnackBar(content: Text("${errorModel.error}")));
    } else {
      ref.read(userProvider.notifier).update((state) => errorModel.data);
      navigator.push(MaterialPageRoute(builder: ((context) => const HomeScreen())));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
          child: ElevatedButton.icon(
        onPressed: () => signInWithGoogle(ref, context),
        icon: SvgPicture.asset(
          "assets/images/icon_google.svg",
          height: 48,
          width: 48,
        ),
        label: Text(
          "Sign In with Google",
          style: TextStyle(color: kBlackColor),
        ),
        style: ElevatedButton.styleFrom(backgroundColor: kWhiteColor),
      )),
    );
  }
}
