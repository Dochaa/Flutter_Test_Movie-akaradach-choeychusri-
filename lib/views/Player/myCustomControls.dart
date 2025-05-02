import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';

class MyCustomControls extends StatelessWidget {

  final Map<String, String> videoUrls;
  final String currentQuality;
  final void Function(String) onQualityChange;

  const MyCustomControls({
    super.key,
    required this.videoUrls,
    required this.currentQuality,
    required this.onQualityChange,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MaterialControls(),
        Positioned(
          right: 8,
          top: 8,
          child: PopupMenuButton<String>(
            color: Colors.black,
            icon: Icon(Icons.more_vert, color: Colors.white),
            itemBuilder: (context) => [
              PopupMenuItem(
                enabled: false,
                child: Text('Quality', style: TextStyle(color: Colors.white70)),
              ),
              ...videoUrls.keys.map((quality) => PopupMenuItem<String>(
                    value: quality,
                    child: Row(
                      children: [
                        if (quality == currentQuality)
                          Icon(Icons.check, size: 16, color: Colors.cyanAccent),
                        if (quality != currentQuality)
                          SizedBox(width: 16),
                        SizedBox(width: 8),
                        Text(quality, style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  )),
            ],
            onSelected: (selected) {
              onQualityChange(selected);
            },
          ),
        ),
      ],
    );
  }
}
