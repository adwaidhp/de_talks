import 'package:flutter/material.dart';
import 'package:de_talks/colors.dart';
import 'package:de_talks/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;
  int _selectedDay = DateTime.now().day;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.black,
              onPrimary: Colors.white,
              surface: AppColors.grey,
              onSurface: AppColors.black,
              secondary: AppColors.black,
              onSecondary: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.black,
              ),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.black,
              surface: AppColors.grey,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _showCustomDatePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: 300,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  color: AppColors.blackOverlay,
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Select Date',
                    style: AppTextStyles.bold.copyWith(
                      fontSize: 20,
                      color: AppColors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      // Month Selector
                      Expanded(
                        child: ListWheelScrollView(
                          itemExtent: 50,
                          children: List.generate(12, (index) {
                            return Center(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.black,
                                  fontWeight: _selectedMonth == index + 1
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            );
                          }),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedMonth = index + 1;
                              _selectedDate = DateTime(
                                  _selectedYear, _selectedMonth, _selectedDay);
                            });
                          },
                        ),
                      ),
                      // Day Selector
                      Expanded(
                        child: ListWheelScrollView(
                          itemExtent: 50,
                          children: List.generate(31, (index) {
                            return Center(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.black,
                                  fontWeight: _selectedDay == index + 1
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            );
                          }),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedDay = index + 1;
                              _selectedDate = DateTime(
                                  _selectedYear, _selectedMonth, _selectedDay);
                            });
                          },
                        ),
                      ),
                      // Year Selector
                      Expanded(
                        child: ListWheelScrollView(
                          itemExtent: 50,
                          children: List.generate(10, (index) {
                            int year = DateTime.now().year + index;
                            return Center(
                              child: Text(
                                '$year',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.black,
                                  fontWeight: _selectedYear == year
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            );
                          }),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedYear = DateTime.now().year + index;
                              _selectedDate = DateTime(
                                  _selectedYear, _selectedMonth, _selectedDay);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: AppColors.black.withOpacity(0.6),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'OK',
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/CreateEventsBg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create Event',
                    style: AppTextStyles.bold.copyWith(
                      fontSize: 24,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: AppColors.blackOverlay,
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _titleController,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle: TextStyle(color: AppColors.black),
                            filled: true,
                            fillColor: AppColors.grey,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12),
                              child: SvgPicture.asset(
                                'assets/icons/title.svg',
                                colorFilter: ColorFilter.mode(
                                  AppColors.black.withOpacity(0.6),
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: AppColors.blackOverlay,
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _descriptionController,
                          minLines: 2,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            labelStyle: TextStyle(color: AppColors.black),
                            filled: true,
                            fillColor: AppColors.grey,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12),
                              child: SvgPicture.asset(
                                'assets/icons/description.svg',
                                colorFilter: ColorFilter.mode(
                                  AppColors.black.withOpacity(0.6),
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: AppColors.blackOverlay,
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _locationController,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: 'Location',
                            labelStyle: TextStyle(color: AppColors.black),
                            filled: true,
                            fillColor: AppColors.grey,
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: AppColors.black.withOpacity(0.6),
                              size: 24,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: AppColors.blackOverlay,
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () => _showCustomDatePicker(context),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: SvgPicture.asset(
                                    'assets/icons/calendar.svg',
                                    colorFilter: ColorFilter.mode(
                                      AppColors.black.withOpacity(0.6),
                                      BlendMode.srcIn,
                                    ),
                                    height: 24,
                                    width: 24,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    _selectedDate == null
                                        ? 'Select Date'
                                        : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                                    style: TextStyle(color: AppColors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: AppColors.blackOverlay,
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () => _selectTime(context),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: SvgPicture.asset(
                                    'assets/icons/clock.svg',
                                    colorFilter: ColorFilter.mode(
                                      AppColors.black.withOpacity(0.6),
                                      BlendMode.srcIn,
                                    ),
                                    height: 24,
                                    width: 24,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    _selectedTime == null
                                        ? 'Select Time'
                                        : _selectedTime!.format(context),
                                    style: TextStyle(color: AppColors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Implement event creation
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.black,
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Create Event',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
