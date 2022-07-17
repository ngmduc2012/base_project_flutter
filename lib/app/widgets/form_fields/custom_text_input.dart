import 'package:flutter/material.dart';

class CustomTextInput extends FormField<String> {
  CustomTextInput({
    Key? key,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    TextEditingController? controller,
    TextInputAction textInputAction = TextInputAction.next,
    String labelText = "",
    bool enabled = true,
    String initialValue = "",
    FocusNode? focusNode,
    TextInputType keyboardType = TextInputType.text,
    ValueChanged<String>? onFieldSubmitted,
    ValueChanged<String>? onChanged,
  }) : super(
            key: key,
            onSaved: onSaved,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            initialValue: initialValue,
            builder: (FormFieldState<String> state) {
              return _CustomTextInput(
                controller: controller,
                validator: validator,
                enabled: enabled,
                labelText: labelText,
                initialValue: initialValue,
                keyboardType: keyboardType,
                onChanged: (value) {
                  state.didChange(value);
                  onChanged?.call(value);
                },
                state: state,
              );
            });
}

class _CustomTextInput extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputAction textInputAction;
  final String labelText;
  final String initialValue;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final bool enabled;
  final FormFieldState<String> state;

  const _CustomTextInput(
      {Key? key,
      this.controller,
      this.validator,
      this.enabled = true,
      this.labelText = "",
      this.onChanged,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      this.focusNode,
      this.onFieldSubmitted,
      this.initialValue = "",
      required this.state})
      : super(key: key);

  @override
  _CustomTextInputState createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<_CustomTextInput> {
  late FocusNode focusNode;
  late TextEditingController controller;

  TextStyle labelStyle = const TextStyle(color: Colors.black87, fontSize: 15.5);

  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();
    controller = widget.controller ?? TextEditingController();

    super.initState();
    focusNode.addListener(() {
      setState(() {
        if (focusNode.hasFocus) {
          labelStyle = const TextStyle(
              color: Colors.indigo,
              fontSize: 15.5,
              fontWeight: FontWeight.w500);
        } else {
          labelStyle = const TextStyle(
            color: Colors.black87,
            fontSize: 15.5,
          );
        }
      });
    });
    controller.text = widget.initialValue;
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        focusNode.requestFocus();
      },
      child: Container(
        height: 52,
        decoration: const BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(color: Colors.black12, width: 0.5))),
        child: Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            Text(
              widget.labelText,
              style: labelStyle,
            ),
            const SizedBox(
              width: 50,
            ),
            Expanded(
              child:
              // Text(widget.initialValue, textAlign: TextAlign.right ,),
              TextFormField(
                onChanged: (value) {
                  widget.onChanged?.call(value);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                enabled: widget.enabled,
                cursorColor: Colors.indigo,
                validator: widget.validator,
                keyboardType: widget.keyboardType,
                onFieldSubmitted: widget.onFieldSubmitted,
                textInputAction: widget.textInputAction,
                focusNode: focusNode,
                controller: controller,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  isDense: true,
                  filled: true,
                  contentPadding: const EdgeInsets.only(
                      top: 0, left: 0, right: 0, bottom: 0),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  errorStyle: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                focusNode.requestFocus();
                widget.controller?.selection = TextSelection.collapsed(
                  offset: widget.controller?.text.length ?? 0,
                );
              },
              behavior: HitTestBehavior.translucent,
              child: const SizedBox(
                height: 52,
                width: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
