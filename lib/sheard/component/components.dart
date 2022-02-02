

typedef String fun(s);
Widget TaskForm({
  required TextEditingController controller,
  required TextInputType type,
  required String lable,
  required IconData prefix,

}
) {
  return TextFormField(
     controller:  controller ,
     keyboardType: type,
     validator:(s){
       if(s!.isEmpty)
         {
           return error;}},
     validator:(s){
       validation(s);
     },
      onChanged:onChange!(),
       onTap:onTap!() ,
        decoration:InputDecoration(
          label: Text(lable),
          prefixIcon:Icon(prefix),
        ),
    onFieldSubmitted: (s){
       onSubmit!(s);
    // },



  );
}