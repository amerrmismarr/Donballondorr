import 'package:flutter/material.dart';

class PredictionsAlertDialog extends StatefulWidget {

  @required String homeTeamName;
  @required String awayTeamName;
  @required String homeTeamLogo;
  @required String awayTeamLogo;
  @required String statusShort;

  PredictionsAlertDialog({this.awayTeamName,this.awayTeamLogo,this.homeTeamLogo,this.homeTeamName,
  this.statusShort});


  @override
  _PredictionsAlertDialogState createState() => _PredictionsAlertDialogState();
}

class _PredictionsAlertDialogState extends State<PredictionsAlertDialog> {



  

  @override
  Widget build(BuildContext context) {
      createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Color.fromRGBO(41, 48, 67, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              height: 200.0,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                height: 20.0,
                                width: 20.0,
                                child: Image.network(widget.homeTeamLogo),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                widget.homeTeamName,
                                style: TextStyle(
                                  color: Color.fromRGBO(222, 177, 92, 1),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              widget.statusShort == 'NS' || widget.statusShort == 'TBD'
                                  ? Container(
                                      color: Color.fromRGBO(222, 177, 92, 1),
                                      height: 30.0,
                                      width: 30.0,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        onChanged: (val) {
                                        },
                                      ),
                                    )
                                  : Container(
                                      child: Container(
                                      child: Text(
                                        'X',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              SizedBox(
                                width: 25.0,
                              )
                            ],
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                height: 20.0,
                                width: 20.0,
                                child: Image.network(widget.awayTeamLogo),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                widget.awayTeamName,
                                style: TextStyle(
                                  color: Color.fromRGBO(222, 177, 92, 1),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              widget.statusShort == 'NS' || widget.statusShort == 'TBD'
                                  ? Container(
                                      color: Color.fromRGBO(222, 177, 92, 1),
                                      height: 30.0,
                                      width: 30.0,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        onChanged: (val) {
                                        },
                                      ),
                                    )
                                  : Container(
                                      child: Container(
                                      child: Text(
                                        'X',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              SizedBox(
                                width: 25.0,
                              )
                            ],
                          ),
                        ]),
                    if (widget.statusShort == 'NS' || widget.statusShort == 'TBD') SizedBox(
                            width: 520.0,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                color: Color.fromRGBO(222, 177, 92, 1),
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                      color: Color.fromRGBO(13, 18, 38, 1)),
                                ),
                                onPressed: () async {
                                  
                                }),
                          ) else widget.statusShort == 'PST'  ?
                        Container(
                            child: Text(
                            'Match Postponed',
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold),
                          )):
                        Container(
                            child: Text(
                            'Prediction time is over',
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold),
                          ))
                  ],
                ),
              ),
            ),
          );
        });
  }
  }
}