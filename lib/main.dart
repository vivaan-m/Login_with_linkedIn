import 'package:flutter/material.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:linkedinlogin/constants.dart';

import 'colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LinkedIn(),
    );
  }
}

class LinkedIn extends StatefulWidget {
  @override
  _LinkedInState createState() => _LinkedInState();
}

class _LinkedInState extends State<LinkedIn> {
  bool login = false;
  LinkedInUserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
      child: login
          ? user == null
              ? Center(
                  child: LinkedInUserWidget(
                  redirectUrl: redirectUrl,
                  clientId: clientId,
                  clientSecret: clientSecret,
                  onGetUserProfile: (LinkedInUserModel linkedInUser) {
                    setState(() {
                      user = linkedInUser;
                    });
                    print('Access token ${linkedInUser.token.accessToken}');
                    print(
                        'First name: ${linkedInUser.firstName.localized.label}');
                    print(
                        'Last name: ${linkedInUser.lastName.localized.label}');
                    print(user.profilePicture.displayImage);
                  },
                  catchError: (LinkedInErrorObject error) {
                    print('Error description: ${error.description},'
                        ' Error code: ${error.statusCode.toString()}');
                  },
                ))
              : Center(
                child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Name : " +
                            user.firstName.localized.label +
                            " " +
                            user.lastName.localized.label,textAlign: TextAlign.center,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("email : "+ user.email.elements[0].handleDeep.emailAddress,textAlign: TextAlign.center,),
                      )
                    ],
                  ),
              )
          : Center(
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: black(),
                onPressed: () {
                  setState(() {
                    login = true;
                  });
                },
                child: Text(
                  "Login With LinkedIn",
                  style: TextStyle(color: white()),
                ),
              ),
            ),
    ));
  }
}
