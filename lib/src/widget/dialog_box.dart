import 'package:airmid/src/provider/bolc/admission_list/admision_nursinglist/admision_nursinglist_bloc.dart';
import 'package:airmid/src/widget/button.dart';
import 'package:airmid/src/widget/sizedbox.dart';
import 'package:airmid/src/widget/text_file.dart';
import 'package:flutter/material.dart';

class FxDialogBox extends StatefulWidget {
  final bool doctorId;
  final String? titleText;
  final String? subTitle;
  final TextEditingController? textfiledController;
  final String? butttonName1;
  final String? butttonName2;
  final String? lableText;
  final GlobalKey<FormState>? formKey;
  final String? validationMsg;
  final AdmiteedPatientDataBloc admiteedPatientList;
  const FxDialogBox(
      {super.key,
      this.titleText,
      this.subTitle,
      this.textfiledController,
      this.butttonName1,
      this.butttonName2,
      this.lableText,
      this.formKey,
      this.validationMsg,
      this.doctorId = false,
      required this.admiteedPatientList});

  @override
  State<FxDialogBox> createState() => _FxDialogBoxState();
}

class _FxDialogBoxState extends State<FxDialogBox> {
  @override
  void dispose() {
    widget.textfiledController?.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.titleText ?? ""),
      content: Form(
        key: widget.formKey,
        child: FxTextFormField(
          controller: widget.textfiledController,
          label: Text(widget.lableText ?? ""),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return widget.validationMsg;
            }
            return null;
          },
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: FxButton(
                onTap: () => Navigator.of(context).pop(),
                buttonName: widget.butttonName1 ?? "",
              ),
            ),
            FxBox.w20,
            Expanded(
              child: FxButton(
                onTap: () {
                  if (widget.formKey?.currentState!.validate() ?? false) {
                    Navigator.of(context).pop();
                    widget.admiteedPatientList.add(
                      AdmittedPatientDataEvent.started(
                        // doctorId:
                        //     widget.doctorId ? widget.textfiledController?.text : "",
                        doctorId: "",
                        wardId: widget.doctorId
                            ? 0
                            : int.parse(widget.textfiledController?.text ?? ""),
                      ),
                    );
                    widget.textfiledController?.clear();
                  }
                },
                buttonName: widget.butttonName2 ?? "",
              ),
            ),
          ],
        )
      ],
    );
  }
}
