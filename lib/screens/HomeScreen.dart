import 'package:flutter/material.dart';
import 'package:myfirstapp/dialogs/addGoalDialog.dart';
import 'package:myfirstapp/dialogs/longPressedDialog.dart';
import 'package:myfirstapp/providers/GoalProvider.dart';
import 'package:myfirstapp/screens/archivedScreen.dart';
import 'package:myfirstapp/screens/goalScreen.dart';
import 'package:provider/provider.dart';
import 'package:myfirstapp/dialogs/confirmationDeleteDialog.dart';
import 'package:myfirstapp/method/HomeScreenMethod.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 30,),
          Container(
            height: 200,
            width: 310,
            child: Image.asset('assets/milk-and-mocha.gif'),
            
          ),
          ListTile(
            leading: const Icon(Icons.archive, color: Colors.blueAccent),
            title: const Text('Archive'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArchivedScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.history, color: Colors.blueAccent),
            title: const Text('History'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  HomePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
class _HomePage extends State<HomePage> {
  final homeMethod = Homescreenmethod();
  @override
  Widget build(BuildContext context) {
    final goals = context.watch<GoalProvider>().goals;
    final provider = context.watch<GoalProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Goal Dashboard',
          style: TextStyle(color: Colors.white,fontFamily: 'roboto',fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.dark_mode),
            style: IconButton.styleFrom(
              backgroundColor: Colors.blue,
            ),),
        ],
      ),
      body: goals.isEmpty ? Padding(padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Padding(padding: EdgeInsets.only(top: 46),
              child: Image.asset('assets/milk-hi.gif'),),
            ),
            Center(child: Padding(padding: EdgeInsets.only(top: 40),
                child: Text("Seems like you are new, Let's create your first goal",
                  style: TextStyle(fontSize: 15),)),)
          ],
        )
      )
          : ListView.builder(
        itemCount: provider.goals.length,
        itemBuilder: (context,index){
          final goal = provider.goals[index];
        return GestureDetector(
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => GoalScreen(index:index)));

          },
          onLongPress: (){
            showDialog(context: context, builder:(_) => Longpresseddialog(goal:goal));
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(left: 10,right: 5,top: 10),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/milk-hi.gif'),
                        radius: 30,
                      )
                      ,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.only(left: 3, top: 3),
                            child: Text('${goal.goalName}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),),
                          Padding(padding: EdgeInsets.only(left: 3),
                            child: Text('${goal.currency}${goal.goalProgress.toStringAsFixed(2)} Saved         ${goal.currency}${goal.goalAmount.toStringAsFixed(2)} Goal'),),
                          Padding(padding: EdgeInsets.only(left: 3),
                            child: Text('Remaining: ${goal.currency}${homeMethod.RemainingStringMethod(goal)}'),)
                          ],
                      ),
                    ),
                    IconButton(onPressed: (){
                      showDialog(context: context, builder:(_) => ConfirmationDialog(goal:goal));
                    }, icon: Icon(Icons.delete,color: Colors.blueAccent,),
                    ),

                  ],
                ),
              ],
            ),
          ),

        );
      },
      ),
      floatingActionButton: Padding(padding: EdgeInsets.only(right: 20,bottom: 20),
        child: FloatingActionButton(onPressed: (){
          showDialog(
            context: context,
            builder: (_) => AddGoalDialog(),
          );
        },
          child: Icon(Icons.add),),),
    );
  }
}