import 'package:api_testing/fetch%20data%20from%20internet.dart';
import 'package:api_testing/styles.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _totalPriceController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool isLoading = false;

  void clearData(){
    _nameController.clear();
    _codeController.clear();
    _priceController.clear();
    _qtyController.clear();
    _totalPriceController.clear();
  }

  submitData() async {
    bool success = await fetchData().createProduct(
      productName: _nameController.text,
      productCode: _codeController.text,
      unitPrice: _priceController.text,
      qty: _qtyController.text,
      totalPrice: _totalPriceController.text,
    );
    setState(() {
      isLoading = false;
    });

    if (success){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product added successfully, Please refesh the page to view the result')),
      );
      clearData();
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add product')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Add new product', style: newText(Colors.white, 20)),
        centerTitle: true,
        toolbarHeight: 65,
        flexibleSpace: Container(
          decoration: newDecoration(BorderRadius.circular(0)),
        ),
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextFormField(
                  cursorColor: Colors.blue,
                  controller: _nameController,
                  decoration: newInputDecoration('Product name', 'Enter a new product name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please write something';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextFormField(
                  cursorColor: Colors.blue,
                  controller: _codeController,
                  decoration: newInputDecoration('Product code', 'Enter a new product code'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please write something';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextFormField(
                  cursorColor: Colors.blue,
                  controller: _priceController,
                  decoration: newInputDecoration('Product price', 'Enter a new product price'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please write something';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextFormField(
                  cursorColor: Colors.blue,
                  controller: _qtyController,
                  decoration: newInputDecoration('Product quantity', 'Enter product quantity'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please write something';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextFormField(
                  cursorColor: Colors.blue,
                  controller: _totalPriceController,
                  decoration: newInputDecoration('Product total price', 'Enter product total price'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please write something';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: InkWell(
                  onTap: () {
                    if (_key.currentState!.validate()) {
                      submitData();
                      setState(() {
                        isLoading = true;
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: Center(
                        child: isLoading?CircularProgressIndicator(color: Colors.white,)
                            :Text('Add product', style: newText(Colors.white, 18))),
                    decoration: newDecoration(BorderRadius.circular(3)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
