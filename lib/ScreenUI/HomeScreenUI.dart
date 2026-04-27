import 'package:flutter/material.dart';
import 'package:GoSaver/dialogs/addGoalDialog.dart';
import 'package:GoSaver/providers/GoalProvider.dart';
import 'package:GoSaver/screens/archivedScreen.dart';
import 'package:GoSaver/screens/goalScreen.dart';
import 'package:provider/provider.dart';
import 'package:GoSaver/method/HomeScreenMethod.dart';
import 'package:GoSaver/dialogs/longPressedDialog.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:GoSaver/models/goal.dart';

/// App Drawer UI
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 30),
          Container(
            height: 200,
            width: 310,
            child: Image.asset('assets/milk-and-mocha.gif'),
          ),
          ListTile(
            leading: const Icon(Icons.archive, color: Colors.blueGrey),
            title: const Text('Archive',
            style: TextStyle(color: Colors.black87),),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ArchivedScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

//// App Bar UI
class appBar extends StatelessWidget implements PreferredSizeWidget{
  const appBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      title: Text('Goal Dashboard',
        style: TextStyle(fontFamily: 'roboto', fontWeight: FontWeight.bold,color: Colors.white),
      ),
      centerTitle: true,
    );

  }
}

class Body extends StatefulWidget{ //// Body Creating State
  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> { //// Body UI
  final homeMethod = Homescreenmethod();
  @override
  Widget build(BuildContext context) {
    final goals = context.watch<GoalProvider>().goals;
    final formatter = NumberFormat('#,##0.00');
    return goals.isEmpty
        ? EmptyBody()
        : ListView.builder(
      itemCount: goals.length,
      itemBuilder: (context, index) {
        final goal = goals[index];
        return GoalContainer(goal: goal);/// pag di eto magets
        /// pakireview nalang sa baba yung class thank you very much :P
        ///
      },
    );
  }
}


class EmptyBody extends StatefulWidget{ ///Empty Body Creating State
  @override
  _EmptyBody createState() => _EmptyBody();
}
class _EmptyBody extends State<EmptyBody> { ///Empty Body UI
  @override
  Widget build(BuildContext context) {
   return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 46),
              child: Image.asset('assets/milk-hi.gif'),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text(
                "Seems like you are new, Let's create your first goal",
                style: TextStyle(fontSize: 15),
              ),
            ),
          )
        ],
      )
   );
  }
}

class GoalContainer extends StatefulWidget{ ///Goal Container creating state
  final Goal goal;
  const GoalContainer({super.key, required this.goal});
  @override
  _GoalContainer createState() => _GoalContainer();
}


class _GoalContainer extends State<GoalContainer>{ ///Goal Container UI
  @override
  Widget build(BuildContext context) {
    final goal = widget.goal;
    final homeMethod = Homescreenmethod();
    final formatter = NumberFormat('#,##0.00');
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GoalScreen(goal: goal),
              ),
            );
          },
          onLongPress: () {
            showDialog(
              context: context,
              builder: (_) => Longpresseddialog(goal: goal),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Color(0xFFF7FAFF),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF0B1B3A).withValues(alpha: 0.08),
                  blurRadius: 22,
                  spreadRadius: 0,
                  offset: Offset(0, 12),
                ),
              ],
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: Color(0xFFEFF3FA),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      child:
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      '${goal.goalName}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                        letterSpacing: -0.2,
                                        color: Color(0xFF111827)
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(0),
                                child: LinearPercentIndicator(
                                  width: 250,
                                  barRadius: Radius.circular(10),
                                  animation: true,
                                  lineHeight: 10.0,
                                  animationDuration: 2000,
                                  backgroundColor: Colors.grey[300],
                                  percent: homeMethod.getPercentage(goal),
                                  center: Text(
                                    "${homeMethod.gettingPercentage(goal).toStringAsFixed(2)}%",
                                    style: TextStyle(fontSize: 7),),
                                  progressColor: Colors.blue,
                                ),
                              ),
                              SizedBox(height: 10,),

                              Padding(
                                  padding:
                                  EdgeInsets.only(left: 10, top: 2),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 3),
                                        child: Text('${goal.currency} ${formatter.format(goal.goalProgress)}',
                                          style: TextStyle(color: homeMethod.conditionColorSaved(goal),fontWeight: FontWeight.w700),
                                          overflow: TextOverflow.ellipsis,),),
                                      Text(
                                        "/ ${goal.currency}${formatter.format(
                                            goal.goalAmount)}",
                                        style: TextStyle(fontWeight: FontWeight.w700,color: Color(0xFF94A3B8)),)
                                    ],
                                  )
                              ),
                            ],
                          ),
                        ],
                      )


                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
///Floating Button Creating State
class FloatingAddGoalButton extends StatefulWidget{
  @override
  _FloatingAddGoalButton createState() => _FloatingAddGoalButton();
}
///Floating Add Goal Button UI
class _FloatingAddGoalButton extends State<FloatingAddGoalButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(right: 30, bottom: 40),
      child: FloatingActionButton(onPressed: () {
        showDialog(context: context,
            barrierDismissible: true,
            builder: (_) => AddGoalDialog());
      }, child: Icon(Icons.add,color: Colors.white,),backgroundColor: Colors.blue,),);
  }

}


