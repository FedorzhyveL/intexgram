import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intexgram/Presentation/Routes/router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      router.push(const SignInPageRoute());
    } else {
      resolver.next(true);
    }
  }
}
