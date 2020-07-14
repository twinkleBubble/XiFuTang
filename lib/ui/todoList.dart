import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ashflutter/ui/addtodo.dart';
import 'package:ashflutter/ui/model/todoModel.dart';

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {

  bool value=false;
  List<ToDoModel> todoList= List<ToDoModel>();
  var selectedIndex;
  var status="Incomplete";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("To-Do-List",style: TextStyle(
                color: Colors.black
            ),),
            centerTitle: false,
            backgroundColor: Color(0XFFf8ab1c),
          ),
          body: Stack(
            children: <Widget>[
              todoList.length>0?ListView.builder(itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=> AddToDo(todoList: todoList[index],),
                        maintainState: true
                    )).then((value) {
                      setState(() {

                      });
                    });
                  },
                  child: Card(
                    key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(todoList.elementAt(index).title,style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: (){
                                      var alert=AlertDialog(
                                        title: Text("To-Do List"),
                                        content: Text("Are you sure you want to delete this To-Do task",style: TextStyle(fontSize: 17),),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("Yes",style: TextStyle(color: Colors.black,fontSize: 17.0),),
                                            onPressed: (){
                                              todoList.removeAt(index);
                                              Navigator.of(context, rootNavigator: true).pop('dialog');
                                              setState(() {

                                              });
                                            },
                                          ),
                                          FlatButton(
                                            child: Text("No",style: TextStyle(color: Colors.black,fontSize: 17.0),),
                                            onPressed: (){

                                              Navigator.of(context, rootNavigator: true).pop('dialog');
                                            },
                                          ),
                                        ],
                                      );
                                      showDialog(context: context,
                                          builder: (_){
                                            return alert;
                                          });

                                    },
                                    icon: Icon(Icons.delete,color: Color(0XFFe5dbc8),),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  getDate("Start Date",formatDate(todoList[index].startTimeStamp, "dd MMM yyyy")),
                                  getDate("End Date",formatDate(todoList[index].endTimeStamp, "dd MMM yyyy")),
                                  getDate("Time Left",getDifference(DateTime.now().millisecondsSinceEpoch~/1000>todoList[index].startTimeStamp?
                                  DateTime.now().millisecondsSinceEpoch~/1000:
                                  todoList[index].startTimeStamp, todoList[index].endTimeStamp)),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),

                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          color: Color(0XFFe5dbc8),
                          padding: EdgeInsets.only(left:20.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text("status",style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 13.0,
                                  ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Text(todoList.elementAt(index).isChecked?status="Complete":"Incomplete",style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold
                                    ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text("Tick if Completed",style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13.0,
                                  ),
                                  ),
                                  Checkbox(
                                    onChanged: (value){
                                      todoList.elementAt(index).isChecked=!todoList.elementAt(index).isChecked;

                                      setState(() {

                                      });

                                    },
                                    activeColor: Colors.black,
                                    value: todoList.elementAt(index).isChecked,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );

              },
                itemCount: todoList.length,
                physics: ClampingScrollPhysics(),
              ): Container(
                child: Center(
                  child: Text("Press + to create your first To-Do",style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0
                  ),),
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                left: 0.0,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=> AddToDo(),
                        maintainState: true
                    )).then((value) {
                      if(value!=null){
                        ToDoModel todoModel = value;
                        todoList.add(todoModel);
                        setState(() {

                        });
//                        print("title ${todoModel.title} endtime ${todoModel.endTimeStamp} start time ${todoModel.startTimeStamp}");
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.only(bottom: 50.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static String formatDate(int timestamp,String formet) {
    var format = new DateFormat(formet);
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return format.format(date);
  }
  static String getDifference(int startTimestamp,int endTimestamp) {
    var startdate = new DateTime.fromMillisecondsSinceEpoch(startTimestamp * 1000);
    var enddate = new DateTime.fromMillisecondsSinceEpoch(endTimestamp * 1000);
    int miliseconds = enddate.difference(startdate).inMilliseconds;
    String audioDuration;
    double seconds = (miliseconds / 1000) % 60;
    double minutes = (miliseconds / (1000 * 60)) % 60;
    double hour = miliseconds / (1000 * 60 * 60);


    int hours = hour.toInt();
    int min = minutes.toInt();
    int sec = seconds.toInt();
    String hourtext,minutetext,secondstext;
    if(hours<=9){
      hourtext="0"+hours.toString();
    }else{
      hourtext=hours.toString();
    }
    if(min<=9){
      minutetext="0"+min.toString();
    }else{
      minutetext=min.toString();
    }
    if(sec<=9){
      secondstext="0"+sec.toString();
    }else{
      secondstext=sec.toString();
    }
    double minuteCount=(miliseconds / (1000 * 60));
    print("hours $hours");
    // setState(() {
    if(hours>0){
      audioDuration =
          hourtext + " hrs " + minutetext + " min";
      return audioDuration;
    }else{
      audioDuration =
          minutetext + " min" ;
      return audioDuration;
    }

  }




  Widget getDate(String date,String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(date,style: TextStyle(
          color: Colors.black,
          fontSize: 15.0,
        ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(time,style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold
        ),
        ),

      ],
    );
  }
}
