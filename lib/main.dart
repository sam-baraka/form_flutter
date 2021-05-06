import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_kendi/form_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FormCubit({}),
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FormBuilder(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormBuilderTextField(
                    name: 'firstname',
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: "First Name"),
                  ),
                  SizedBox(height: 20),
                  FormBuilderTextField(
                    name: 'lastname',
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: "Last Name"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FormBuilderTextField(
                    name: 'email',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.email(context),
                    ]),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: "EMail"),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  CupertinoButton(
                      child: Text("Next"),
                      color: Colors.cyan,
                      onPressed: () {
                        if (_formKey.currentState!.saveAndValidate()) {
                          context
                              .read<FormCubit>()
                              .save(formValue: _formKey.currentState!.value);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (builder) => Page2()));
                        }
                      })
                ],
              ),
            )));
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = context.read<FormCubit>().state;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Review you information"),
          Row(
            children: [Text("Name:"), Text(data['firstname'])],
          ),
          Row(
            children: [Text("Last Name:"), Text(data['lastname'])],
          ),
          Row(
            children: [Text("Email"), Text(data['email'])],
          ),
          SizedBox(
            height: 20,
          ),
          CupertinoButton(
              child: Text("Submit"),
              color: Colors.cyan,
              onPressed: () {
                print(data);
              }),
          SizedBox(
            height: 20,
          ),
          CupertinoButton(
              child: Text("Go Back"),
              color: Colors.cyan,
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
