import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_book/models/phone_book_model.dart';
import 'package:phone_book/screens/home/bloc/home_bloc.dart';

class DialogDeleteItem extends StatefulWidget {
  final PhoneBookModel data;
  const DialogDeleteItem(this.data, {Key? key,
    }) : super(key: key);

  @override
  _DialogDeleteItemState createState() => _DialogDeleteItemState();
}

class _DialogDeleteItemState extends State<DialogDeleteItem> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {


    controller = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 300));
    scaleAnimation = Tween(
        begin: 0.0,
        end: 1.0
    ).animate(controller);
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc= context.watch<HomeBloc>();

    return Center(
      child: Material(
        color: Colors.transparent,

        child: ScaleTransition(
            scale:  scaleAnimation,
            child: Container(
              height: 190,
              width: 270,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [
                  const Padding(
                    padding: EdgeInsets.only(top: 25.0,
                    bottom: 15),
                    child: Text('Are you sure you want to delete?'
                    ,style: TextStyle(
                        fontSize: 16,

                      ),),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.black45,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 0),
                    height: 40,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () async{
                        bloc.add(DeleteDataEvent(widget.data.id!));
                        Navigator.pop(context);
                      },
                      child: const Text(
                          'Delete',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 0.3,
                    color: Colors.black45,
                  ),
                  SizedBox(
                    height: 35,
                    width: double.infinity,
                    child: TextButton(

                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                          'Cancel',
                        style: TextStyle(
                          color: Colors.black
                        ),

                      ),
                    ),
                  ),
                ],
              ),


            )
        ),
      ),

    );
  }
  @override
  void dispose() {

    controller.dispose();
    super.dispose();
  }


}
