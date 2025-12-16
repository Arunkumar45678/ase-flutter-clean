import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  final String email;
  const RegistrationScreen({super.key, required this.email});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String phone = '';
  String gender = 'Male';
  bool accepted = false;

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
                decoration: const InputDecoration(labelText: "Name"),
                validator: (v) => v!.isEmpty ? "Required" : null,
                onSaved: (v) => name = v!,
              ),

              TextFormField(
                decoration: const InputDecoration(labelText: "Phone"),
                keyboardType: TextInputType.phone,
                validator: (v) => v!.length < 10 ? "Invalid phone" : null,
                onSaved: (v) => phone = v!,
              ),

              const SizedBox(height: 10),

              DropdownButtonFormField<String>(
                value: gender,
                items: const [
                  DropdownMenuItem(value: "Male", child: Text("Male")),
                  DropdownMenuItem(value: "Female", child: Text("Female")),
                ],
                onChanged: (v) => setState(() => gender = v!),
                decoration: const InputDecoration(labelText: "Gender"),
              ),

              // DISTRICT / MANDAL / VILLAGE
              const SizedBox(height: 10),
              const Text("District / Mandal / Village (next step)"),

              CheckboxListTile(
                value: accepted,
                onChanged: (v) => setState(() => accepted = v!),
                title: const Text("Accept Terms & Conditions"),
              ),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && accepted) {
                    _formKey.currentState!.save();
                    // NEXT: API call
                  }
                },
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
