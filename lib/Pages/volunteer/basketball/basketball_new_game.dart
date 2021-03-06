import 'package:flutter/material.dart';
import 'package:groundlia/Pages/Api/upload.dart';
import 'package:groundlia/Pages/util/Constants.dart';
import 'package:groundlia/Pages/util/Data.dart';

class BasketballNewGame extends StatefulWidget {
  LData data1;
  SData data2;
  BasketballNewGame(this.data1, this.data2);

  @override
  _BasketballNewGameState createState() => _BasketballNewGameState();
}

class _BasketballNewGameState extends State<BasketballNewGame> {
  int players = 1;
  List<String> Team1 = [""];
  List<String> Team2 = [""];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent[400],
          title: Text("New basketball Game"),
        ),
        body: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
          color: Colors.grey[800],
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text("No. of Players: ", style: TextStyle(
                      fontFamily: "mainfont",
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent[400],
                    ),),

                    Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              players++;
                              Team1.add("");
                              Team2.add("");
                              if(players > 9){players = 9;
                              Team1.removeLast();
                              Team2.removeLast();
                              }
                            });
                          },
                          child: Container(
                            child: Icon(Icons.arrow_circle_up_rounded,size: 50.0,color: Colors.blue,),
                          ),
                        ),
                        Text(players.toString(), style: TextStyle(
                          fontFamily: "mainfont",
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent[400],
                        ),),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              players--;
                              Team1.removeLast();
                              Team2.removeLast();
                              if(players < 1){players = 1;
                              Team1.add("");
                              Team2.add("");};
                            });
                          },
                          child: Container(
                            child: Icon(Icons.arrow_circle_down_rounded,size: 50.0,color: Colors.red,),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30.0,),
                Text("Team1: ", style: TextStyle(
                  fontFamily: "mainfont",
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent[400],
                ),),

                for(int i = 0; i < players; i++)Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 2 + 50,
                    child: TextField(
                      onChanged: (val) {
                        Team1[i] = val;
                      },
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: "Members Name",
                      ),
                    )),
                SizedBox(height: 30.0,),
                Text("Team2: ", style: TextStyle(
                  fontFamily: "mainfont",
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent[400],
                ),),

                for(int i = players - 1; i >= 0; i--)Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 2 + 50,
                    child: TextField(
                      onChanged: (val) {
                        Team2[i] = val;
                      },
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: "Members Name",
                      ),
                    )),

                SizedBox(height: 30.0,),
                GestureDetector(
                  onTap: () async {
                    upload up = new upload();
                    if (widget.data1.code != "") {
                      await up.createbasketball(
                          widget.data1.code, players, Team1, Team2);
                    }
                    else {
                      await up.createbasketball(
                          widget.data2.OrganizerCode, players, Team1, Team2);
                    }
                    Navigator.of(context).pop(true);
                    Navigator.pushNamed(context, "/updatebasketball");
                    print("team1: " + Team1.toString());
                    print("team2: " + Team2.toString());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: borderRadius(25.0),
                      color: Colors.greenAccent[400],),
                    height: 60.0,
                    width: 100.0,
                    child: Center(child: Text("done",
                      style: TextStyle(fontSize: 35.0, fontWeight: FontWeight
                          .bold, fontFamily: "mainfont"),)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
