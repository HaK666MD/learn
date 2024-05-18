import 'package:flutter/material.dart';
import 'package:learn/ui/screens/gallery/download_provider.dart';
import 'package:provider/provider.dart';

class DownloadProgressDialog extends StatelessWidget {
  const DownloadProgressDialog({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    Provider.of<DownloadProvider>(context, listen: false).startDownload(url);
    return AlertDialog(
      content: Consumer<DownloadProvider>(
        builder: (_, downloadProvider, __) {
          String downloadingProgress = (downloadProvider.progress * 100).toInt().toString();
          if (downloadProvider.progress == 1.0) Navigator.of(context).pop();
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  'Downloading',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              LinearProgressIndicator(
                value: downloadProvider.progress,
                backgroundColor: Colors.grey,
                color: Colors.green,
                minHeight: 10,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text('$downloadingProgress %'),
              ),
            ],
          );
        },
      ),
    );
  }
}
