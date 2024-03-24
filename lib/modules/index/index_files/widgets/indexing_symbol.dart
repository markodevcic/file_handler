import 'package:file_handler/constants.dart';
import 'package:file_handler/providers/index_files/index_symbol_provider.dart';
import 'package:file_handler/widgets/app_choice_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IndexingSymbol extends ConsumerWidget {
  const IndexingSymbol({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexingSymbol = ref.watch(indexSymbolProvider);
    final indexingSymbolNotifier = ref.read(indexSymbolProvider.notifier);

    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Symbol'),
          const Text(
            'The symbol that will be used to index the files',
            style: TextStyle(height: 2, fontSize: 10, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              for (final symbol in indexingSymbols)
                AppChoiceChip(
                  title: '01${symbol}example.jpg',
                  selected: indexingSymbol == symbol,
                  onSelected: (isSelected) {
                    if (isSelected) {
                      indexingSymbolNotifier.set(symbol);
                    }
                  },
                )
            ],
          ),
        ],
      ),
    );
  }
}
