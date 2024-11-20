import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:pec_mobile/screens/menu.dart';
import 'package:pec_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class AddProductFormPage extends StatefulWidget {
  const AddProductFormPage({super.key});

  @override
  State<AddProductFormPage> createState() => _AddProductFormPageState();
}

class _AddProductFormPageState extends State<AddProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _price = 0;
	String _description = "";
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
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
                                    hintText: "Price ...",
                                    labelText: "Price",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  onChanged: (String? value) {
                                    setState(() {
                                      _price = int.tryParse(value!) ?? 0;
                                    });
                                  },
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Price tidak boleh kosong!";
                                    }
                                    final intValue = int.tryParse(value);
                                    if (intValue == null) {
                                      return "Price harus berupa angka!";
                                    }
                                    if (intValue < 0) {
                                      return "Price tidak boleh negatif";
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
                                    onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                            // Kirim ke Django dan tunggu respons
                                            // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                                            final response = await request.postJson(
                                                "http://127.0.0.1:8000/create-flutter/",
                                                jsonEncode(<String, String>{
                                                    'name': _name,
                                                    'price': _price.toString(),
                                                    'description': _description,
                                                }),
                                            );
                                            if (context.mounted) {
                                                if (response['status'] == 'success') {
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(const SnackBar(
                                                    content: Text("Product baru berhasil disimpan!"),
                                                    ));
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => MyHomePage()),
                                                    );
                                                } else {
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(const SnackBar(
                                                        content:
                                                            Text("Terdapat kesalahan, silakan coba lagi."),
                                                    ));
                                                }
                                            }
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