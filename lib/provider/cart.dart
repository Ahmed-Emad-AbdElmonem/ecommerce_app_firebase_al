import 'package:e_commerce_app/model/item.dart';
import 'package:flutter/material.dart';


class Cart with ChangeNotifier {

  List selectedProduts =[


  ];
  int price=0;

  add(Item product){
    selectedProduts.add(product);
    price +=product.price.ceil();
    notifyListeners();
  }

  remove(Item product){
    selectedProduts.remove(product);
    price -=product.price.ceil();
    notifyListeners();
  }
  
}