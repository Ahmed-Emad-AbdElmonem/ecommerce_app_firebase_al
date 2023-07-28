import 'package:e_commerce_app/model/item.dart';
import 'package:e_commerce_app/pages/datails_page.dart';
import 'package:e_commerce_app/provider/cart.dart';
import 'package:e_commerce_app/shared/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  // لمعرفة بيانات اليوزر لما يسجل بجوجل
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 33,
              ),
              itemCount: itemsList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return Details(product: itemsList[index]);
                      }),
                    );
                  },
                  child: GridTile(
                    child: Stack(children: [
                     Positioned(
                        top: -3,
                        bottom: -9,
                        left: 0,
                        right: 0,
                        child: Image.asset(itemsList[index].imgPath),
                      ),
                    ]),
                    footer: GridTileBar(
                      backgroundColor: Color.fromARGB(66, 21, 255, 0),
                      trailing:
                          Consumer<Cart>(builder: (context, carttt, child) {
                        return IconButton(
                            onPressed: () {
                              carttt.add(itemsList[index]);
                            },
                            icon: Icon(Icons.add));
                      }),
                      leading: Text("\$12.99"),
                      title: Text("                    product"),
                    ),
                  ),
                );
              }),
        ),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image:NetworkImage(user.photoURL!),
                  fit: BoxFit.cover,
                )),
                currentAccountPicture: CircleAvatar(
                  radius: 55,
                  backgroundImage: NetworkImage(user.photoURL!),
                ),
                accountEmail: Text(
                  user.email!,
                  style: TextStyle(color: Colors.green),
                ),
                accountName: Text(
                  user.displayName!,
                  style: TextStyle(color: Colors.green),
                ),
              ),
              Column(
                children: [
                  ListTile(
                    title: Text("Home"),
                    leading: Icon(Icons.home),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("My products"),
                    leading: Icon(Icons.add_shopping_cart),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("About"),
                    leading: Icon(Icons.help_center),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Logout"),
                    leading: Icon(Icons.exit_to_app),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                    },
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 12),
                child: Text(
                  "Developed by Ahmed Emad 2022",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          actions: [
            Consumer<Cart>(builder: (context, carttt, child) {
              return productAndPrice();
            }),
          ],
          backgroundColor: Colors.green[400],
          title: Text("Home"),
        ),
      ),
    );
  }
}
