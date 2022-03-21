part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;

  AccountConfirmationPage(this.registrationData);

  @override
  _AccountConfirmationPageState createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  bool isSigninggnUp = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .read<PageBloc>()
            .add(GoToRegistrationPage(widget.registrationData));

        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 90, top: 20),
                    height: 56,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              context.read<PageBloc>().add(GoToSplashPage());
                            },
                            child: Icon(Icons.arrow_back, color: Colors.black),
                          ),
                        ),
                        Center(
                          child: Text("Konfirmasi Akun\nBaru",
                              style: blackTextFont.copyWith(fontSize: 20),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image:
                                (widget.registrationData.profilePicture == null)
                                    ? AssetImage("assets/user_pic.png")
                                    : FileImage(
                                        widget.registrationData.profilePicture),
                            fit: BoxFit.cover)),
                  ),
                  Text(
                    "Selamat Datang",
                    style: blackTextFont.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    "${widget.registrationData.name}",
                    textAlign: TextAlign.center,
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 110,
                  ),
                  (isSigninggnUp)
                      ? SpinKitCircle(
                          color: Color(0xFF3E9D9D),
                          size: 45,
                        )
                      : SizedBox(
                          width: 250,
                          height: 45,
                          child: RaisedButton(
                              color: Color(0xFF3E9D9D),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                "Buat Akun Saya",
                                style: whiteTextFont.copyWith(fontSize: 16),
                              ),
                              onPressed: () async {
                                setState(() {
                                  isSigninggnUp = true;
                                });

                                imageFileToUpload =
                                    widget.registrationData.profilePicture;

                                SignInSignUpResult result =
                                    await AuthServices.signUP(
                                        widget.registrationData.email,
                                        widget.registrationData.password,
                                        widget.registrationData.name);

                                if (result.user == null) {
                                  setState(() {
                                    isSigninggnUp = false;
                                  });

                                  Flushbar(
                                      duration: Duration(milliseconds: 1500),
                                      flushbarPosition: FlushbarPosition.TOP,
                                      backgroundColor: Color(0xFFFF5C83),
                                      message: result.messege)
                                    ..show(context);
                                }
                              }))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
