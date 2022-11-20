import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/model/error_model.dart';
import 'package:google_docs_clone/model/user_model.dart';
import 'package:google_docs_clone/utils/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

final authRepositoryProvider = Provider(
    (ref) => AuthRepository(googleSignIn: GoogleSignIn(), client: Client()));

final userProvider = StateProvider<UserModel?>((res) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;

  AuthRepository({required GoogleSignIn googleSignIn, required Client client})
      : _googleSignIn = googleSignIn,
        _client = client;

  Future<ErrorModel> signInWithGoogle() async {
    ErrorModel errorModel =
        ErrorModel(data: null, error: 'some unexpected error occured');
    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        final userAcc = UserModel(
            name: user.displayName ?? "",
            profilePic: user.photoUrl ?? "",
            email: user.email,
            token: "",
            uid: "");

        final result = await _client.post(Uri.parse('$host$apiSignUpUrl'),
            body: userAcc.toJson(),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            });

        switch (result.statusCode) {
          case 200:
            print("sign up error ${result.body}");
            final newUser = userAcc.copyWith(
                uid: jsonDecode(result.body)['user'][0]['_id'], token: "");
            errorModel = ErrorModel(error: null, data: newUser);
            break;
        }
      }
    } catch (e) {
      print('$e');
      errorModel = ErrorModel(error: e.toString(), data: null);
    }
    return errorModel;
  }
}
