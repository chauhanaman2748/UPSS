import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home_screen.dart';


// ignore: must_be_immutable
class SendMail extends StatefulWidget {
  @override
  _mail createState() => _mail();
}

class _mail extends State<SendMail> {

  TextEditingController _msg = new TextEditingController();
  TextEditingController _name = new TextEditingController();
  TextEditingController _flat = new TextEditingController();
  bool _isButtonDisabled;
  bool _v1 = false;
  bool _v2 = false;
  bool _v3 = false;

  @override
  void initState() {
    _isButtonDisabled = false;
  }

  void _incrementCounter() {
    setState(() {
      _isButtonDisabled = true;
      Fluttertoast.showToast(
          msg: "Sending Message",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 15,
          textColor: Colors.white
      );
      CircularProgressIndicator();
      if(_name.text == null || _name.text.isEmpty){
        _name.text.isEmpty ? _v1 = true : _v1 = false;
      }
      else if(_flat.text == null || _flat.text.isEmpty){
        _flat.text.isEmpty ? _v2 = true : _v2 = false;
      }
      else if(_msg.text == null || _msg.text.isEmpty){
        _msg.text.isEmpty ? _v3 = true : _v3 = false;
      }
      else{
        sendMail(_msg.text.toString(),_name.text.toString(),_flat.text.toString(),context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Image(image: AssetImage('assets/MIN2.png')),
        Container(
          color: Colors.black,
          margin: EdgeInsets.all(15),
          alignment: Alignment.center,
          child: Text(
            'Reach Out To Us',
            style: TextStyle(
                fontSize: 30,
                color: Colors.white
            ),
          ),
        ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(child: Column(
                      children: <Widget>[
                        TextField(
                          controller: _name,
                          decoration: InputDecoration(
                              hintText: "Please Enter Your Name",
                            errorText: _v1 ? "Name field can not be empty." : null,
                          ),
                          maxLines: null,
                        ),
                        TextField(
                          controller: _flat,
                          decoration: InputDecoration(
                              hintText: "Please Enter Your Flat No. as F-214",
                            errorText: _v2 ? "Flat No. can not be empty." : null,
                          ),
                          maxLines: null,
                        ),
                        TextField(
                          controller: _msg,
                          decoration: InputDecoration(
                            hintText: "Please write down your issues to us",
                            errorText: _v3 ? "Please Enter Some Message" : null,
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                        RaisedButton(onPressed: (){
                          _isButtonDisabled ? null : _incrementCounter();
                        },child: Text('Send',style: TextStyle(color: Colors.white),),
                          color: Colors.lightBlueAccent,
                        )
                      ],
                    ),elevation: 3,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


sendMail(String _msg, String _name, String _flat, BuildContext context) async {
  String username = 'urbanparivarsevasamiti@gmail.com';
  String password = 'aman2748';
  //String domainSmtp = 'mail.domain.com';

  //also use for gmail smtp
  final smtpServer = gmail(username, password);

  //user for your own domain
  //final smtpServer = SmtpServer(domainSmtp,username: username,password: password,port: 587);

  final message = Message()
    ..from = Address(username, 'Your name')
    ..recipients.add('urbanparivarsevasamiti@gmail.com')
  //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
  //..bccRecipients.add(Address('bccAddress@example.com'))
    ..subject = 'Issue by $_name from $_flat at ${DateTime.now()}'
    ..text = _msg;
    //..html = "<h1>Shawon</h1>\n<p>Hey! Here's some HTML content</p>";

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
    sleep(Duration(seconds:1));
    Fluttertoast.showToast(
      msg: "Message Delivered",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      fontSize: 15,
      textColor: Colors.white
    );
  } on MailerException catch (e) {
    print('Message not sent.');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
    sleep(Duration(seconds:1));
    Fluttertoast.showToast(
        msg: "Message Not Send, Please Try Again",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 15,
        textColor: Colors.white
    );
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }

}
