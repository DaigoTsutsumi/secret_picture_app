import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secret_picture2_app/filestore/user_filestore.dart';
import 'package:secret_picture2_app/firebase_options.dart';
import 'package:secret_picture2_app/pages/add_folder_page.dart';
import 'package:secret_picture2_app/pages/picture_folder_page.dart';
import 'package:secret_picture2_app/view_model/folder_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

import 'utils/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await UserFirestore.fetchUsers();
  await SharedPrefs.setPrefsInstance(); //ローカルディスク
  String? uid = SharedPrefs.fetchUid();
  print(uid);
  if (uid == null) await UserFirestore.createUser();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '秘密の写真アプリ'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(folderViewModelProvider);
    final folderNotifier = ref.read(folderViewModelProvider.notifier);

    Future<void> refreshData() async {
      await folderNotifier.getAllFolder();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              if (!await launchUrl(Uri.parse(
                  'https://doc-hosting.flycricket.io/mi-mi-noxie-zhen-apuri-privacy-policy/0d01e0b1-6777-479c-a546-1c868ea2d2dc/privacy'))) {
                throw Exception('Could not launch url');
              }
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: FutureBuilder(
          future: folderNotifier.getAllFolder(),
          builder: (context, snapshot) {
            if (state.folders.isEmpty) {
              return const Center(
                  child: Text(
                'データがない？',
              ));
            }
            return GridView.builder(
              itemCount: state.folders.length,
              itemBuilder: (context, index) {
                final folder = state.folders[index];
                return GestureDetector(
                  onTap: () async {
                    folderNotifier.updateImages(folder.imagePathList);
                    await folderNotifier.updateName(folder.name);
                    if (context.mounted) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PictureFolderPage(folder)));
                    }
                    print("フォルダ写真");
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.red,
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [],
                        ),
                        Center(child: Text(folder.name)),
                      ],
                    ),
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddFolderPage()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
