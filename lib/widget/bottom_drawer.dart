import 'package:flutter/material.dart';
import 'package:new_screen_project/data/income_data.dart';

class BottomDrawer extends StatefulWidget {
  const BottomDrawer({super.key});

  @override
  State<BottomDrawer> createState() => _BottomDrawerState();
}

class _BottomDrawerState extends State<BottomDrawer> {
  Widget _buildNamedBox(String text) {
    return Container(
      height: 50,
      width: 120,
      color: Color(0xFF2D2D2D),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xFFF3F3F3),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildBox(String text, Color color) {
    return Container(
      height: 50,
      width: 120,
      color: Color(0xFF222222),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: color, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.hardEdge,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                _buildNamedBox("Quarterly/Annual"),
                Divider(height: 1, color: Colors.black),
                _buildNamedBox("Current"),
                Divider(height: 1, color: Colors.black),
                _buildNamedBox("Previous"),
              ],
            ),

            Row(
              children: dummyIncomeData.map((item) {
                return Column(
                  children: [
                    _buildBox(item.date, Color(0xFFF3F3F3)),
                    Divider(height: 1, color: Colors.black),
                    _buildBox(item.current.toString(), Color(0xFFAEAEAE)),
                    Divider(height: 1, color: Colors.black),
                    _buildBox(item.previous.toString(), Color(0xFFAEAEAE)),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
