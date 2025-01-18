import 'package:de_talks/models/events.dart';
import 'package:de_talks/pages/create_events.dart';
import 'package:de_talks/pages/edit_events.dart';
import 'package:de_talks/services/event_service.dart';
import 'package:flutter/material.dart';
import 'package:de_talks/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:de_talks/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math' show pi;

class EventCard extends StatefulWidget {
  final EventModel event;
  final Function() onDelete;
  final Function() onEdit;
  final Function() onRegister;
  final Function() onUnregister;
  final bool isRegistered;

  const EventCard({
    super.key,
    required this.event,
    required this.onDelete,
    required this.onEdit,
    required this.onRegister,
    required this.onUnregister,
    required this.isRegistered,
  });

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

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final isOrganizer = widget.event.organizerId == currentUserId;

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.90,
        child: GestureDetector(
          onTap: _toggleCard,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: _isFlipped ? pi : 0),
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
                    : _buildFrontCard(isOrganizer),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFrontCard(bool isOrganizer) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
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
        if (isOrganizer) ...[
          Positioned(
            top: 25,
            right: 24,
            child: GestureDetector(
              onTap: widget.onDelete,
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
          Positioned(
            bottom: 16,
            right: 24,
            child: GestureDetector(
              onTap: widget.onEdit,
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
      ],
    );
  }

  Widget _buildBackCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
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
                ],
              ),
            ),
          ),
          if (widget.event.organizerId !=
              FirebaseAuth.instance.currentUser!.uid)
            ElevatedButton(
              onPressed:
                  widget.isRegistered ? widget.onUnregister : widget.onRegister,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    widget.isRegistered ? Colors.red : AppColors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                widget.isRegistered ? 'Unregister' : 'Register',
                style: const TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}

class EventsPage extends StatefulWidget {
  EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final EventService _eventService = EventService();
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/HomePageBg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder<List<EventModel>>(
          stream: _eventService.getUpcomingEvents(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final events = snapshot.data ?? [];

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: Text(
                      'Upcoming Events.',
                      style: AppTextStyles.heading1.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ...events.map((event) => EventCard(
                        event: event,
                        isRegistered: event.attendeeIds.contains(currentUserId),
                        onDelete: () async {
                          if (event.organizerId == currentUserId) {
                            try {
                              await _eventService.deleteEvent(event.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Event deleted successfully')),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Error deleting event: $e')),
                              );
                            }
                          }
                        },
                        onEdit: () {
                          if (event.organizerId == currentUserId) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditEventPage(event: event)),
                            );
                          }
                        },
                        onRegister: () async {
                          try {
                            await _eventService.registerForEvent(
                                event.id, currentUserId);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Registered for event successfully')),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Error registering for event: $e')),
                            );
                          }
                        },
                        onUnregister: () async {
                          try {
                            await _eventService.unregisterFromEvent(
                                event.id, currentUserId);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Unregistered from event successfully')),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Error unregistering from event: $e')),
                            );
                          }
                        },
                      )),
                  const SizedBox(height: 100),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 5,
        ),
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: _isHovered ? 120 : 60,
            height: 60,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreatePage()),
                );
              },
              backgroundColor: AppColors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 4.0,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.centerRight,
                children: [
                  if (_isHovered)
                    Positioned(
                      right: 60,
                      child: const Text(
                        'Create',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  Positioned(
                    right: 15,
                    child: SvgPicture.asset(
                      'assets/icons/plus.svg',
                      colorFilter: const ColorFilter.mode(
                        AppColors.darkBlueContrast,
                        BlendMode.srcIn,
                      ),
                      height: 30,
                      width: 30,
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
