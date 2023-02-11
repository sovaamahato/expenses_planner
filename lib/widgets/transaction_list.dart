import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  // const transaction_list({Key key}) : super(key: key);
  final List<Transaction> _transactions;
  Function deleteTx;

  TransactionList(this._transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: _transactions.isEmpty
          ? Column(
              children: [
                Text(
                  "No transactions yet",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Container(
                    height: 250,
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.cover,
                    )),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 6,horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 35,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FittedBox(
                            child: Text('Rs.${_transactions[index].amount}'),
                            ),
                      ),
                    ),
                    title: Text(_transactions[index].title,),
                    subtitle: Text(DateFormat.yMMMd().format(_transactions[index].date)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: ()=>deleteTx(_transactions[index].id),
                    ),
                  ),
                );
              
              },
              itemCount: _transactions.length,
            ),
    );
  }
}
