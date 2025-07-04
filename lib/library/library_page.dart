import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../bottom_nav_bar.dart';
import '../provider/providers.dart';

class LibraryPage extends ConsumerStatefulWidget {
  const LibraryPage({super.key});

  @override
  ConsumerState<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends ConsumerState<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    final asyncUserDoc = ref.watch(userDocStreamProvider);

    final Map<String, dynamic> userDataMap = asyncUserDoc.when(
      data: (doc) => doc.data() as Map<String, dynamic>,
      loading: () => {},
      error: (e, s) => {},
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF4FBFF),
      bottomNavigationBar: BottomNavBar(context: context, currentIndex: 2, user: userDataMap),
      body: Column(
        children: [

        ],
      ),
    );
  }

}