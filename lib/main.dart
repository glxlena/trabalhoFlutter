import 'package:flutter/material.dart';
import 'package:projeto_flutter/views/forms.dart';
import 'package:projeto_flutter/views/listView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 163, 33, 243)),
        useMaterial3: false,
      ),
      home: const MyWidget(),
      routes: {
        '/listarTarefas': (context) => ListViewTasks(),
        '/novaTarefa': (context) => FormsTasks()
      },
    );
  }
}
 class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Minha lista de Tarefas')),
      drawer: Drawer(
        child: Column(children: [
            UserAccountsDrawerHeader(accountName: Text('Helena', style: TextStyle(fontSize: 24)), 
            accountEmail: Text('helena@email.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white, child: Icon(Icons.person))),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Listagem de Tarefas'),
              onTap: (){
                Navigator.pushNamed(context, '/listarTarefas');
              },
              )
             
        ],),
      ),
      body: Stack(children: [
        Padding(padding: EdgeInsets.only(right: 30, bottom: 30)),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(onPressed: (){
            Navigator.pushNamed(context, '/novaTarefa');
          },
          child: Icon(Icons.add),
          )
        )
      ],)
    );
  }
}