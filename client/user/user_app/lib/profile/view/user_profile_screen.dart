import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_app/auth/viewmodel/auth_view_model.dart';

class UserProfileScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);
    final authViewModel = ref.read(authViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: authState.userProfile == null
          ? Center(
              child: ElevatedButton(
                onPressed: () {
                  if (authState.userId != null) {
                    authViewModel.fetchProfile(authState.userId!);
                  }
                },
                child: Text('Fetch Profile'),
              ),
            )
          : Column(
              children: [
                ListTile(
                  title: Text('Email'),
                  subtitle: Text(authState.userProfile!['email'] ?? 'N/A'),
                ),
                ListTile(
                  title: Text('Name'),
                  subtitle: Text(authState.userProfile!['name'] ?? 'N/A'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    authViewModel.logout();
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text('Logout'),
                ),
              ],
            ),
    );
  }
}

















// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:user_app/auth/viewmodel/auth_view_model.dart';

// class UserProfileScreen extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authState = ref.watch(authViewModelProvider);
//     final authViewModel = ref.read(authViewModelProvider.notifier);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Profile'),
//       ),
//       body: authState.userProfile == null
//           ? Center(
//               child: ElevatedButton(
//                 onPressed: () async {
//                   authViewModel.fetchProfile();
//                   print(await authViewModel.fetchProfile().toString());
//                 },
//                 child: Text('Fetch Profile'),
//               ),
//             )
//           : Column(
//               children: [
//                 ListTile(
//                   title: Text('Email'),
//                   subtitle: Text(authState.userProfile!['email']),
//                 ),
//                 ListTile(
//                   title: Text('Name'),
//                   subtitle: Text(authState.userProfile!['name']),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     authViewModel.logout();
//                     Navigator.pushReplacementNamed(context, '/login');
//                   },
//                   child: Text('Logout'),
//                 ),
//               ],
//             ),
//     );
//   }
// }
