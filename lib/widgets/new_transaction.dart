import 'package:flutter/material.dart';
import '../widgets/user_transacttions.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  // const NewTransaction({Key key}) : super(key: key);
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0|| _selectedDate==null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(
      context: context, 
    initialDate: DateTime.now(), 
    firstDate: DateTime(2022), 
    lastDate: DateTime.now()
    ).then((pickedDate)
    {
      if(pickedDate==null)
      return;
      setState(() {
        _selectedDate=pickedDate;
      });
      
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(label: Text("title")),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(label: Text("amount")),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val){
              //   amountInput=val;
              // },
            ),
            Row(
              children: [
                Expanded(child: Text(_selectedDate==null?'No date choosen':'picked date:${DateFormat.yMd().format(_selectedDate)}')),
                // FlatButton(
                //   onPressed:_presentDatePicker,
                //   textColor: Theme.of(context).primaryColorDark,
                //   child: Text('choose date'),
                  
                  
                // )
              ],
            ),
            // RaisedButton(
            //   onPressed: _submitData,
            //   // addTx(
            //   //   titleController.text,
            //   //   double.parse(amountController.text)
            //   // );
            //   // print("pressed");
            //   textColor: Colors.white,
            //   color: Theme.of(context).primaryColorDark,
            //   child: Text(
            //     "Add Transaction",
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
