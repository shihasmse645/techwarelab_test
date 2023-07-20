import 'package:flutter/material.dart';
import 'package:techware_test/model/employee_model.dart';
import '../webservice/httpservice.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Employees>? employees;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    //fetch data from api
    getData();
  }

  getData() async {
    employees = await HttpService().getPosts();
    if (employees != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes the position of the shadow
                ),
              ],
            ),
            child: AppBar(
              title: const Text('Employee List'),
              backgroundColor:const Color(0xFF19aabb)
            ),
          ),
        ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Visibility(
          visible: isLoaded,
          replacement:const Center(child: CircularProgressIndicator(),) ,
          child: ListView.builder(
              itemCount: employees?.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children:[
                      CircleAvatar(
                        radius: 30,
                         backgroundImage: NetworkImage(employees![index].profileImage.toString()),
                      ),
                      const SizedBox(width: 15,),
                      Expanded(
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            employees![index].name,
                            style: const TextStyle(
                            fontSize: 20,fontWeight: FontWeight.bold
                          ),),
                          Text(
                            employees![index].email,
                            style: const TextStyle(
                            fontSize: 20,color: Colors.grey
                          ),
                            ),
                            
                        ],
                                        ),
                      ),]
                  ),
                );
              }),
        ),
      ),
    );
  }
}






