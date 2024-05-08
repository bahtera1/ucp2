import 'package:flutter/material.dart';
import 'package:ucp2/domain/model/kuliner_model.dart';
import 'package:ucp2/presentation/controller/kuliner_controller.dart';

class PertamaScreen extends StatefulWidget {
  const PertamaScreen({super.key});

  @override
  State<PertamaScreen> createState() => _PertamaScreenState();
}

class _PertamaScreenState extends State<PertamaScreen> {
  final KulinerController _controller = KulinerController();

  @override
  void initState() {
    super.initState();
    _controller.getKuliner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Kuliner'),
      ),
      body: FutureBuilder<List<Kuliner>>(
        future: _controller.getKuliner(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Kuliner kuliner = snapshot.data![index];
                return ListTile(
                  title: Text(kuliner.namakuliner),
                  subtitle: Text(kuliner.notelepon),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(kuliner.gambar),
                  ),
                );
              },
            );
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => const FormKontak()),
      //     );
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
