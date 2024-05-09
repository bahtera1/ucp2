import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ucp2/domain/model/kuliner_model.dart';
import 'package:ucp2/presentation/controller/kuliner_controller.dart';
import 'package:ucp2/screen/map_screen.dart';
import 'package:ucp2/screen/pertama_screen.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  File? _image;
  final _imagePicker = ImagePicker();
  String? _alamat;

  final _formKey = GlobalKey<FormState>();
  final _namakulinerController = TextEditingController();
  final _noteleponController = TextEditingController();
  final _alamatController = TextEditingController();
  final _hargaController = TextEditingController();

  final KulinerController _personController = KulinerController();

  Future<void> getImage() async {
    final XFile? pickerFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(
      () {
        if (pickerFile != null) {
          _image = File(pickerFile.path);
        } else {
          print("Tidak Ada Gambar yang dipilih");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Tempat Kuliner "),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 45, 128, 161),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(12),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Nama Tempat Kuliner",
                      hintText: "Masukkan Nama Tempat Kuliner"),
                  controller: _namakulinerController,
                ),
              ),
              Container(
                margin: EdgeInsets.all(12),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: "No Telepon", hintText: "Masukkan No Telepon"),
                  controller: _noteleponController,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Alamat"),
                    _alamat == null
                        ? const SizedBox(
                            width: double.infinity,
                            child: Text('Alamat kosong'))
                        : Text('$_alamat'),
                    _alamat == null
                        ? TextButton(
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MapScreen(
                                      onLocationSelected: (selectedAddress) {
                                    setState(() {
                                      _alamat = selectedAddress;
                                    });
                                  }),
                                ),
                              );
                            },
                            child: const Text('Pilih Alamat'),
                          )
                        : TextButton(
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MapScreen(
                                      onLocationSelected: (selectedAddress) {
                                    setState(() {
                                      _alamat = selectedAddress;
                                    });
                                  }),
                                ),
                              );
                              setState(() {});
                            },
                            child: const Text('Ubah Alamat'),
                          )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(12),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Kisaran Harga",
                      hintText: "Masukkan Kisaran Harga"),
                  controller: _hargaController,
                ),
              ),
              _image == null
                  ? const Text("Tidak ada Gambar yang dipilih")
                  : Image.file(_image!),
              ElevatedButton(
                onPressed: () {
                  getImage();
                },
                child: const Text("Pilih Gambar"),
              ),
              Container(
                margin: const EdgeInsets.all(12),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      //Proses simpan data
                      Kuliner _person = Kuliner(
                          namakuliner: _namakulinerController.text,
                          notelepon: _noteleponController.text,
                          alamat: _alamat ?? '',
                          gambar: _image!.path,
                          harga: _hargaController.text);
                      var result =
                          await _personController.addKuliner(_person, _image);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(result['message']),
                        ),
                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PertamaScreen()),
                        (route) => false,
                      );
                    }
                  },
                  child: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
