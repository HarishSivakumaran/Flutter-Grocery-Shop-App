// import 'package:flutter/material.dart';

// import './add_product.dart';

// import './Products.dart';

// class ProductsManager extends StatelessWidget{

//   final List <Map<String,dynamic>> productsList;
//   final Function deleteProduct;
//   final Function addProduct;
//   ProductsManager(this.deleteProduct,this.productsList,this.addProduct);

//   Widget renderList(){
    
//     return productsList.length>0 ? Expanded(child:Products(productsList: productsList,deleteProduct: deleteProduct,)) : Center(child: Text("Empty list"),);
//   }


//   @override
//   Widget build(BuildContext context) {

//     return Column(
//       children: <Widget>[
//         renderList(),
//       ],
//     );
//   }
// }