
import 'package:todoapp/archived.dart';
import 'package:todoapp/done.dart';
import 'package:todoapp/sheard/cubit/states.dart';

import '../../task.dart';

class AppCubit extends Cubit<States>
{
  AppCubit():super(appInitStates());
  static AppCubit get(context)=>BlocProvider.of(context);


  List<Widget> screens = [
    TaskScreen(),
    DoneScreen(),
    ArchivedScreen(),
  ];
  var Index = 0;


void ChengeIndex(int index){
  Index=index;
  emit(changeIndexNav());

}

}