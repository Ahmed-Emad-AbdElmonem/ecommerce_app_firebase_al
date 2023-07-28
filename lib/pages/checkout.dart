import 'package:e_commerce_app/provider/cart.dart';
import 'package:e_commerce_app/shared/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CheckOut extends StatelessWidget {
  const CheckOut({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carttt= Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("check out page"),
      actions: [
        productAndPrice()
      ],
      ),

      body: 
      Column(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: 550,
              child: ListView.builder(
                itemCount:carttt.selectedProduts.length ,
                itemBuilder: (BuildContext context , int index){
                  return Card(
                    child: ListTile(
                      title:Text(carttt.selectedProduts[index].name) ,
                      subtitle:Text("${carttt.selectedProduts[index].price}" /*- ${carttt.selectedProduts[index].location}*/) ,
                      leading:CircleAvatar(backgroundImage: AssetImage(carttt.selectedProduts[index].imgPath),) ,
                      
                      trailing:IconButton(onPressed: (){
                        carttt.remove(carttt.selectedProduts[index]);
                      }, icon: Icon(Icons.remove)) ,
          
                    ),
                  );
                },
                
          
                ),
            ),
          ),
        ElevatedButton(onPressed: (){

        }, child: Text("pay \$${carttt.price}",style: TextStyle(fontSize: 20,),),
        ),
        
        ],
      ),
      
      
    );
  }
}