import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/expense.dart';
import '../services/firestore_service.dart';
import '../widgets/app_drawer.dart';
import '../widgets/expenseslist.dart';
import 'add_expense_screen.dart';

class ExpenseListScreen extends StatelessWidget {
  static String routeName = '/expense-list';

  @override
  Widget build(BuildContext context) {
    FirestoreService fsService = FirestoreService();

    return StreamBuilder<List<Expense>>(
      stream: fsService.getExpenses(),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting ?
        Center(child: CircularProgressIndicator()) :
        Scaffold(
          appBar: AppBar(
            title: Text('My Expenses'),
          ),
          body: Container(
              alignment: Alignment.center,
              child: snapshot.data!.isNotEmpty ? ExpensesList() :
              Column(
                children: [
                  SizedBox(height: 20),
                  Image.asset('images/empty.png', width: 300),
                  Text('No expenses yet, add a new one today!', style:
                  Theme.of(context).textTheme.subtitle1),
                ],
              )
          ),
          drawer: AppDrawer(),

          floatingActionButton: FloatingActionButton(
              onPressed: ()
              {Navigator.of(context).pushNamed(AddExpenseScreen.routeName); },
              child: Icon(Icons.add)
          ),
        );
      }
    );
  }
}