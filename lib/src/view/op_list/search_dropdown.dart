// ignore_for_file: must_be_immutable

import 'package:airmid/src/constant/color.dart';
import 'package:airmid/src/provider/bolc/appoiment/appoiment_registation/get_appoiment_registation/get_appoiment_registation_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FxDropdownButton extends StatelessWidget {
  final List<String> item;
  final List<String> id;

  FxDropdownButton({
    super.key,
    required this.item,
    required this.id,
  });

  ValueNotifier<String> dropdownValue = ValueNotifier<String>('all');

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: dropdownValue,
      builder: (context, value, child) => DropdownButton2<String>(
        underline: const SizedBox.square(),
        value: value,
        style: const TextStyle(color: Colors.black, fontSize: 16),
        isExpanded: true,
        dropdownStyleData: const DropdownStyleData(width: 150),
        buttonStyleData: ButtonStyleData(
          height: 40,
          width: 150,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: ConstColor.black,
            ),
            color: ConstColor.white,
          ),
          elevation: 2,
        ),
        onChanged: (String? newValue) {
          dropdownValue.value = newValue!;

          if (newValue != 'all') {
            context.read<GetAppoimentRegistationBloc>().add(
                  GetAppoimentRegistationEvent.started(
                    newValue,
                  ),
                );
          } else {
            context.read<GetAppoimentRegistationBloc>().add(
                  GetAppoimentRegistationEvent.started(
                    newValue,
                  ),
                );
          }
        },
        items: item.map<DropdownMenuItem<String>>(
          (String value) {
            return DropdownMenuItem<String>(
              value: id[item.indexOf(value)],
              child: Text(
                value,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
