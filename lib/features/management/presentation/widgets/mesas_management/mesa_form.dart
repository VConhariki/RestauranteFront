import 'package:flutter/material.dart';
import 'package:flutter_application_teste/shared/domain/enums/status_mesa_enum.dart';
import 'package:flutter_application_teste/shared/domain/models/mesa.dart';
import 'package:flutter_application_teste/shared/domain/services/mesa_repository.dart';

class MesaForm extends StatefulWidget {
  const MesaForm({super.key, required this.mesa});

  final Mesa? mesa;

  @override
  State<MesaForm> createState() => _MesaFormState();
}

class _MesaFormState extends State<MesaForm> {
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _mesaRepository = MesaRepository();

  late int? id = widget.mesa?.id;
  late int numero;
  late StatusMesaEnum status = StatusMesaEnum.disponivel;

  _sendForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.mesa != null
          ? await _mesaRepository.put(
              Mesa(
                id: id!,
                numero: numero,
                status: status,
              ),
            )
          : await _mesaRepository.post(
              Mesa(
                numero: numero,
                status: status,
              ),
            );
      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.mesa != null ? "Editar mesa" : 'Inserir nova mesa',
        ),
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.mesa?.numero.toString(),
                decoration:
                    const InputDecoration(label: Text('Número da mesa')),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo inválido';
                  }
                  return null;
                },
                onSaved: (value) {
                  numero = int.parse(value!);
                  return;
                },
              ),
              DropdownButtonFormField<StatusMesaEnum>(
                decoration: const InputDecoration(label: Text('Status')),
                isExpanded: true,
                value: status,
                icon: const Icon(Icons.arrow_downward),
                elevation: 0,
                onChanged: (StatusMesaEnum? value) {
                  setState(() {
                    status = value!;
                  });
                },
                items:
                    StatusMesaEnum.values.map<DropdownMenuItem<StatusMesaEnum>>(
                  (StatusMesaEnum value) {
                    return DropdownMenuItem<StatusMesaEnum>(
                      value: value,
                      child: Text(value.description),
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: const CircleBorder(),
        onPressed: _sendForm,
        child: const Icon(Icons.check),
      ),
    );
  }
}
