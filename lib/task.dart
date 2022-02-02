

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: Text(
        'Task',
        style: TextStyle(
          fontSize: 40.0,
        ),
      ),
    ));
  }
}
