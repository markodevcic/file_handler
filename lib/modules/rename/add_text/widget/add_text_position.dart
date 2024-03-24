import 'package:file_handler/providers/rename_files/add_text_position_provider.dart';
import 'package:file_handler/widgets/app_choice_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTextPosition extends ConsumerWidget {
  const AddTextPosition({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textPosition = ref.watch(addTextPositionProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Position'),
          const Text(
            'At which position of the file name the text should be added',
            style: TextStyle(height: 2, fontSize: 10, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              AppChoiceChip(
                title: 'Beginning',
                selected: textPosition == Position.BEGINNING,
                onSelected: (selected) {
                  if (selected) {
                    ref
                        .read(addTextPositionProvider.notifier)
                        .setAddTextPosition(Position.BEGINNING);
                  }
                },
              ),
              const SizedBox(width: 8),
              AppChoiceChip(
                title: 'Beginning + space',
                selected: textPosition == Position.BEGINNING_PLUS_SPACE,
                onSelected: (selected) {
                  if (selected) {
                    ref
                        .read(addTextPositionProvider.notifier)
                        .setAddTextPosition(Position.BEGINNING_PLUS_SPACE);
                  }
                },
              ),
              const SizedBox(width: 8),
              AppChoiceChip(
                title: 'End',
                selected: textPosition == Position.END,
                onSelected: (selected) {
                  if (selected) {
                    ref
                        .read(addTextPositionProvider.notifier)
                        .setAddTextPosition(Position.END);
                  }
                },
              ),
              const SizedBox(width: 8),
              AppChoiceChip(
                title: 'Space + end',
                selected: textPosition == Position.SPACE_PLUS_END,
                onSelected: (selected) {
                  if (selected) {
                    ref
                        .read(addTextPositionProvider.notifier)
                        .setAddTextPosition(Position.SPACE_PLUS_END);
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
