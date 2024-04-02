import 'package:flutter/material.dart';
import 'package:chatbot1/screens/Text_and_voice_field.dart'; // Importing InputMode enum

class ToggleButton extends StatefulWidget {
  final VoidCallback _sendTextMessage;
  final VoidCallback _sendVoiceMessage;
  final InputMode _inputMode;
  final bool _isReplying;
  final bool _isListening;

  const ToggleButton({
    Key? key,
    required InputMode inputMode,
    required VoidCallback sendTextMessage,
    required VoidCallback sendVoiceMessage,
    required bool isReplying,
    required bool isListening,
  })  : _inputMode = inputMode,
        _sendTextMessage = sendTextMessage,
        _sendVoiceMessage = sendVoiceMessage,
        _isReplying = isReplying,
        _isListening = isListening,
        super(key: key);

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(15),
      ),
      onPressed: widget._isReplying
          ? null // Disable button if user is replying
          : widget._inputMode == InputMode.text
              ? widget._sendTextMessage // Send text message when in text mode
              : widget._sendVoiceMessage, // Send voice message when in voice mode
      child: Icon(
        widget._inputMode == InputMode.text
            ? Icons.send // Show send icon if in text mode
            : widget._isListening
                ? Icons.mic // Show mic icon if in voice mode and listening
                : Icons.mic_off, // Show mic off icon if in voice mode and not listening
      ),
    );
  }
}
