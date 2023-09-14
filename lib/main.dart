import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:secret_picture2_app/filestore/folder_firestore.dart';
import 'package:secret_picture2_app/filestore/user_filestore.dart';
import 'package:secret_picture2_app/firebase_options.dart';
import 'package:secret_picture2_app/pages/add_file_page.dart';
import 'package:secret_picture2_app/pages/picture_file_page.dart';
import 'package:secret_picture2_app/pages/terms_page.dart';

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
  runApp(const MyApp());
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TermsFile()));
              print('設定画面');
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: FolderFirestore.getAllFolder(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text(
              'データがない？',
            ));
          }
          return GridView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final folder = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PictureFile(folder)));
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
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddFile()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        //Contaioer(width:20,height:20
        //decotion:BoxDecorantion)
        //bo
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
