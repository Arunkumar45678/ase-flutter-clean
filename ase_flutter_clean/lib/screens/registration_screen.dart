import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/user_model.dart';

class RegistrationScreen extends StatefulWidget {
  final String email; // from Firebase login

  const RegistrationScreen({super.key, required this.email});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  String gender = "Male";
  String district = "";
  String mandal = "";
  String village = "";

  bool accepted = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Complete Registration")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              // EMAIL (READ ONLY)
              TextFormField(
                initialValue: widget.email,
                readOnly: true,
                decoration: const InputDecoration(labelText: "Email"),
              ),

              TextFormField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: "Full Name"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),

              TextFormField(
                controller: phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: "Phone Number"),
                validator: (v) => v!.length < 10 ? "Invalid phone" : null,
              ),

              DropdownButtonFormField(
                value: gender,
                items: const [
                  DropdownMenuItem(value: "Male", child: Text("Male")),
                  DropdownMenuItem(value: "Female", child: Text("Female")),
                ],
                onChanged: (v) => gender = v!,
                decoration: const InputDecoration(labelText: "Gender"),
              ),

              TextFormField(
                decoration: const InputDecoration(labelText: "District"),
                onChanged: (v) => district = v,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Mandal"),
                onChanged: (v) => mandal = v,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Village"),
                onChanged: (v) => village = v,
              ),

              CheckboxListTile(
                value: accepted,
                onChanged: (v) => setState(() => accepted = v!),
                title: const Text("Accept Terms & Conditions"),
              ),

              ElevatedButton(
                onPressed: loading ? null : submit,
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submit() async {
    if (!_formKey.currentState!.validate() || !accepted) return;

    setState(() => loading = true);

    final user = UserModel(
      email: widget.email,
      name: nameCtrl.text,
      phone: phoneCtrl.text,
      gender: gender,
      district: district,
      mandal: mandal,
      village: village,
    );

    final success = await ApiService.registerUser(user);

    setState(() => loading = false);

    if (success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Registered Successfully")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Registration Failed")));
    }
  }
}
