import 'package:file_handler/providers/extensions/available_extensions_provider.dart';
import 'package:file_handler/providers/extensions/selected_extensions_provider.dart';
import 'package:file_handler/widgets/app_checkbox.dart';
import 'package:file_handler/widgets/app_choice_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AvailableExtensions extends ConsumerWidget {
  const AvailableExtensions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availableExtensions = ref.watch(availableExtensionsProvider);
    final selectedExtensions = ref.watch(selectedExtensionsProvider);
    final selectedExtensionsNotifier =
        ref.read(selectedExtensionsProvider.notifier);

    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('File extensions'),
          const Text(
            'Extensions of the files you want to handle',
            style: TextStyle(height: 2, fontSize: 10, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (availableExtensions.length > 1)
                AppCheckbox(
                  title: 'Select all',
                  value:
                      selectedExtensions.length == availableExtensions.length,
                  onChanged: (selected) {
                    if (selected!) {
                      selectedExtensionsNotifier
                          .addAllExtensions(availableExtensions);
                    } else {
                      selectedExtensionsNotifier.removeAllExtensions();
                    }
                  },
                ),
              if (availableExtensions.length > 1) const VerticalDivider(),
              ...availableExtensions.map(
                (extension) => AppChoiceChip(
                  showCheckmark: false,
                  title: extension,
                  selected: selectedExtensions.contains(extension),
                  onSelected: (selected) {
                    selectedExtensionsNotifier.toggleExtension(extension);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
