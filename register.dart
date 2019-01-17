import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Flutter Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String phpMsg;
  String regInfo;

  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  sendData() async{

    final response = await http.post("http://172.19.1.134/mb/index.php", body:{
      "username":user.text,
      "password":pass.text,
    });

    //---- Info -------
    phpMsg =  response.body.toString();
    setState(() {
      if(phpMsg==null){
        regInfo = "Register yourself please ";
      }else{
        regInfo =  "Yes you registered yourself";
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'User Registration',style: TextStyle(fontSize:30.0,color:Colors.green),
            ),
            Text('$regInfo',style: TextStyle(fontSize:20.0,color:Colors.red),),

            TextFormField(//--- name ------
              controller: user,
              decoration: const InputDecoration(
                icon: Icon(Icons.supervised_user_circle),
                hintText: 'They call me ...',
                labelText: 'Name *',
              ),
              onSaved: (String value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String value) {
                return value.contains('@') ? 'Do not use the @ char.' : null;
              },
            ),
            TextFormField(
              controller: pass,
              obscureText: true,
              decoration: const InputDecoration(
                icon: Icon(Icons.lock),
                hintText: 'Here your password ?',
                labelText: 'Password *',
              ),
              onSaved: (String value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String value) {
                // return value.contains('@') ? 'Do not use the @ char.' : null;
              },
            ),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          sendData();
          user.clear();
          pass.clear();
        },
        tooltip: 'Increment',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
