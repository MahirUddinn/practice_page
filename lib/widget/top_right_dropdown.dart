import 'package:flutter/material.dart';

class TopRightDropdown extends StatefulWidget {
  const TopRightDropdown({super.key, required this.items});
  final List<String> items;

  @override
  State<TopRightDropdown> createState() => _TopRightDropdownState();
}

class _TopRightDropdownState extends State<TopRightDropdown> {

  String? selectedValue = 'Annual';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 25,
      padding: EdgeInsets.only(),
      decoration: BoxDecoration(
          color: Color(0xFF262F40),
          borderRadius: BorderRadius.circular(5)),
      child: DropdownButton<String>(
        underline: SizedBox(),

        value: selectedValue,
        items: widget.items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Text(value)),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!;
          });
        },
        dropdownColor: Color(0xFF262F40),
        style: TextStyle(
            color: Color(0xFFA6B0BC,),
            fontSize: 12
        ),

      ),
    );  }
}
