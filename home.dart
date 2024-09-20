
import 'package:api_testing/Model/json_model.dart';
import 'package:api_testing/addProduct.dart';
import 'package:api_testing/fetch%20data%20from%20internet.dart';
import 'package:api_testing/styles.dart';
import 'package:api_testing/updateProduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  List<Datum>? items;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    items = await fetchData().getProducts();
    setState(() {

    });
  }

  Future refreshData()async{
    setState(() {
      isLoading = false;
    });
    items = await fetchData().getProducts();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark
        ),
        title: Text(
          'CRUD Operation', style: newText(Colors.white,20),),
        centerTitle: true,
        toolbarHeight: 65,
        flexibleSpace: Container(
          decoration: newDecoration(BorderRadius.circular(0)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct()));
                },
                icon: Icon(Icons.add,color: Colors.white,)
            )
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 8,),
          Expanded(
            child: items==null? Center(child: CircularProgressIndicator(backgroundColor: Colors.white,color: Colors.blue,))
            :RefreshIndicator(
              backgroundColor: Colors.white,
              color: Colors.blue,
              onRefresh: refreshData,

              child: ListView.builder(
                itemCount: items!.length,
                  itemBuilder: (context,index){
                  var product = items![index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15,right: 15,left: 15,bottom: 15),
                          child: Container(
                            //color: Colors.red,
                            decoration: newDecoration(BorderRadius.circular(8)),
                            width: double.infinity,
                            height: 240,
                            child: Row(
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20,top: 25),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Product name : ${product.productName}',style: newText(Colors.white, 18),),
                                        Text('Product code :${product.productCode}',style: newText(Colors.white, 18),),
                                        Text('Unit price: ${product.unitPrice}', style: newText(Colors.white, 18.0)),
                                        Text('Quantity: ${product.qty}', style: newText(Colors.white, 18.0)),
                                        Text('Total price: ${product.totalPrice}', style: newText(Colors.white, 18.0)),
                                        Text('Created date :${product.createdDate}',style: newText(Colors.white, 18),),
                                      ],
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(bottom: 140),
                                  child: PopupMenuButton(
                                    color: Colors.white,
                                    iconColor: Colors.white,
                                      itemBuilder: (context){
                                        return [
                                          PopupMenuItem(
                                            onTap: () {
                                              Future.delayed(
                                                Duration.zero,
                                                    () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => UpdateProduct(
                                                      id: product.id,
                                                      productName: product.productName,
                                                      productCode: product.productCode,
                                                      unitPrice: product.unitPrice.toString(),
                                                      qty: product.qty.toString(),
                                                      totalPrice: product.totalPrice.toString(),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text('Edit', style: newText(Colors.black, 16)),
                                          ),

                                          PopupMenuItem(
                                             onTap: ()async{
                                              bool success = await fetchData().deleteProduct(product.id);
                                              if(success){
                                                setState(() {
                                                  items!.removeAt(index);
                                                });
                                              }
                                            },
                                              child: Text('Delete',style :newText(Colors.black, 16)
                                              )
                                          ),
                                        ];
                                      }
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                      ],
                    );
                  }
              ),
            ),
          )
        ],
      ),
    );
  }
}




