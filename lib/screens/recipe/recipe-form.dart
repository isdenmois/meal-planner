import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:meal_planner/widgets/image-picker.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uuid/uuid.dart';

import 'recipe.dart';

class RecipeForm extends StatefulWidget {
  final onSave;
  final Recipe initial;

  RecipeForm(this.onSave, {this.initial});

  @override
  _RecipeFormState createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  final headerStyle = TextStyle(fontSize: 20);

  bool _isSaving = false;
  File image;
  String imageURL;

  @override
  void initState() {
    super.initState();
    final initial = widget.initial;

    if (initial == null) return;

    imageURL = initial.imageURL;

    form.reset(value: {
      'title': initial.title,
      'portion': initial.portion.toString(),
      'link': initial.link,
      'steps': initial.steps ?? [],
      'ingredients': initial.ingredients ?? [],
    });
  }

  final form = fb.group({
    'title': [Validators.required],
    'portion': [Validators.number],
    'link': '',
    'steps': FormArray<String>([]),
    'ingredients': FormArray<String>([]),
  });

  FormArray<String> get steps => this.form.control('steps');
  FormArray<String> get ingredients => this.form.control('ingredients');

  setImage(File file) {
    setState(() {
      image = file;
    });
  }

  saveRecipe() async {
    setState(() {
      _isSaving = true;
    });

    if (image != null && image.existsSync()) {
      final uuid = Uuid();
      final ref = FirebaseStorage.instance.ref(uuid.v4());

      await ref.putFile(image);
      imageURL = await ref.getDownloadURL();
    }

    final steps = this
        .steps
        .controls
        .map((control) => control.value?.trim())
        .where((step) => step != null && step.length > 0)
        .toList();

    final ingredients = this
        .ingredients
        .controls
        .map((control) => control.value?.trim())
        .where((ingredient) => ingredient != null && ingredient.length > 0)
        .toList();

    Recipe result = Recipe(
      id: widget.initial?.id,
      title: form.value['title'],
      portion: int.parse(form.value['portion']),
      imageURL: imageURL,
      link: form.value['link'],
      steps: steps,
      ingredients: ingredients,
    );

    try {
      widget.onSave(result);

      Navigator.pop(context);
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageTag = widget.initial != null ? 'recipe/${widget.initial.id}' : null;

    return ReactiveForm(
        formGroup: form,
        child: Scaffold(
          appBar: AppBar(
            title: Container(
              alignment: Alignment.centerLeft,
              color: Colors.transparent,
              child: ReactiveTextField(
                formControlName: 'title',
                autofocus: true,
                decoration: InputDecoration(border: InputBorder.none, hintText: 'Recipe title'),
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
                onSubmitted: () => form.focus('link'),
              ),
            ),
            actions: [
              SubmitButton(saveRecipe),
            ],
          ),
          body: ListView(
            padding: EdgeInsets.all(15),
            children: <Widget>[
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ImagePickerEdit(
                  size: 120,
                  onChange: setImage,
                  file: image,
                  url: imageURL,
                  tag: imageTag,
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReactiveTextField(
                        formControlName: 'link',
                        decoration: InputDecoration(
                          labelText: 'Link',
                          filled: true,
                          isDense: true,
                        ),
                        keyboardType: TextInputType.url,
                        autocorrect: false,
                        textInputAction: TextInputAction.next,
                        onSubmitted: () => form.focus('portion'),
                      ),
                      SizedBox(height: 16),
                      ReactiveTextField(
                        formControlName: 'portion',
                        decoration: InputDecoration(
                          labelText: 'Portion count',
                          filled: true,
                          isDense: true,
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onSubmitted: () => form.focus('ingredients'),
                      ),
                    ],
                  ),
                )
              ]),
              SizedBox(height: 30),
              Text('Ingredients', style: headerStyle),
              ReactiveFormArray<String>(
                formArrayName: 'ingredients',
                builder: (context, formArray, child) => Column(
                  children: formArray.controls
                      .map((control) => ReactiveTextField(
                            key: ObjectKey(control),
                            formControl: control as FormControl<String>,
                            textCapitalization: TextCapitalization.sentences,
                            textInputAction: TextInputAction.next,
                            onSubmitted: () => formArray.focus('ingredients'),
                          ))
                      .toList(),
                ),
              ),
              IconButton(
                color: Colors.blue[800],
                icon: Icon(Icons.add, size: 48),
                onPressed: addIngredient,
              ),
              SizedBox(height: 15),
              Text('Steps', style: headerStyle),
              ReactiveFormArray<String>(
                formArrayName: 'steps',
                builder: (context, formArray, child) => Column(
                  children: formArray.controls
                      .map((control) => ReactiveTextField(
                            key: ObjectKey(control),
                            formControl: control as FormControl<String>,
                            textCapitalization: TextCapitalization.sentences,
                            textInputAction: TextInputAction.next,
                            onSubmitted: () => formArray.focus('steps'),
                          ))
                      .toList(),
                ),
              ),
              IconButton(
                color: Colors.blue[800],
                icon: Icon(Icons.add, size: 48),
                onPressed: addStep,
              ),
            ],
          ),
        ));
  }

  focusNextField() {
    FocusScope.of(context).nextFocus();
  }

  addIngredient() {
    final control = fb.control('');

    ingredients.add(control);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      control.focus();
    });
  }

  addStep() {
    final control = fb.control('');

    steps.add(control);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      control.focus();
    });
  }
}

class SubmitButton extends StatelessWidget {
  final onPress;

  SubmitButton(this.onPress);

  @override
  Widget build(BuildContext context) {
    final valid = ReactiveForm.of(context).valid;

    return IconButton(
      icon: Icon(Icons.save),
      onPressed: valid ? onPress : null,
    );
  }
}
