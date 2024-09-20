// lib/screens/update_product.dart
import 'package:flutter/material.dart';
import 'package:api_testing/fetch%20data%20from%20internet.dart';
import 'package:api_testing/styles.dart';

class UpdateProduct extends StatefulWidget {
  final String id;
  final String productName;
  final String productCode;
  final String unitPrice;
  final String qty;
  final String totalPrice;

  const UpdateProduct({
    required this.id,
    required this.productName,
    required this.productCode,
    required this.unitPrice,
    required this.qty,
    required this.totalPrice,
  });

  @override
  _UpdateProductState createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _totalPriceController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.productName;
    _codeController.text = widget.productCode;
    _priceController.text = widget.unitPrice;
    _qtyController.text = widget.qty;
    _totalPriceController.text = widget.totalPrice;
  }

  submitData() async {
    bool success = await fetchData().updateProduct(
      id: widget.id,
      productName: _nameController.text,
      productCode: _codeController.text,
      unitPrice: _priceController.text,
      qty: _qtyController.text,
      totalPrice: _totalPriceController.text,
    );
    setState(() {
      isLoading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product updated successfully')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update product')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Update Product', style: newText(Colors.white, 20)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: newDecoration(BorderRadius.circular(0)),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20,left: 20,top: 20),
                child: TextFormField(
                  controller: _nameController,
                  decoration: newInputDecoration('Product name', 'Enter product name'),
                  validator: (value) => value!.isEmpty ? 'Please write something' : null,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 20,left: 20,top: 20),
                child: TextFormField(
                  controller: _codeController,
                  decoration: newInputDecoration('Product code', 'Enter product code'),
                  validator: (value) => value!.isEmpty ? 'Please write something' : null,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 20,left: 20,top: 20),
                child: TextFormField(
                  controller: _priceController,
                  decoration: newInputDecoration('Product price', 'Enter product price'),
                  validator: (value) => value!.isEmpty ? 'Please write something' : null,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 20,left: 20,top: 20),
                child: TextFormField(
                  controller: _qtyController,
                  decoration: newInputDecoration('Quantity', 'Enter quantity'),
                  validator: (value) => value!.isEmpty ? 'Please write something' : null,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 20,left: 20,top: 20),
                child: TextFormField(
                  controller: _totalPriceController,
                  decoration: newInputDecoration('Total price', 'Enter total price'),
                  validator: (value) => value!.isEmpty ? 'Please write something' : null,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 20,left: 20,top: 20),
                child: InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      submitData();
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: Center(
                      child: isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Update Product', style: newText(Colors.white, 18)),
                    ),
                    decoration: newDecoration(BorderRadius.circular(3)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
