import 'package:flutter/material.dart';
import 'package:GoSaver/dialogs/addGoalDialog.dart';
import 'package:GoSaver/dialogs/longPressedDialog.dart';
import 'package:GoSaver/method/ArchivedMethod.dart';
import 'package:GoSaver/providers/GoalProvider.dart';
import 'package:GoSaver/screens/goalScreen.dart';
import 'package:provider/provider.dart';
import 'package:GoSaver/method/HomeScreenMethod.dart';
import 'package:GoSaver/dialogs/archivedLongPressedDialog.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';
class ArchivedScreen extends StatefulWidget {
  @override
  _ArchivedScreen createState() => _ArchivedScreen();
}


class _ArchivedScreen extends State<ArchivedScreen> {
  final homeMethod = Homescreenmethod();
  @override
  Widget build(BuildContext context) {
    final archived = context.watch<GoalProvider>().archived;
    final provider = context.watch<GoalProvider>();
    final method = Archivedmethod();
    final formatter = NumberFormat('#,##0.00');
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Archive Dashboard',
          style: TextStyle(fontFamily: 'roboto',fontWeight: FontWeight.bold,color: Colors.white),),
        centerTitle: true,

      ),
      body: archived.isEmpty ? Padding(padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
                child: Padding(padding: EdgeInsets.only(top: 46),
                  child: Image.asset('assets/milk-hi.gif'),),
              ),
              Center(child: Padding(padding: EdgeInsets.only(top: 40),
                  child: Text("Seems like you don't have archived goal!",
                    style: TextStyle(fontSize: 15),)),)
            ],
          )
      )
          : ListView.builder(
        itemCount: provider.archived.length,
        itemBuilder: (context,index){
          final archive = provider.archived[index];
          return Column(
            children: [
              GestureDetector(
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (_) => ArchivedLongPressedDialog(archive: archive),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(50, 50, 93, 0.25),
                        blurRadius: 27,
                        spreadRadius: -5,
                        offset: Offset(0, 13),
                      ),
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.3),
                        blurRadius: 16,
                        spreadRadius: -8,
                        offset: Offset(0, 8),
                      )
                    ],
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            EdgeInsets.only(left: 10, right: 5, top: 10),
                            child: CircleAvatar(
                              backgroundImage:
                              AssetImage('assets/milk-hi.gif'),
                              radius: 30,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                  EdgeInsets.only(left: 10, top: 8),
                                  child: Text(
                                    '${archive.goalName}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(0),
                                  child: new LinearPercentIndicator(
                                    width: 250,
                                    barRadius: Radius.circular(10),
                                    animation: true,
                                    lineHeight: 10.0,
                                    animationDuration: 2000,
                                    percent:Archivedmethod().getPercentage(archive),
                                    center: Text("${method.gettingPercentage(archive)}%",
                                      style: TextStyle(fontSize: 7),),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: Colors.blue,
                                  ),
                                ),
                                Padding(
                                    padding:
                                    EdgeInsets.only(left: 10, top: 2),
                                    child: Row(
                                      children: [
                                        Padding(padding: EdgeInsets.only(right: 3),
                                          child: method.ExcessSaved(archive),),
                                        Text("/ ${archive.currency}${formatter.format(archive.goalAmount)}")
                                      ],
                                    )
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}