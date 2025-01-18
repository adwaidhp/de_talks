import 'package:flutter/material.dart';
import 'package:de_talks/colors.dart';
import 'package:de_talks/text_styles.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';

class UrgeSurfingPage extends StatefulWidget {
  const UrgeSurfingPage({super.key});

  @override
  State<UrgeSurfingPage> createState() => _UrgeSurfingPageState();
}

class _UrgeSurfingPageState extends State<UrgeSurfingPage> {
  final AudioPlayer _player = AudioPlayer();
  int _currentLineIndex = -1;
  bool _isPlaying = false;

  // Timestamps in milliseconds for each line
  final List<int> _timestamps = [
    0, 3000, 6000, 9000, 12000, 15000, // Add actual timestamps here
  ];

  // Transcript lines
  final List<String> _transcript = [
    "Close your eyes and take a deep breath.",
    "Feel the air flowing through your body.",
    "Notice the urge you're experiencing.",
    "Don't try to fight it or push it away.",
    "Instead, observe it like a wave in the ocean.",
    "Watch as it rises, peaks, and eventually falls.",
    // Add all transcript lines
  ];

  @override
  void initState() {
    super.initState();
    _initAudio();
  }

  Future<void> _initAudio() async {
    // Configure audio session
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    // Load the audio file
    await _player.setAsset('assets/audio/urge.mp3');

    // Listen to audio position changes
    _player.positionStream.listen((position) {
      int currentMs = position.inMilliseconds;
      int newIndex =
          _timestamps.indexWhere((timestamp) => currentMs < timestamp) - 1;
      if (newIndex == -2) newIndex = _timestamps.length - 1;

      if (newIndex != _currentLineIndex) {
        setState(() => _currentLineIndex = newIndex);
      }
    });

    // Listen to player state changes
    _player.playerStateStream.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state.playing;
          if (state.processingState == ProcessingState.completed) {
            _currentLineIndex = -1;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/SurfingBg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      'Urge Surfing',
                      style: AppTextStyles.heading1,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 12,
                        color: AppColors.blackOverlay,
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    itemCount: _transcript.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          _transcript[index],
                          style: TextStyle(
                            fontSize: 20,
                            color: _currentLineIndex == index
                                ? AppColors.black
                                : AppColors.black.withOpacity(0.6),
                            fontWeight: _currentLineIndex == index
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: FloatingActionButton(
                  onPressed: () {
                    if (_isPlaying) {
                      _player.pause();
                    } else {
                      _player.seek(Duration.zero);
                      _player.play();
                    }
                  },
                  backgroundColor: AppColors.black,
                  child: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    color: AppColors.darkBlueContrast,
                    size: 32,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
