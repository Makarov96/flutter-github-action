import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: BlocProvider(
        create: (context) => CounterBloc(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Material App Bar'),
          ),
          body: const BodySample(),
        ),
      ),
    );
  }
}

class BodySample extends StatelessWidget {
  const BodySample({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SingleDynamicForm(
            aibTextForm: [
              DynamicTextForm(
                config: ConfigForm(
                  validators: [
                    Validators.text,
                  ],
                ),
              ),
              DynamicTextForm(
                config: ConfigForm(validators: [
                  Validators.cellphone,
                ], keyboardType: TextInputType.phone),
              ),
              DynamicTextForm(
                config: ConfigForm(
                  validators: [
                    Validators.none,
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class SingleDynamicForm extends StatefulWidget {
  const SingleDynamicForm({
    Key? key,
    required this.aibTextForm,
  }) : super(key: key);
  final List<DynamicTextForm> aibTextForm;

  @override
  State<SingleDynamicForm> createState() => _SingleDynamicFormState();
}

class _SingleDynamicFormState extends State<SingleDynamicForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final appBarSize =Scaffold.of(context).appBarMaxHeight??0.0;
    return Stack(

      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            height: (_size.height-appBarSize),
            width: _size.width,
            decoration: const BoxDecoration(
              color: Colors.transparent
            ),
          ),
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              ListView.builder(
                itemCount: widget.aibTextForm.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return TextFormField(
                    controller: widget.aibTextForm[index].controller,
                    onSaved: (value) {},
                    validator: widget.aibTextForm[index].validator,
                    keyboardType: widget.aibTextForm[index].config.keyboardType,
                  );
                },
              ),
              TextButton(
                onPressed: () {
                  print(_formKey.currentState!.validate());
                },
                child: const Text('Presiona'),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class DynamicTextForm {
  DynamicTextForm({
    required this.config,
  }) {
    controller = TextEditingController();
  }

  late final TextEditingController controller;
  final ConfigForm config;

  final _regeNumberPhone = RegExp(r"^[a-zA-Z0-9]+$");

  String? validator(String? value) {
    value ??= '';
    for (var restraint in config.validators) {
      switch (restraint) {
        case Validators.text:
          if (value.isEmpty) {
            return 'Necesita mas detalles';
          } else {
            return null;
          }
        case Validators.numeric:
          return null;
        case Validators.phone:
          return null;
        case Validators.cellphone:
          if (value.isEmpty) {
            return 'Necesita ingresar un numero de telefono';
          }
          if (_regeNumberPhone.hasMatch(value)) {
            return 'Debe de ingresar un numero de telefono valido';
          }
          return null;

        case Validators.custom:
          return null;

        case Validators.none:
          return null;
      }
    }
    return null;
  }
}

class ConfigForm {
  ConfigForm({
    required this.validators,
    this.textFieldType = TextFieldType.text,
    this.keyboardType,
  });
  final List<Validators> validators;
  final TextFieldType textFieldType;
  final TextInputType? keyboardType;
}

enum Validators {
  text,
  numeric,
  phone,
  cellphone,
  custom,
  none,
}

enum TextFieldType {
  text,
  numeric,
  phone,
  cellphone,
}

abstract class CounterEvent {}

class Increment extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<Increment>(
      (event, emit) async {
        await Future.delayed(const Duration(seconds: 1));
        emit(state + 1);
      },
      transformer: droppable(),
    );
  }
}
/**
 * 
 * 
 *    BlocSelector<CounterBloc, int, int>(
            selector: (state) {
              return state;
            },
            builder: (context, state) {
              return Text('$state');
            },
          ),
          TextButton(
            onPressed: () => context.read<CounterBloc>().add(Increment()),
            child: const Text('press'),
          ),
 */


/**
 * 
 

class MultiPageDynamicForm extends StatefulWidget {
  const MultiPageDynamicForm({Key? key}) : super(key: key);

  @override
  State<MultiPageDynamicForm> createState() => _MultiPageDynamicFormState();
}

class _MultiPageDynamicFormState extends State<MultiPageDynamicForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: PageView.builder(
        itemCount: ,
        itemBuilder: (context, index) {
          return Container();
        },
      ),
    );
  }
}

 */