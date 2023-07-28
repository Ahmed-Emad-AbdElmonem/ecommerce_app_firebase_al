import 'package:e_commerce_app/pages/checkout.dart';
import 'package:e_commerce_app/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class productAndPrice extends StatelessWidget {
  const productAndPrice({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carttt= Provider.of<Cart>(context);
    return Row(
                children: [
                  Stack(children: [
                    Positioned(
                      bottom: 24,
                      //  right: 28,
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(2),
                          child: Text(
                            "${carttt.selectedProduts.length}",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          )),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            CheckOut(),
                            ),
                            );
                    
                        }, icon: Icon(Icons.add_shopping_cart)),
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Text(
                      '\$ ${carttt.price}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              );
  }
}