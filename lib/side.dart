import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child:ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
            child: Center(
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Expanded(
                    child: Icon(Icons.account_circle, color: Colors.white,size: 40,),
                    flex: 2,
                  ),
                  const Expanded(
                    flex: 6,
                    child: Text(
                      "User name",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text("Home"),
            leading: IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            onTap: ()
            {
              Navigator.of(context).pop();
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => MyHomePage()));
            },
          ),
          const Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: const Text("Profile"),
            leading: IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
              },
            ),
            onTap: ()
            {
              Navigator.of(context).pop();
            //   Navigator.of(context).push(MaterialPageRoute(
            //       builder: (BuildContext context) => profile()));
             },
          ),
          const Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: const Text("Contact"),
            leading: IconButton(
              icon: const Icon(Icons.contact_page),
              onPressed: () {
              },
            ),
            onTap: ()
             {
              Navigator.of(context).pop();
              // Navigator.of(context).push(MaterialPageRoute(
              //       builder: (BuildContext context) => null()));
              },
          )
        ],
      ) ,
    );
  }
}
  
