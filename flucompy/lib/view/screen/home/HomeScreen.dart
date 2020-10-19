import 'package:flucompy/util/Constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:share/share.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String firstInput = Constant.EMPTY_STRING;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: getHomeAppBar(),
      body: getHomeBody(),
    );
  }

  Widget getHomeAppBar() {
    return AppBar(
      title: Text(
        Constant.APP_NAME,
        style: TextStyle(
          color: Constant.COLOR_TEXT_LIGHT,
        ),
      ),
      centerTitle: false,
      backgroundColor: Theme.of(context).accentColor,
      actions: <Widget>[
        /*IconButton(
          icon: Icon(
            Icons.share,
            color: Constant.COLOR_TEXT_LIGHT,
          ),
          onPressed: () {
            onInputShare();
          },
        ),*/
      ],
    );
  }

  Widget getHomeBody() {
    return SafeArea(
        child: Container(
            padding: EdgeInsets.all(Constant.PADDING_HOME_BORDER),
            child: Center(
              child: Text(
                getCompassInfo(),
                style: TextStyle(
                  color: Constant.COLOR_TEXT_DARK,
                ),
              ),
            )));
  }

  void onInputShare() => Share.share(getCompassInfo());

  String getCompassInfo() => "TODO";
}
