import './widgets/chart.dart';

import './widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import './widgets/user_transacttions.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses manager',
      theme: ThemeData(
        primarySwatch:Colors.purple,
        // errorColor: Colors.red,
        accentColor: Colors.amber,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String titleInput;

   final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: "t1",
    //   amount: 500,
    //   date: DateTime.now(),
    //   title: "shoes",
    // ),
    // Transaction(
    //   id: "t2",
    //   amount: 5000,
    //   date: DateTime.now(),
    //   title: "shirt",
    // ),
  ];
  List<Transaction> get _recentTransactions{
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),));
    }).toList();
  }

   void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      amount: txAmount,
      date: chosenDate,
      title: txTitle,
      id: DateTime.now().toString()
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }
  //this is the function which will pop up the textfield(user input place ) when the add button is clicked
  void _startAddNewTransaction(BuildContext ctx)
  {
    showModalBottomSheet(context: ctx, builder: (bctx){
      return NewTransaction(_addNewTransaction);
    });
  }

  void _deleteTransaction(String id)
  {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id==id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses planner"),
        actions: [
          IconButton(
            onPressed: () {
              _startAddNewTransaction(context);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      drawer: Drawer(
        child: DrawerHeader(child: Text("sovaa")),
      ),
      body: SingleChildScrollView(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Chart(_recentTransactions),

              TransactionList(_userTransactions,_deleteTransaction),
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(child:Icon(Icons.add) , onPressed: (){
        _startAddNewTransaction(context);
      },),
    );
  }
}
