import 'package:DevQuiz/core/core.dart';
import 'package:DevQuiz/shared/models/answer_model.dart';
import 'package:flutter/material.dart';

class AnwserWidget extends StatelessWidget {
  final AnswerModel answer;
  final bool isSelected;
  final ValueChanged<bool> onTap;
  final bool disable;

  const AnwserWidget({
    Key? key,
    required this.answer,
    this.isSelected = false,
    required this.onTap,
    this.disable = false,
  }) : super(key: key);

  Color get _selectedColorRight => answer.isRight ? AppColors.darkGreen : AppColors.darkRed;
  Color get _selectedBorderRight => answer.isRight ? AppColors.lightGreen : AppColors.lightRed;
  Color get _selectedColorCardRight => answer.isRight ? AppColors.lightGreen : AppColors.lightRed;
  Color get _selectedBorderCardRight => answer.isRight ? AppColors.green : AppColors.red;
  TextStyle get _selectedTextStyleRight => answer.isRight ? AppTextStyles.bodyDarkGreen : AppTextStyles.bodyDarkRed;
  IconData get _selectedIconRight => answer.isRight ? Icons.check : Icons.close;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16, 
        vertical: 4,
      ),
      child: IgnorePointer(
        ignoring: disable,
        child: GestureDetector(
          onTap: () {
            onTap(answer.isRight);
          },
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected ? _selectedColorCardRight : AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.fromBorderSide(BorderSide(
                color: isSelected ? _selectedBorderCardRight : AppColors.border,
              )),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    answer.title,
                    style: isSelected ? _selectedTextStyleRight : AppTextStyles.body,
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isSelected ? _selectedColorRight : AppColors.white,
                    borderRadius: BorderRadius.circular(500),
                    border: Border.fromBorderSide(BorderSide(
                      color: isSelected ? _selectedBorderRight : AppColors.border
                    )),
                  ),
                  child: isSelected 
                  ? Icon(
                      _selectedIconRight,
                      size: 16,
                      color: Colors.white,
                    )
                  : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
