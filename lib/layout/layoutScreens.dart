
import 'package:todoapp/archived.dart';
import 'package:todoapp/done.dart';
import 'package:todoapp/sheard/component/components.dart';
import 'package:todoapp/sheard/cubit/cubit.dart';
import 'package:todoapp/sheard/cubit/states.dart';
import 'package:todoapp/task.dart';

class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);
   Database? database;
  var scaffoldkey = GlobalKey<ScaffoldState>();
  bool isbuttom = false;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit(),
      child: BlocConsumer<AppCubit ,States>(
        listener:(BuildContext context,state) {
          print('loading');
        },
        builder: (BuildContext context,state)=>Scaffold(
          key: scaffoldkey,
          appBar: AppBar(
            title: Text('Todo'),
          ),
          // body: screens[Index],
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (isbuttom) {
                if (formKey.currentState!.validate()){
                  insertdatabase(
                    title:titleController.text,
                    date:dateController.text,
                    time:timeController.text,
                  ).then((value){

                    Navigator.pop(context);
                    isbuttom = false;
                    print('xxxxx');});}
              }else
              {
                print('ZZZZZ');
                scaffoldkey.currentState!.showBottomSheet((context) => Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.teal[100],
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TaskForm(
                          type: TextInputType.text,
                          prefix: Icons.title,
                          //error: 'title musty be not empty',
                          controller: titleController,
                          lable: 'Title',
                          //validation: ((e)=>'e'),
                        ),
                        TaskForm(
                          type: TextInputType.text,
                          prefix: Icons.watch_later_outlined,
                          //error: 'time musty be not empty',
                          controller: timeController,
                          lable: 'Time',
                          //validation: ((e)=>'e'),
                        ),
                        TaskForm(
                          type: TextInputType.text,
                          prefix: Icons.date_range,
                          //error: 'date musty be not empty',
                          controller: dateController,
                          lable: 'Date',
                          //validation: ((e)=>'e'),
                        ),
                      ],
                    ),
                  ),
                ));
                isbuttom = true;
              }
              // print('add');

            },
            child: (Icon(Icons.add)),
          ),
          bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Task'),
                BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: 'Archived'),
              ],
              currentIndex: AppCubit.get(context).Index,
              onTap: (index) {
                AppCubit.get(context).ChengeIndex(index);
                // setState(() {
                //   Index = index;
                // });
              }),
        ),
      ),
    );
  }

  void creatDatabase(database) async {
    database = openDatabase('todoapp.db', version: 1,
        onCreate: (database, version) async {
      print('database created');
      await database.execute(
          'CREATE TABLE task (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT ,status TEXT )');
    }, onOpen: (database) {
      print('database opened');
      getDatabase(database);
      //insertdatabase(database);
      print('get database');
    }).then(
      (value) {
        database = value;
        print("table created ");
      },
    ).catchError((error) {
      print(error.toString());
    });
  }

  Future insertdatabase({
  required String title,
    required String time,
    required String date,
}) async {
    await database!.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO task(title ,date, time ,status) VALUES("title", "23-1-2022", "10.0"," task")');
    }).then((value) {
      print("$value insert success ");
    }).catchError((error) {
      print(error.toString());
    });
  }

  List<Map> tasks = [];

  void getDatabase(database) {
    database.rawQuery('SELECT * FROM task').then((value) {
      tasks = value;
      print(tasks.toString());
    });
  }
}
