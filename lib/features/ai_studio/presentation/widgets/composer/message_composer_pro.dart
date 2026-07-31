/// AI Composer Pro Component (Amendment 3.1J, 3.1M)
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/features/ai_studio/application/message_streaming_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Premium AI Composer component supporting multi-line input, slash commands, token estimation, and attachments.
class MessageComposerPro extends ConsumerStatefulWidget {
  /// Creates a [MessageComposerPro].
  const MessageComposerPro({
    required this.conversationId,
    required this.onOpenPromptLibrary,
    super.key,
  });

  final String conversationId;
  final VoidCallback onOpenPromptLibrary;

  @override
  ConsumerState<MessageComposerPro> createState() => _MessageComposerProState();
}

class _MessageComposerProState extends ConsumerState<MessageComposerPro> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  int _estimatedTokens = 0;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textController
      ..removeListener(_onTextChanged)
      ..dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final text = _textController.text;
    setState(() {
      // Rough token estimation (~4 chars per token)
      _estimatedTokens = text.trim().isEmpty ? 0 : (text.length / 3.8).ceil();
    });
  }

  void _handleSend() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    ref
        .read(messageStreamingControllerProvider.notifier)
        .sendPrompt(conversationId: widget.conversationId, promptText: text);

    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final streamState = ref.watch(messageStreamingControllerProvider);
    final isGenerating = streamState.status.isGenerating;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Color(0xFF1E242E),
        border: Border(top: BorderSide(color: Color(0xFF2B323E))),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Input Container Surface
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF262D38),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: _focusNode.hasFocus
                    ? AppColors.primary
                    : const Color(0xFF3D4655),
              ),
            ),
            child: Column(
              children: [
                // Text Field Input
                KeyboardListener(
                  focusNode: FocusNode(),
                  onKeyEvent: (event) {
                    if (event is KeyDownEvent &&
                        event.logicalKey == LogicalKeyboardKey.enter &&
                        !HardwareKeyboard.instance.isShiftPressed) {
                      _handleSend();
                    }
                  },
                  child: TextField(
                    controller: _textController,
                    focusNode: _focusNode,
                    minLines: 1,
                    maxLines: 5,
                    style: const TextStyle(color: Colors.white, fontSize: 14.0),
                    decoration: const InputDecoration(
                      hintText:
                          'Ask AI Hustle Co-Pilot or type / for templates...',
                      hintStyle: TextStyle(
                        color: Color(0xFF777777),
                        fontSize: 14.0,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),

                const SizedBox(height: 8.0),

                // Controls & Token Counter Row
                Row(
                  children: [
                    // Prompt Library Shortcut
                    IconButton(
                      onPressed: widget.onOpenPromptLibrary,
                      tooltip: 'Prompt Templates (/)',
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.all(4.0),
                      icon: const Icon(
                        Icons.auto_awesome_motion_rounded,
                        color: Color(0xFF777777),
                        size: 18.0,
                      ),
                    ),

                    const SizedBox(width: 8.0),

                    // Attachment Trigger Placeholder
                    IconButton(
                      onPressed: () {},
                      tooltip: 'Attach Image / File',
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.all(4.0),
                      icon: const Icon(
                        Icons.attach_file_rounded,
                        color: Color(0xFF777777),
                        size: 18.0,
                      ),
                    ),

                    const Spacer(),

                    // Live Token Estimator Badge
                    if (_estimatedTokens > 0)
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Text(
                          '~$_estimatedTokens tokens',
                          style: const TextStyle(
                            color: Color(0xFF777777),
                            fontSize: 11.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                    // Send / Stop Action Button
                    Material(
                      color: isGenerating
                          ? Colors.redAccent
                          : AppColors.primary,
                      borderRadius: BorderRadius.circular(10.0),
                      child: InkWell(
                        onTap: isGenerating
                            ? () => ref
                                  .read(
                                    messageStreamingControllerProvider.notifier,
                                  )
                                  .stopGeneration()
                            : _handleSend,
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          width: 36.0,
                          height: 36.0,
                          alignment: Alignment.center,
                          child: Icon(
                            isGenerating
                                ? Icons.stop_rounded
                                : Icons.arrow_upward_rounded,
                            color: Colors.white,
                            size: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
