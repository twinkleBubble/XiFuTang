

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ashflutter/ui/model/todoModel.dart';

class AddToDo extends StatefulWidget {
  ToDoModel todoList;
  AddToDo({this.todoList});

  @override
  _AddToDoState createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {

  static DateTime selectedDate;
  static DateTime selectedEndDate;
  String scheduledDate ="Select a date";
  String scheduledEndDate ="Select a date";
  TextEditingController toDoController = TextEditingController();
  FocusNode focusNode= FocusNode();
  ToDoModel toDoModel;

  @override
  void initState() {
    if(widget.todoList!=null){
      toDoController.text=widget.todoList.title;
      selectedDate=DateTime.fromMillisecondsSinceEpoch(widget.todoList.startTimeStamp * 1000);
      selectedEndDate=DateTime.fromMillisecondsSinceEpoch(widget.todoList.endTimeStamp * 1000);
      scheduledEndDate= new DateFormat('dd/MM/yyyy').format(selectedEndDate);
      scheduledDate= new DateFormat('dd/MM/yyyy').format(selectedDate);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0XFFf8ab1c),
            title:Text(widget.todoList!=null?"Edit List":"Add new To-Do List",style: TextStyle(
                color: Colors.black
            ),),
            centerTitle: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.black,
              iconSize: 20.0,
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top:30.0,),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                        child: Text("To-Do Title",style: TextStyle(
                            color: Colors.black,fontSize: 15.0
                        ),),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5.0,bottom: 5.0,right: 8.0,left: 8.0),
                        margin: EdgeInsets.only(top: 7.0,left: 20.0,right: 20.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),),
                        child: TextFormField(
                          controller: toDoController,
                          keyboardType: TextInputType.multiline,
                          textCapitalization: TextCapitalization.sentences,
                          maxLines: 4,
                          focusNode: focusNode,
                          textInputAction: TextInputAction.newline,
                          obscureText: false,
                          decoration: InputDecoration(

                              hintText: "Please key in your To-Do title here",
                              hintStyle: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Helvetica',
                              ),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none)
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 13.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                        child: Text("Start Date",style: TextStyle(
                            color: Colors.black,fontSize: 15.0
                        ),),
                      ),
                      GestureDetector(
                        onTap: (){
                          focusNode.unfocus();
                          FocusScope.of(context).requestFocus(null);
                          _selectDate(context);
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 10.0,bottom: 10.0,right: 8.0,left: 8.0),
                          margin: EdgeInsets.only(top: 7.0,left: 20.0,right: 20.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(scheduledDate,style: TextStyle(
                                  color: Colors.grey,fontSize: 13.0
                              ),),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 15.0,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                        child: Text("Estimate End Date",style: TextStyle(
                            color: Colors.black,fontSize: 15.0
                        ),),
                      ),
                      GestureDetector(
                        onTap: (){
                          focusNode.unfocus();
                          FocusScope.of(context).requestFocus(null);
                          if(selectedDate!=null){
                            _selectEndDate(context);
                          }else{
                            Fluttertoast.showToast(msg: "Please select Start date first");
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 10.0,bottom: 10.0,right: 8.0,left: 8.0),
                          margin: EdgeInsets.only(top: 7.0,left: 20.0,right: 20.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(scheduledEndDate,style: TextStyle(
                                  color: Colors.grey,fontSize: 13.0
                              ),),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 15.0,
                              )
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  if(isValid()){
                    if(widget.todoList!=null){
                      widget.todoList.title=toDoController.text.trim();
                      widget.todoList.endTimeStamp=selectedEndDate.millisecondsSinceEpoch~/1000;
                      widget.todoList.startTimeStamp=selectedDate.millisecondsSinceEpoch~/1000;
                      selectedDate=null;
                      selectedEndDate=null;
                      Navigator.pop(context);
                    }else{
                      toDoModel = ToDoModel();
                      toDoModel.title=toDoController.text.trim();
                      toDoModel.isChecked=false;
                      toDoModel.endTimeStamp=selectedEndDate.millisecondsSinceEpoch~/1000;
                      toDoModel.startTimeStamp=selectedDate.millisecondsSinceEpoch~/1000;
                      selectedDate=null;
                      selectedEndDate=null;
                      Navigator.pop(context,toDoModel);
                    }
                  }
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      widget.todoList!=null?"Edit now":"Create now",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0
                      ),
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


  void _selectDate(BuildContext context) async{
    var now = new DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate != null  ? DateTime(selectedDate.year,selectedDate.month,selectedDate.day) : now,
        firstDate: now,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(//OK/Cancel button text color
                primaryColor: Color(0XFFf8ab1c),//Head background
                accentColor: Color(0XFFf8ab1c)//selection color
              //dialogBackgroundColor: Colors.white,//Background color
            ),
            child: child,
          );
        },
        lastDate: DateTime.now().add(Duration(days: 29)));
    if (picked != null && picked != selectedDate) {
      if (!mounted) {
        return;
      }
      setState(() {
        selectedDate = picked;
        scheduledDate = new DateFormat('dd/MM/yyyy').format(selectedDate);
      });

    }
  }

  void _selectEndDate(BuildContext context) async{
    var now = new DateTime(selectedDate.year,selectedDate.month,selectedDate.day);
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedEndDate != null  ? DateTime(selectedEndDate.year,selectedEndDate.month,selectedEndDate.day) : now,
        firstDate: now,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(//OK/Cancel button text color
                primaryColor: Color(0XFFf8ab1c),//Head background
                accentColor: Color(0XFFf8ab1c)//selection color
              //dialogBackgroundColor: Colors.white,//Background color
            ),
            child: child,
          );
        },
        lastDate: DateTime.now().add(Duration(days: 29)));
    if (picked != null && picked != selectedDate) {
      if (!mounted) {
        return;
      }
      setState(() {
        selectedEndDate = picked;
        scheduledEndDate = new DateFormat('dd/MM/yyyy').format(selectedEndDate
        );
      });

    }
  }

  bool isValid() {
    if(toDoController.text.trim().isEmpty){
      Fluttertoast.showToast(msg: "Please enter to-do title");
      return false;
    }else if(selectedDate==null){
      Fluttertoast.showToast(msg: "Please select start date first");
      return false;
    }else if(selectedEndDate==null){
      Fluttertoast.showToast(msg: "Please select estimated end date first");
      return false;
    }else{
      return true;
    }
  }
}
