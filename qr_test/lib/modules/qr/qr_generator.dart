import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ignore: camel_case_types
class qrGenerator extends StatefulWidget {
  const qrGenerator({Key? key}) : super(key: key);

  @override
  State<qrGenerator> createState() => _qrGeneratorState();
}

// ignore: camel_case_types
class _qrGeneratorState extends State<qrGenerator> {
  final controller = TextEditingController();

  Widget _buildTextField(BuildContext context) => TextField(
        controller: controller,
        style: const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.normal,
          fontSize: 25,
        ),
        decoration: InputDecoration(
          hintText: "Enter Data",
          hintStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.blueGrey),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary)),
          suffixIcon: IconButton(
            color: Theme.of(context).colorScheme.primary,
            icon: const Icon(Icons.done, size: 30),
            onPressed: () => setState(() {}),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("QR Generator"),
        backgroundColor: const Color(0xFF72CC50),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImage(
                data: controller.text,
                size: 250,
                backgroundColor: Colors.grey.withOpacity(0.5),
              ),
              const SizedBox(
                height: 40,
              ),
              _buildTextField(context),
            ],
          ),
        ),
      ),
    );
  }
}
