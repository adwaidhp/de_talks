import 'package:flutter/material.dart';
import 'package:de_talks/colors.dart';
import 'dart:math' show pi;
import 'dart:math' show Random;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:de_talks/text_styles.dart';

class Event {
  final String title;
  final String description;
  final String venue;
  final DateTime date;
  final bool isEditable;
  final bool isDeletable;

  const Event({
    required this.title,
    required this.description,
    required this.venue,
    required this.date,
    required this.isEditable,
    required this.isDeletable,
  });
}

class EventCard extends StatefulWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool _isFlipped = false;

  void _toggleCard() {
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  void _handleEdit() {
    print('editCalled');
  }

  void _handleDelete() {
    print('deleteCalled');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.90,
        child: GestureDetector(
          onTap: _toggleCard,
          child: TweenAnimationBuilder(
            tween: Tween<double>(
              begin: 0,
              end: _isFlipped ? pi : 0,
            ),
            duration: const Duration(milliseconds: 500),
            builder: (context, double value, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(value),
                child: value >= pi / 2
                    ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateX(pi),
                        child: _buildBackCard(),
                      )
                    : _buildFrontCard(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFrontCard() {
    return Stack(
      children: [
        GestureDetector(
          onTap: _toggleCard,
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 12,
            ),
            padding: const EdgeInsets.all(16),
            height: 150,
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                ),
              ],
            ),
            child: Center(
              child: Text(
                widget.event.title,
                textAlign: TextAlign.center,
                style: AppTextStyles.bold.copyWith(
                  fontSize: 24,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ),
        if (widget.event.isDeletable)
          Positioned(
            top: 25,
            right: 24,
            child: GestureDetector(
              onTap: _handleDelete,
              child: SvgPicture.asset(
                'assets/icons/Trash.svg',
                colorFilter: const ColorFilter.mode(
                  Colors.red,
                  BlendMode.srcIn,
                ),
                height: 24,
                width: 24,
              ),
            ),
          ),
        if (widget.event.isEditable)
          Positioned(
            bottom: 16,
            right: 24,
            child: GestureDetector(
              onTap: _handleEdit,
              child: SvgPicture.asset(
                'assets/icons/Edit.svg',
                colorFilter: ColorFilter.mode(
                  AppColors.black.withOpacity(0.6),
                  BlendMode.srcIn,
                ),
                height: 24,
                width: 24,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildBackCard() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 12,
      ),
      padding: const EdgeInsets.all(16),
      height: 150,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 4,
            color: Color.fromRGBO(0, 0, 0, 0.25),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.event.description,
              style: AppTextStyles.bold.copyWith(
                fontSize: 14,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    widget.event.venue,
                    style: AppTextStyles.bold.copyWith(
                      fontSize: 14,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 4),
                Text(
                  '${widget.event.date.day}/${widget.event.date.month}/${widget.event.date.year} at ${widget.event.date.hour}:${widget.event.date.minute.toString().padLeft(2, '0')}',
                  style: AppTextStyles.bold.copyWith(
                    fontSize: 14,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  static final Random _random = Random();
  static final List<Event> events = [
    Event(
      title: 'Recovery Support Group Meeting',
      description:
          'Join our weekly support group meeting where individuals share their recovery journeys, challenges, and victories. Open to all individuals in recovery and their families.',
      venue: 'Community Center, Kochi',
      date: DateTime(2024, 3, 25, 18, 30),
      isEditable: true,
      isDeletable: true,
    ),
    Event(
      title: 'Mindfulness Workshop for Recovery',
      description:
          'Learn practical mindfulness techniques to manage cravings and maintain sobriety. Led by certified mindfulness practitioners with experience in addiction recovery.',
      venue: 'Wellness Center, Trivandrum',
      date: DateTime(2024, 4, 2, 10, 0),
      isEditable: true,
      isDeletable: true,
    ),
    Event(
      title: 'Family Support Workshop',
      description:
          'A workshop designed for families of individuals struggling with addiction. Learn about addiction, recovery, and how to support your loved ones while maintaining your own well-being.',
      venue: 'District Hospital Conference Room, Calicut',
      date: DateTime(2024, 4, 10, 14, 0),
      isEditable: true,
      isDeletable: true,
    ),
    Event(
      title: 'Art Therapy Session',
      description:
          'Express yourself through art in this therapeutic session designed for individuals in recovery. No artistic experience required. Materials will be provided.',
      venue: 'Creative Arts Center, Kochi',
      date: DateTime(2024, 4, 15, 16, 0),
      isEditable: true,
      isDeletable: false,
    ),
    Event(
      title: 'Career Rehabilitation Workshop',
      description:
          'Get guidance on resume building, job searching, and interview skills. Special focus on addressing employment gaps and recovery in professional settings.',
      venue: 'Employment Resource Center, Trivandrum',
      date: DateTime(2024, 4, 20, 11, 0),
      isEditable: false,
      isDeletable: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/HomePageBg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: Text(
                  'My Events',
                  style: AppTextStyles.heading1.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ...events.map((event) => EventCard(event: event)).toList(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: FloatingActionButton(
          onPressed: () {
            // Add event creation logic here
          },
          backgroundColor: AppColors.black,
          child: SvgPicture.asset(
            'assets/icons/plus.svg',
            colorFilter: const ColorFilter.mode(
              AppColors.darkBlueContrast,
              BlendMode.srcIn,
            ),
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
