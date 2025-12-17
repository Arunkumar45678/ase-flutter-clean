import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import 'home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  final String email;
  const RegistrationScreen({super.key, required this.email});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  String name = "";
  String phone = "";
  String gender = "Male";
  String district = "";
  String mandal = "";
  String village = "";
  bool agreed = false;
  bool loading = false;

  Future<void> submit() async {
    if (!_formKey.currentState!.validate() || !agreed) return;

    setState(() => loading = true);

    UserModel user = UserModel(
      email: widget.email,
      name: name,
      phone: phone,
      gender: gender,
      district: district,
      mandal: mandal,
      village: village,
    );

    bool success = await ApiService.registerUser(user);

    setState(() => loading = false);

    if (success && context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen(name: name)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registration")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: widget.email,
                readOnly: true,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Name"),
                onChanged: (v) => name = v,
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Phone"),
                keyboardType: TextInputType.phone,
                onChanged: (v) => phone = v,
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
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Mandal"),
                onChanged: (v) => mandal = v,
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Village"),
                onChanged: (v) => village = v,
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              CheckboxListTile(
                value: agreed,
                onChanged: (v) => setState(() => agreed = v!),
                title: const Text("I accept Terms & Conditions"),
              ),
              const SizedBox(height: 10),
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
}
