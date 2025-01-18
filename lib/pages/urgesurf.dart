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
    0, // UrgeSurfing
    4000, // This is a practice...
    20000, // Oftentimes we experience...
    30000, // So this is an exercise...
    40000, // You may be listening...
    50000, // So begin by just finding...
    60000, // Just doing your best...
    70000, // And just acknowledging...
    80000, // And maybe acknowledging...
    90000, // And feeling what it's like...
    100000, // Perhaps it's increasing...
    110000, // If it is increasing...
    120000, // So as you do this...
    130000, // And maybe looking too...
    140000, // So often when we experience...
    150000, // Again, being kind...
    160000, // Noticing that for the past...
    170000, // Taking a deep breath now...
    180000, // The waves may return...
    190000, // Releasing tension...
    200000, // For as long as you need to...
    210000, // And whenever you need to.
  ];

  // Transcript lines
  final List<String> _transcript = [
    "UrgeSurfing.",
    "This is a practice that invites us to relate differently to the experience of cravings or urges to use substances or really engage in any sort of reactive behavior.",
    "Oftentimes we experience very strong cravings, which may be accompanied by thoughts or urges to behave in a certain way. And if we're on a sort of automatic pilot mode, which many of us often are in much of our lives, we are very vulnerable to reacting to these, trying to meet our needs in a way that isn't actually useful in the long term, isn't actually helping us out.",
    "So this is an exercise to help learn how to relate differently to these experiences.",
    "You may be listening to this recording at this time because you're experiencing a craving or an urge to behave or react in a certain way. So let's begin by just pausing here. You might just take a deep breath if that's helpful. And just committing to staying with this feeling, just for a few moments without reacting, just seeing what that's like. The worst things that these feelings can do is make us feel them, so we're just going to spend the next few minutes staying with feelings that may be somewhat uncomfortable, but that actually aren't threatening to us in any other way. Oftentimes our reactions to these feelings are what's most harmful, not the feelings themselves.",
    "So begin by just finding a comfortable position, whatever that is for you right now. You can lie down, you can sit, you can even stand if you want.",
    "Just doing your best to release any tension that you might be holding in your body right now. Maybe the jaw, the belly, just letting those relax, the shoulders, the back, so that the breath can just easily come in and out of the body.",
    "And just acknowledging right now what you're feeling. What is it that's present in your body right now? Is there physical discomfort? Is there perhaps an emotion that's uncomfortable for you? Maybe thoughts that are familiar or troubling that are in your mind? Things that you're telling yourself right now. Just acknowledging what's happening.",
    "And maybe acknowledging your reaction to what's happening: I like this experience, I don't like this experience.",
    "And feeling what it's like to just stay here with whatever is happening, without the need to control it. Without the need to try and get rid of it. And perhaps most importantly, without the need to react to it by engaging in a behavior that's not actually helpful to you.",
    "Perhaps it's increasing or decreasing in intensity.",
    "If it is increasing, you might imagine it like a wave. That rises and rises. And oftentimes with cravings it can feel as though it's going to keep going up and up and up until we fix it, until we react to it, until we stop it. But what we actually know about cravings and all intense emotional and physical experiences is that they often rise and then if we just stay with them, and if we don't react to them and just let them be, staying calm, using the breath to help us ground, oftentimes these experiences just like waves will reach a point where they crest and then eventually they come down again, they fade. So our job is to just stay with them and ride this wave, almost like we're surfing. Staying right on top of this experience. Sometimes it's helpful to use the breath as a way to stay. Almost like the breath is our surfboard that's helping us stay with this, stay on top of this, instead of being wiped out by it.",
    "So as you do this, you might even see if you can find some curiosity about this experience. What does this actually feel like in the body? What is the mind doing? What emotions are here?",
    "And maybe looking too at what's really needed. What is it that you're actually craving or needing in this moment?",
    "So often when we experience craving or urges to react in a certain way or to use substances, it's not actually that substance that we're craving. There's actually a deeper need beneath that craving. For some people it might be feeling a sense of loneliness and wanting some company. Or feeling stressed or a difficult emotion and just wanting some relief. For others it may be wanting freedom–from their present circumstances, from the emotions that are so intense, from their mind. So just maybe asking yourself this question: What do I really want right now? What do I really need?",
    "Again, being kind and gentle with yourself.",
    "Noticing that for the past several minutes now you've stayed present. Stayed with this experience rather than reacting to it. And noticing that you always have this choice. When you begin to recognize these urges and cravings, no matter how strong they are, no matter what's happening in your body, whatever your mind is telling you, whatever you're saying to yourself, whatever emotions might be present, whatever sense of desperation or anxiety, you do have a choice. It's not an easy thing to do to stay with it. And as you know in the long run, it is far more nourishing than reaching for something that may temporarily relieve your suffering, but in the long run adds to it.",
    "Taking a deep breath now. And staying with this as long as you need to.",
    "The waves may return, they may continue to rise and fall, and you can just stay with a sense of surfing.",
    "Releasing tension again and again.",
    "For as long as you need to.",
    "And whenever you need to.",
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
        color: AppColors.black,
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
