import 'package:flutter/material.dart';
import 'package:pec_mobile/widgets/left_drawer.dart';

class AddProductFormPage extends StatefulWidget {
  const AddProductFormPage({super.key});

  @override
  State<AddProductFormPage> createState() => _AddProductFormPageState();
}

class _AddProductFormPageState extends State<AddProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _amount = 0;
	String _description = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: const Center(
                child: Text(
                  'Form Tambah Product Anda',
                ),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
            drawer: LeftDrawer(),
            body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "Name Product ...",
                                        labelText: "Name",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                    ),
                                    onChanged: (String? value) {
                                      setState(() {
                                        _name = value!;
                                      });
                                    },
                                    validator: (String? value) {
                                      if (value == null || value.trim().isEmpty) {
                                        return "Nama product tidak boleh kosong! ( termasuk spasi saja )";
                                      }
                                      return null;
                                    },
                                  ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Description Product ...",
                                    labelText: "Description",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  onChanged: (String? value) {
                                    setState(() {
                                      _description = value!;
                                    });
                                  },
                                  validator: (String? value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Wajib mengisi deskripsi product! ( termasuk spasi saja )";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Amount ...",
                                    labelText: "Amount",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  onChanged: (String? value) {
                                    setState(() {
                                      _amount = int.tryParse(value!) ?? 0;
                                    });
                                  },
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Amount tidak boleh kosong!";
                                    }
                                    final intValue = int.tryParse(value);
                                    if (intValue == null) {
                                      return "Amount harus berupa angka!";
                                    }
                                    if (intValue < 0) {
                                      return "Amount tidak boleh negatif";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
                                          Theme.of(context).colorScheme.primary),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text('Product berhasil ditambahkan'),
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Name: $_name'),
                                                    Text('Description: $_description'),
                                                    Text('Amount: $_amount'),
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: const Text('OK'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    _formKey.currentState!.reset();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                    child: const Text(
                                      "Add Product",
                                      style: TextStyle(color: Colors.white),
                                    ),
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